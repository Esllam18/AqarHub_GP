import 'package:aqar_hub_gp/core/consts/app_assets.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'package:aqar_hub_gp/core/services/navigation_service.dart';
import 'package:aqar_hub_gp/core/strings/auth_strings.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/social_button.dart';
import '../widgets/auth_header.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: _handleStateChange,
        builder: (context, state) => _buildBody(context, state),
      ),
    );
  }

  void _handleStateChange(BuildContext context, AuthState state) {
    if (state is AuthGuestMode) {
      NavigationService.navigateToAndReplace(context, RouteNames.home);
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

  Widget _buildBody(BuildContext context, AuthState state) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(ResponsiveHelper.width(24)),
        child: Column(
          children: [
            const Spacer(),
            _buildLogo(),
            SizedBox(height: ResponsiveHelper.height(40)),
            const AuthHeader(
              title: AuthStrings.welcomeTitle,
              subtitle: AuthStrings.welcomeSubtitle,
            ),
            const Spacer(),
            _buildButtons(context, state),
            SizedBox(height: ResponsiveHelper.height(24)),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/logo/logo.jpg',
      width: ResponsiveHelper.width(150),
      height: ResponsiveHelper.height(150),
    );
  }

  Widget _buildButtons(BuildContext context, AuthState state) {
    if (state is AuthLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    return Column(
      children: [
        SocialButton(
          text: AuthStrings.loginWithEmail,
          icon: Icons.email_outlined,
          onPressed: () =>
              NavigationService.navigateTo(context, RouteNames.login),
        ),
        SizedBox(height: ResponsiveHelper.height(16)),
        SocialButton(
          text: AuthStrings.loginWithGoogle,
          imagePath: AppIcons.google,
          backgroundColor: Colors.white,
          textColor: AppColors.primary,
          onPressed: () => context.read<AuthCubit>().signInWithGoogle(),
        ),
        SizedBox(height: ResponsiveHelper.height(16)),
        _buildGuestButton(context),
      ],
    );
  }

  Widget _buildGuestButton(BuildContext context) {
    return TextButton(
      onPressed: () => context.read<AuthCubit>().continueAsGuest(),
      child: Text(
        AuthStrings.continueAsGuest,
        style: TextStyle(
          fontSize: ResponsiveHelper.fontSize(16),
          fontWeight: FontWeight.w600,
          color: AppColors.primary.withOpacity(0.7),
        ),
      ),
    );
  }
}
