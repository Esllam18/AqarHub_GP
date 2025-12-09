import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInWithPhoneUseCase {
  final AuthRepository repository;

  SignInWithPhoneUseCase(this.repository);

  Future<Either<String, UserEntity>> call(
    String verificationId,
    String smsCode,
  ) {
    return repository.signInWithPhone(verificationId, smsCode);
  }
}
