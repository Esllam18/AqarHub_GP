import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'package:aqar_hub_gp/core/services/navigation_service.dart';
import 'package:aqar_hub_gp/core/strings/auth_strings.dart';
import 'package:aqar_hub_gp/core/strings/validation_strings.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/auth_header.dart';
import '../widgets/loading_button.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() {
    if (!_validate()) return;

    context.read<AuthCubit>().signUpWithEmail(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  bool _validate() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    setState(() {
      _emailError = _validateEmail(email);
      _passwordError = _validatePassword(password);
      _confirmPasswordError = _validateConfirmPassword(
        password,
        confirmPassword,
      );
    });

    return _emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null;
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

  String? _validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) return ValidationStrings.passwordRequired;
    if (password != confirmPassword) {
      return ValidationStrings.passwordsDoNotMatch;
    }
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ResponsiveHelper.height(20)),
                const AuthHeader(
                  title: AuthStrings.signUpTitle,
                  subtitle: AuthStrings.signUpSubtitle,
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
                SizedBox(height: ResponsiveHelper.height(16)),
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: AuthStrings.confirmPasswordLabel,
                  hint: AuthStrings.passwordHint,
                  icon: Icons.lock_outline,
                  obscureText: _obscureConfirmPassword,
                  errorText: _confirmPasswordError,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.primary,
                    ),
                    onPressed: () => setState(
                      () => _obscureConfirmPassword = !_obscureConfirmPassword,
                    ),
                  ),
                ),
                SizedBox(height: ResponsiveHelper.height(32)),
                LoadingButton(
                  isLoading: state is AuthLoading,
                  text: AuthStrings.signUpButton,
                  loadingText: AuthStrings.loading,
                  icon: Icons.person_add,
                  onPressed: _signUp,
                ),
                SizedBox(height: ResponsiveHelper.height(16)),
                _buildLoginPrompt(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AuthStrings.alreadyHaveAccount,
          style: TextStyle(
            color: AppColors.primary.withOpacity(0.7),
            fontSize: ResponsiveHelper.fontSize(14),
          ),
        ),
        TextButton(
          onPressed: () => NavigationService.goBack(context),
          child: Text(
            AuthStrings.loginButton,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: ResponsiveHelper.fontSize(14),
            ),
          ),
        ),
      ],
    );
  }
}
