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
import '../widgets/phone_input_field.dart';
import '../widgets/social_button.dart';

class PhoneAuthView extends StatefulWidget {
  const PhoneAuthView({super.key});

  @override
  State<PhoneAuthView> createState() => _PhoneAuthViewState();
}

class _PhoneAuthViewState extends State<PhoneAuthView> {
  final _phoneController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _sendOtp() {
    final phone = _phoneController.text.trim();

    if (phone.isEmpty) {
      setState(() => _errorText = 'رقم الجوال مطلوب');
      return;
    }

    // Phone number is already formatted with country code by IntlPhoneField
    setState(() => _errorText = null);
    context.read<AuthCubit>().verifyPhone(_fullPhoneNumber);
  }

  String _fullPhoneNumber = '';

  void _onPhoneChanged(String fullNumber) {
    setState(() {
      _fullPhoneNumber = fullNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => NavigationService.goBack(context),
        ),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthCodeSent) {
            NavigationService.navigateTo(
              context,
              RouteNames.otp,
              extra: {
                // Pass extra arguments for GoRouter
                'verificationId': state.verificationId,
                'phoneNumber':
                    _fullPhoneNumber, // Pass full number with country code
              },
            );
          } else if (state is AuthError) {
            CustomSnackBar.show(
              context,
              message: state.message,
              type: SnackBarType.error,
            );
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(ResponsiveHelper.width(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: ResponsiveHelper.height(20)),
                    Text(
                      AuthStrings.phoneAuthTitle,
                      style: GoogleFonts.cairo(
                        fontSize: ResponsiveHelper.fontSize(28),
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.height(8)),
                    Text(
                      AuthStrings.phoneAuthSubtitle,
                      style: GoogleFonts.tajawal(
                        fontSize: ResponsiveHelper.fontSize(16),
                        // ignore: deprecated_member_use
                        color: AppColors.primary.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.height(40)),
                    PhoneInputField(
                      controller: _phoneController,
                      errorText: _errorText,
                      onCountryChanged: _onPhoneChanged,
                    ),
                    const Spacer(),
                    SocialButton(
                      text: state is AuthLoading
                          ? AuthStrings.loading
                          : AuthStrings.sendOtp,
                      icon: Icons.send_outlined,
                      onPressed: state is AuthLoading ? () {} : _sendOtp,
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
}
