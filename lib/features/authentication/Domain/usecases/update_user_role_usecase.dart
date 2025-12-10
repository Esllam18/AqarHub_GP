import 'package:dartz/dartz.dart';
import '../../../../core/enums/user_role.dart';
import '../../data/repositories/auth_repository_impl.dart';

class UpdateUserRoleUseCase {
  final AuthRepositoryImpl repository;

  UpdateUserRoleUseCase(this.repository);

  Future<Either<String, void>> call(String userId, UserRole role) async {
    return await repository.updateUserRole(userId, role);
  }
}
