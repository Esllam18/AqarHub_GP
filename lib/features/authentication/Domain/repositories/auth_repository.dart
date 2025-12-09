import 'package:dartz/dartz.dart';
import '../../../../core/enums/user_role.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<String, void>> verifyPhoneNumber(
    String phoneNumber,
    Function(String) onCodeSent,
  );

  Future<Either<String, UserEntity>> signInWithPhone(
    String verificationId,
    String smsCode,
  );

  Future<Either<String, UserEntity>> signInWithGoogle();

  Future<Either<String, void>> updateUserRole(String uid, UserRole role);

  Future<Either<String, void>> completeProfile({
    required String uid,
    String? firstName,
    String? lastName,
    String? email,
    String? city,
  });

  Future<Either<String, UserEntity?>> getCurrentUser();

  Future<Either<String, void>> signOut();

  Stream<UserEntity?> authStateChanges();
}
