import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'package:aqar_hub_gp/core/services/navigation_service.dart';
import 'package:aqar_hub_gp/core/strings/auth_strings.dart';
import 'package:aqar_hub_gp/core/strings/validation_strings.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/auth_header.dart';
import '../widgets/loading_button.dart';

class EmailAuthView extends StatefulWidget {
  const EmailAuthView({super.key});

  @override
  State<EmailAuthView> createState() => _EmailAuthViewState();
}

class _EmailAuthViewState extends State<EmailAuthView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    if (!_validate()) return;

    context.read<AuthCubit>().signInWithEmail(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  bool _validate() {
    setState(() {
      _emailError = _validateEmail(_emailController.text.trim());
      _passwordError = _validatePassword(_passwordController.text.trim());
    });
    return _emailError == null && _passwordError == null;
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) return ValidationStrings.emailRequired;
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return ValidationStrings.emailInvalid;
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) return ValidationStrings.passwordRequired;
    if (password.length < 6) return ValidationStrings.passwordTooShort;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: BlocListener<AuthCubit, AuthState>(
        listener: _handleStateChange,
        child: _buildBody(context),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
        onPressed: () => NavigationService.goBack(context),
      ),
    );
  }

  void _handleStateChange(BuildContext context, AuthState state) {
    if (state is AuthNeedsRoleSelection) {
      NavigationService.navigateToAndReplace(context, RouteNames.roleSelection);
    } else if (state is AuthNeedsProfileCompletion) {
      NavigationService.navigateToAndReplace(
        context,
        RouteNames.completeProfile,
      );
    } else if (state is AuthSuccess) {
      NavigationService.navigateToAndReplace(context, RouteNames.home);
    } else if (state is AuthError) {
      CustomSnackBar.show(
        context,
        message: state.message,
        type: SnackBarType.error,
      );
    }
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(ResponsiveHelper.width(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: ResponsiveHelper.height(20)),
                const AuthHeader(
                  title: AuthStrings.emailAuthTitle,
                  subtitle: AuthStrings.emailAuthSubtitle,
                ),
                SizedBox(height: ResponsiveHelper.height(40)),
                CustomTextField(
                  controller: _emailController,
                  label: AuthStrings.emailLabel,
                  hint: AuthStrings.emailHint,
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  errorText: _emailError,
                ),
                SizedBox(height: ResponsiveHelper.height(16)),
                CustomTextField(
                  controller: _passwordController,
                  label: AuthStrings.passwordLabel,
                  hint: AuthStrings.passwordHint,
                  icon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  errorText: _passwordError,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.primary,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                SizedBox(height: ResponsiveHelper.height(8)),
                _buildForgotPassword(context),
                SizedBox(height: ResponsiveHelper.height(32)),
                LoadingButton(
                  isLoading: state is AuthLoading,
                  text: AuthStrings.loginButton,
                  loadingText: AuthStrings.loading,
                  icon: Icons.login,
                  onPressed: _signIn,
                ),
                SizedBox(height: ResponsiveHelper.height(16)),
                _buildSignUpPrompt(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildForgotPassword(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () =>
            NavigationService.navigateTo(context, RouteNames.forgotPassword),
        child: Text(
          AuthStrings.forgotPassword,
          style: TextStyle(
            fontFamily: GoogleFonts.cairo().fontFamily,
            color: AppColors.primary,
            fontSize: ResponsiveHelper.fontSize(14),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpPrompt(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () =>
              NavigationService.navigateTo(context, RouteNames.signUp),
          child: Text(
            AuthStrings.signUp,
            style: TextStyle(
              color: AppColors.primary,
              fontFamily: GoogleFonts.cairo().fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: ResponsiveHelper.fontSize(14),
            ),
          ),
        ),
        Text(
          AuthStrings.dontHaveAccount,
          style: TextStyle(
            // ignore: deprecated_member_use
            color: AppColors.primary.withOpacity(0.7),
            fontFamily: GoogleFonts.cairo().fontFamily,
            fontSize: ResponsiveHelper.fontSize(14),
          ),
        ),
      ],
    );
  }
}
