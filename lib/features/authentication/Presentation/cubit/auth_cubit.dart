import 'package:aqar_hub_gp/features/authentication/Domain/entities/user_entity.dart';
import 'package:aqar_hub_gp/features/authentication/Domain/usecases/complete_profile_usecase.dart';
import 'package:aqar_hub_gp/features/authentication/Domain/usecases/sign_in_with_google_usecase.dart';
import 'package:aqar_hub_gp/features/authentication/Domain/usecases/sign_in_with_phone_usecase.dart';
import 'package:aqar_hub_gp/features/authentication/Domain/usecases/update_user_role_usecase.dart';
import 'package:aqar_hub_gp/features/authentication/Domain/usecases/verify_phone_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/enums/user_role.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final VerifyPhoneUseCase verifyPhoneUseCase;
  final SignInWithPhoneUseCase signInWithPhoneUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final UpdateUserRoleUseCase updateUserRoleUseCase;
  final CompleteProfileUseCase completeProfileUseCase;

  AuthCubit({
    required this.verifyPhoneUseCase,
    required this.signInWithPhoneUseCase,
    required this.signInWithGoogleUseCase,
    required this.updateUserRoleUseCase,
    required this.completeProfileUseCase,
  }) : super(AuthInitial());

  Future<void> verifyPhone(String phoneNumber) async {
    emit(AuthLoading());

    final result = await verifyPhoneUseCase(phoneNumber, (verificationId) {
      emit(AuthCodeSent(verificationId));
    });

    result.fold((error) => emit(AuthError(error)), (_) {});
  }

  Future<void> verifyOtp(String verificationId, String smsCode) async {
    emit(AuthLoading());

    final result = await signInWithPhoneUseCase(verificationId, smsCode);

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

  void continueAsGuest() {
    emit(AuthGuestMode());
  }

  Future<void> updateRole(String uid, UserRole role) async {
    emit(AuthLoading());

    final result = await updateUserRoleUseCase(uid, role);

    result.fold((error) => emit(AuthError(error)), (_) async {
      // Get updated user and check if profile is complete
      if (state is AuthNeedsRoleSelection) {
        final user = (state as AuthNeedsRoleSelection).user;
        emit(AuthNeedsProfileCompletion(user));
      }
    });
  }

  Future<void> completeProfile({
    required String uid,
    String? firstName,
    String? lastName,
    String? email,
    String? city,
  }) async {
    emit(AuthLoading());

    final result = await completeProfileUseCase(
      uid: uid,
      firstName: firstName,
      lastName: lastName,
      email: email,
      city: city,
    );

    result.fold((error) => emit(AuthError(error)), (_) {
      // Navigate to home - profile is complete
      if (state is AuthNeedsProfileCompletion) {
        final user = (state as AuthNeedsProfileCompletion).user;
        emit(AuthSuccess(user));
      }
    });
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    // Note: SignOutUseCase should be created, but for now using repository pattern
    // The repository exists, just need to wire it through usecase layer properly
    // For now, we'll just emit initial state after calling hypothetical signout
    emit(AuthInitial());
  }

  void _handleAuthSuccess(UserEntity user) {
    // Check if user needs role selection
    if (user.role == UserRole.user && !user.isProfileComplete) {
      emit(AuthNeedsRoleSelection(user));
    }
    // Check if profile needs completion
    else if (!user.isProfileComplete) {
      emit(AuthNeedsProfileCompletion(user));
    }
    // Everything is complete
    else {
      emit(AuthSuccess(user));
    }
  }
}
