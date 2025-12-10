import 'package:aqar_hub_gp/features/authentication/domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;
  AuthSuccess(this.user);
}

class AuthNeedsRoleSelection extends AuthState {
  final UserEntity user;
  AuthNeedsRoleSelection(this.user);
}

class AuthNeedsProfileCompletion extends AuthState {
  final UserEntity user;
  AuthNeedsProfileCompletion(this.user);
}

class AuthPasswordResetSent extends AuthState {}

class AuthGuestMode extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
