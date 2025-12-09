import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';

class VerifyPhoneUseCase {
  final AuthRepository repository;

  VerifyPhoneUseCase(this.repository);

  Future<Either<String, void>> call(
    String phoneNumber,
    Function(String) onCodeSent,
  ) {
    return repository.verifyPhoneNumber(phoneNumber, onCodeSent);
  }
}
