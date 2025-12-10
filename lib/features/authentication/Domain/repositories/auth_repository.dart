import 'package:dartz/dartz.dart';
import '../../../../core/enums/user_role.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<String, UserEntity>> signInWithEmail(
    String email,
    String password,
  );
  Future<Either<String, UserEntity>> signUpWithEmail(
    String email,
    String password,
  );
  Future<Either<String, void>> sendPasswordResetEmail(String email);
  Future<Either<String, UserEntity>> signInWithGoogle();
  Future<Either<String, void>> updateUserRole(String uid, UserRole role);
  Future<Either<String, void>> completeProfile({
    required String uid,
    String? firstName,
    String? lastName,
    String? city,
  });
  Future<Either<String, UserEntity?>> getCurrentUser();
  Future<Either<String, void>> signOut();
  Stream<UserEntity?> authStateChanges();
}
