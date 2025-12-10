import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpWithEmailUseCase {
  final AuthRepository repository;

  SignUpWithEmailUseCase(this.repository);

  Future<Either<String, UserEntity>> call(String email, String password) async {
    return await repository.signUpWithEmail(email, password);
  }
}
