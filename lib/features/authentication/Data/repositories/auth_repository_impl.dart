import 'package:aqar_hub_gp/features/authentication/domain/entities/user_entity.dart';
import 'package:aqar_hub_gp/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/enums/user_role.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<String, UserEntity>> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await remoteDataSource.signInWithEmail(
        email,
        password,
      );
      final uid = userCredential.user!.uid;
      UserModel? userData = await remoteDataSource.getUserData(uid);

      if (userData == null) {
        userData = UserModel(
          uid: uid,
          email: userCredential.user!.email,
          role: UserRole.user,
          createdAt: DateTime.now(),
          isProfileComplete: false,
        );
        await remoteDataSource.saveUserData(userData);
      }

      return Right(userData);
    } on FirebaseAuthException catch (e) {
      return Left(_getFirebaseErrorMessage(e));
    } catch (e) {
      // Fallback: check if user is actually signed in
      final currentUser = remoteDataSource.getCurrentUser();
      if (currentUser != null) {
        final userData = await remoteDataSource.getUserData(currentUser.uid);
        if (userData != null) {
          return Right(userData);
        }
      }
      print('❌ Unexpected error in signInWithEmail: $e');
      return Left('حدث خطأ غير متوقع');
    }
  }

  @override
  Future<Either<String, UserEntity>> signUpWithEmail(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await remoteDataSource.signUpWithEmail(
        email,
        password,
      );
      final uid = userCredential.user!.uid;

      final userData = UserModel(
        uid: uid,
        email: email,
        role: UserRole.user,
        createdAt: DateTime.now(),
        isProfileComplete: false,
      );

      await remoteDataSource.saveUserData(userData);
      return Right(userData);
    } on FirebaseAuthException catch (e) {
      return Left(_getFirebaseErrorMessage(e));
    } catch (e) {
      return Left('حدث خطأ غير متوقع');
    }
  }

  @override
  Future<Either<String, void>> sendPasswordResetEmail(String email) async {
    try {
      await remoteDataSource.sendPasswordResetEmail(email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(_getFirebaseErrorMessage(e));
    } catch (e) {
      return Left('حدث خطأ في إرسال البريد');
    }
  }

  @override
  Future<Either<String, UserEntity>> signInWithGoogle() async {
    try {
      final userCredential = await remoteDataSource.signInWithGoogle();
      final uid = userCredential.user!.uid;
      UserModel? userData = await remoteDataSource.getUserData(uid);

      if (userData == null) {
        userData = UserModel(
          uid: uid,
          email: userCredential.user!.email,
          firstName: userCredential.user!.displayName?.split(' ').first,
          lastName: userCredential.user!.displayName?.split(' ').last,
          photoUrl: userCredential.user!.photoURL,
          role: UserRole.user,
          createdAt: DateTime.now(),
          isProfileComplete: false,
        );
        await remoteDataSource.saveUserData(userData);
      }

      return Right(userData);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> updateUserRole(String uid, UserRole role) async {
    try {
      final userData = await remoteDataSource.getUserData(uid);
      if (userData == null) return const Left('المستخدم غير موجود');

      final updatedUser = userData.copyWith(role: role);
      await remoteDataSource.saveUserData(updatedUser);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> completeProfile({
    required String uid,
    String? firstName,
    String? lastName,
    String? city,
  }) async {
    try {
      final userData = await remoteDataSource.getUserData(uid);
      if (userData == null) return const Left('المستخدم غير موجود');

      final updatedUser = userData.copyWith(
        firstName: firstName,
        lastName: lastName,
        city: city,
        isProfileComplete: true,
      );

      await remoteDataSource.saveUserData(updatedUser);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserEntity?>> getCurrentUser() async {
    try {
      final firebaseUser = remoteDataSource.getCurrentUser();
      if (firebaseUser == null) return const Right(null);

      final userData = await remoteDataSource.getUserData(firebaseUser.uid);
      return Right(userData);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Stream<UserEntity?> authStateChanges() async* {
    await for (final user in remoteDataSource.authStateChanges()) {
      if (user == null) {
        yield null;
      } else {
        final userData = await remoteDataSource.getUserData(user.uid);
        yield userData;
      }
    }
  }

  String _getFirebaseErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'البريد الإلكتروني غير صحيح';
      case 'user-disabled':
        return 'هذا الحساب معطل';
      case 'user-not-found':
        return 'المستخدم غير موجود';
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة';
      case 'invalid-credential': // ← ADD THIS
      case 'INVALID_LOGIN_CREDENTIALS': // ← ADD THIS
        return 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
      case 'email-already-in-use':
        return 'البريد الإلكتروني مستخدم بالفعل';
      case 'weak-password':
        return 'كلمة المرور ضعيفة';
      case 'operation-not-allowed':
        return 'العملية غير مسموح بها';
      case 'too-many-requests':
        return 'عدد كبير من المحاولات. حاول لاحقاً';
      case 'network-request-failed': // ← ADD THIS
        return 'تحقق من اتصالك بالإنترنت';
      default:
        return e.message ?? 'حدث خطأ في المصادقة';
    }
  }
}
