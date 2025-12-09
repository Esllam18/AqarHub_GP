import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/consts/app_strings.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'package:aqar_hub_gp/core/services/navigation_service.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/otp_input_field.dart';
import '../widgets/social_button.dart';

class OtpVerificationView extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const OtpVerificationView({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isResending = false;

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get _otpCode => _controllers.map((c) => c.text).join();

  void _verifyOtp() {
    if (_otpCode.length == 6) {
      context.read<AuthCubit>().verifyOtp(widget.verificationId, _otpCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
          onPressed: () => NavigationService.goBack(context),
        ),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthNeedsRoleSelection) {
            NavigationService.navigateTo(context, RouteNames.roleSelection);
          } else if (state is AuthNeedsProfileCompletion) {
            NavigationService.navigateTo(context, RouteNames.completeProfile);
          } else if (state is AuthSuccess) {
            NavigationService.navigateAndClear(context, RouteNames.home);
          } else if (state is AuthError) {
            CustomSnackBar.show(
              context,
              message: state.message,
              type: SnackBarType.error,
            );
          } else if (state is AuthCodeSent && _isResending) {
            // Code resent successfully
            setState(() => _isResending = false);
            CustomSnackBar.show(
              context,
              message: 'تم إعادة إرسال الرمز',
              type: SnackBarType.success,
            );
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(ResponsiveHelper.width(24)),
                child: Column(
                  children: [
                    SizedBox(height: ResponsiveHelper.height(20)),
                    Text(
                      AuthStrings.otpTitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        fontSize: ResponsiveHelper.fontSize(28),
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.height(8)),
                    Text(
                      AuthStrings.otpSubtitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.tajawal(
                        fontSize: ResponsiveHelper.fontSize(16),
                        // ignore: deprecated_member_use
                        color: AppColors.primary.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.height(4)),
                    Text(
                      widget.phoneNumber,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.cairo(
                        fontSize: ResponsiveHelper.fontSize(18),
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.height(40)),
                    _buildOtpFields(),
                    SizedBox(height: ResponsiveHelper.height(24)),
                    _buildResendButton(),
                    const Spacer(),
                    SocialButton(
                      text: state is AuthLoading
                          ? AuthStrings.loading
                          : AuthStrings.verifyButton,
                      icon: Icons.check_circle_outline,
                      onPressed: state is AuthLoading ? () {} : _verifyOtp,
                    ),
                    SizedBox(height: ResponsiveHelper.height(24)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOtpFields() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(6, (index) {
          return OtpInputField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                _focusNodes[index + 1].requestFocus();
              } else if (value.isEmpty && index > 0) {
                _focusNodes[index - 1].requestFocus();
              }
            },
          );
        }),
      ),
    );
  }

  Widget _buildResendButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AuthStrings.didntReceiveCode,
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(14),
            // ignore: deprecated_member_use
            color: AppColors.primary.withOpacity(0.7),
          ),
        ),
        TextButton(
          onPressed: _isResending
              ? null
              : () {
                  setState(() => _isResending = true);
                  context.read<AuthCubit>().verifyPhone(widget.phoneNumber);
                },
          child: _isResending
              ? SizedBox(
                  width: ResponsiveHelper.width(16),
                  height: ResponsiveHelper.height(16),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      // ignore: deprecated_member_use
                      AppColors.primary.withOpacity(0.5),
                    ),
                  ),
                )
              : Text(
                  AuthStrings.resendOtp,
                  style: GoogleFonts.cairo(
                    fontSize: ResponsiveHelper.fontSize(14),
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
        ),
      ],
    );
  }
}
