import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';

class SendPasswordResetUseCase {
  final AuthRepository repository;

  SendPasswordResetUseCase(this.repository);

  Future<Either<String, void>> call(String email) async {
    return await repository.sendPasswordResetEmail(email);
  }
}
