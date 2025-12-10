import 'package:aqar_hub_gp/features/authentication/Domain/entities/user_entity.dart';
import 'package:aqar_hub_gp/features/authentication/Domain/usecases/complete_profile_usecase.dart';
import 'package:aqar_hub_gp/features/authentication/Domain/usecases/send_password_reset_usecase.dart';
import 'package:aqar_hub_gp/features/authentication/Domain/usecases/sign_in_with_email_usecase.dart';
import 'package:aqar_hub_gp/features/authentication/Domain/usecases/sign_in_with_google_usecase.dart';
import 'package:aqar_hub_gp/features/authentication/Domain/usecases/sign_up_with_email_usecase.dart';
import 'package:aqar_hub_gp/features/authentication/Domain/usecases/update_user_role_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/enums/user_role.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInWithEmailUseCase signInWithEmailUseCase;
  final SignUpWithEmailUseCase signUpWithEmailUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final SendPasswordResetUseCase sendPasswordResetUseCase;
  final UpdateUserRoleUseCase updateUserRoleUseCase;
  final CompleteProfileUseCase completeProfileUseCase;

  AuthCubit({
    required this.signInWithEmailUseCase,
    required this.signUpWithEmailUseCase,
    required this.signInWithGoogleUseCase,
    required this.sendPasswordResetUseCase,
    required this.updateUserRoleUseCase,
    required this.completeProfileUseCase,
  }) : super(AuthInitial());

  Future<void> signInWithEmail(String email, String password) async {
    emit(AuthLoading());
    final result = await signInWithEmailUseCase(email, password);
    result.fold(
      (error) => emit(AuthError(error)),
      (user) => _handleAuthSuccess(user),
    );
  }

  Future<void> signUpWithEmail(String email, String password) async {
    emit(AuthLoading());
    final result = await signUpWithEmailUseCase(email, password);
    result.fold(
      (error) => emit(AuthError(error)),
      (user) => _handleAuthSuccess(user),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    final result = await signInWithGoogleUseCase();
    result.fold(
      (error) => emit(AuthError(error)),
      (user) => _handleAuthSuccess(user),
    );
  }

  Future<void> sendPasswordReset(String email) async {
    emit(AuthLoading());
    final result = await sendPasswordResetUseCase(email);
    result.fold(
      (error) => emit(AuthError(error)),
      (_) => emit(AuthPasswordResetSent()),
    );
  }

  void continueAsGuest() {
    emit(AuthGuestMode());
  }

  Future<void> updateRole(String uid, UserRole role) async {
    emit(AuthLoading());
    final result = await updateUserRoleUseCase(uid, role);
    result.fold((error) => emit(AuthError(error)), (_) {
      if (state is AuthNeedsRoleSelection) {
        final user = (state as AuthNeedsRoleSelection).user;
        emit(AuthNeedsProfileCompletion(user));
      }
    });
  }

  // sign out method
  Future<void> signOut() async {
    emit(AuthLoading());
    // Here you would typically call a sign-out method from your repository
    // For example: await authRepository.signOut();
    emit(AuthInitial());
  }

  Future<void> completeProfile({
    required String uid,
    String? firstName,
    String? lastName,
    String? city,
  }) async {
    emit(AuthLoading());
    final result = await completeProfileUseCase(
      uid: uid,
      firstName: firstName,
      lastName: lastName,
      city: city,
    );
    result.fold((error) => emit(AuthError(error)), (_) {
      if (state is AuthNeedsProfileCompletion) {
        final user = (state as AuthNeedsProfileCompletion).user;
        emit(AuthSuccess(user));
      }
    });
  }

  void _handleAuthSuccess(UserEntity user) {
    if (user.role == UserRole.user && !user.isProfileComplete) {
      emit(AuthNeedsRoleSelection(user));
    } else if (!user.isProfileComplete) {
      emit(AuthNeedsProfileCompletion(user));
    } else {
      emit(AuthSuccess(user));
    }
  }
}
