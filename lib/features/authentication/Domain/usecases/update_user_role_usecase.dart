import 'package:aqar_hub_gp/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/enums/user_role.dart';

class UpdateUserRoleUseCase {
  final AuthRepository repository;

  UpdateUserRoleUseCase(this.repository);

  Future<Either<String, void>> call(String userId, UserRole role) async {
    return await repository.updateUserRole(userId, role);
  }
}
