import 'package:aqar_hub_gp/core/consts/app_colors.dart';
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

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _emailController = TextEditingController();
  String? _emailError;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetLink() {
    final email = _emailController.text.trim();
    setState(() {
      _emailError = _validateEmail(email);
    });

    if (_emailError == null) {
      context.read<AuthCubit>().sendPasswordReset(email);
    }
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) return ValidationStrings.emailRequired;
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return ValidationStrings.emailInvalid;
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
    if (state is AuthPasswordResetSent) {
      CustomSnackBar.show(
        context,
        message: AuthStrings.resetEmailSent,
        type: SnackBarType.success,
      );
      Future.delayed(const Duration(seconds: 2), () {
        NavigationService.goBack(context);
      });
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
                  title: AuthStrings.forgotPasswordTitle,
                  subtitle: AuthStrings.forgotPasswordSubtitle,
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
                SizedBox(height: ResponsiveHelper.height(32)),
                LoadingButton(
                  isLoading: state is AuthLoading,
                  text: AuthStrings.sendResetLink,
                  loadingText: AuthStrings.loading,
                  icon: Icons.send,
                  onPressed: _sendResetLink,
                ),
                SizedBox(height: ResponsiveHelper.height(16)),
                _buildBackToLogin(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBackToLogin(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => NavigationService.goBack(context),
        child: Text(
          AuthStrings.backToLogin,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: ResponsiveHelper.fontSize(14),
          ),
        ),
      ),
    );
  }
}
