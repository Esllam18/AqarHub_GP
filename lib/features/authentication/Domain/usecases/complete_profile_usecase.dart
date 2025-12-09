import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';

class CompleteProfileUseCase {
  final AuthRepository repository;

  CompleteProfileUseCase(this.repository);

  Future<Either<String, void>> call({
    required String uid,
    String? firstName,
    String? lastName,
    String? email,
    String? city,
  }) {
    return repository.completeProfile(
      uid: uid,
      firstName: firstName,
      lastName: lastName,
      email: email,
      city: city,
    );
  }
}
