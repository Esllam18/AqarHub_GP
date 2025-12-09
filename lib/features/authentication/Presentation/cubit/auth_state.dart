import 'package:aqar_hub_gp/features/authentication/Domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthCodeSent extends AuthState {
  final String verificationId;

  const AuthCodeSent(this.verificationId);

  @override
  List<Object?> get props => [verificationId];
}

class AuthSuccess extends AuthState {
  final UserEntity user;

  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthNeedsRoleSelection extends AuthState {
  final UserEntity user;

  const AuthNeedsRoleSelection(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthNeedsProfileCompletion extends AuthState {
  final UserEntity user;

  const AuthNeedsProfileCompletion(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthUnauthenticated extends AuthState {}

class AuthGuestMode extends AuthState {}
