import 'package:aqar_hub_gp/features/authentication/Domain/entities/user_entity.dart';
import 'package:aqar_hub_gp/features/authentication/Domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/enums/user_role.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, void>> verifyPhoneNumber(
    String phoneNumber,
    Function(String) onCodeSent,
  ) async {
    try {
      await remoteDataSource.verifyPhoneNumber(
        phoneNumber,
        onCodeSent,
        (error) => throw Exception(error),
      );
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserEntity>> signInWithPhone(
    String verificationId,
    String smsCode,
  ) async {
    try {
      final userCredential = await remoteDataSource.signInWithPhone(
        verificationId,
        smsCode,
      );

      final uid = userCredential.user!.uid;
      UserModel? userData = await remoteDataSource.getUserData(uid);

      if (userData == null) {
        // New user - create default profile
        userData = UserModel(
          uid: uid,
          phoneNumber: userCredential.user!.phoneNumber,
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
      return Left('حدث خطأ غير متوقع');
    }
  }

  @override
  Future<Either<String, UserEntity>> signInWithGoogle() async {
    try {
      final userCredential = await remoteDataSource.signInWithGoogle();
      final uid = userCredential.user!.uid;

      UserModel? userData = await remoteDataSource.getUserData(uid);

      if (userData == null) {
        // New user from Google
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
    String? email,
    String? city,
  }) async {
    try {
      final userData = await remoteDataSource.getUserData(uid);
      if (userData == null) return const Left('المستخدم غير موجود');

      final updatedUser = userData.copyWith(
        firstName: firstName,
        lastName: lastName,
        email: email,
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
      case 'invalid-verification-code':
        return 'رمز التحقق غير صحيح';
      case 'invalid-phone-number':
        return 'رقم الجوال غير صحيح';
      case 'quota-exceeded':
        return 'تم تجاوز الحد المسموح. حاول لاحقاً';
      case 'session-expired':
        return 'انتهت صلاحية الجلسة. حاول مرة أخرى';
      default:
        return e.message ?? 'حدث خطأ في المصادقة';
    }
  }
}
