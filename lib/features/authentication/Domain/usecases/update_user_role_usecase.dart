import 'package:dartz/dartz.dart';
import '../../../../core/enums/user_role.dart';
import '../repositories/auth_repository.dart';

class UpdateUserRoleUseCase {
  final AuthRepository repository;

  UpdateUserRoleUseCase(this.repository);

  Future<Either<String, void>> call(String uid, UserRole role) {
    return repository.updateUserRole(uid, role);
  }
}
