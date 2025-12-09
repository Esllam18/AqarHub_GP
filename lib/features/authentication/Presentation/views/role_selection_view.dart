import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/consts/app_strings.dart';
import 'package:aqar_hub_gp/core/enums/user_role.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'package:aqar_hub_gp/core/services/navigation_service.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/role_card.dart';
import '../widgets/social_button.dart';

class RoleSelectionView extends StatefulWidget {
  const RoleSelectionView({super.key});

  @override
  State<RoleSelectionView> createState() => _RoleSelectionViewState();
}

class _RoleSelectionViewState extends State<RoleSelectionView> {
  UserRole _selectedRole = UserRole.user;

  void _continue() {
    final state = context.read<AuthCubit>().state;
    if (state is AuthNeedsRoleSelection) {
      context.read<AuthCubit>().updateRole(state.user.uid, _selectedRole);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthNeedsProfileCompletion) {
            NavigationService.navigateTo(context, RouteNames.completeProfile);
          } else if (state is AuthError) {
            CustomSnackBar.show(
              context,
              message: state.message,
              type: SnackBarType.error,
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(ResponsiveHelper.width(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: ResponsiveHelper.height(20)),
                Text(
                  AuthStrings.roleTitle,
                  style: GoogleFonts.cairo(
                    fontSize: ResponsiveHelper.fontSize(28),
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: ResponsiveHelper.height(8)),
                Text(
                  AuthStrings.roleSubtitle,
                  style: GoogleFonts.tajawal(
                    fontSize: ResponsiveHelper.fontSize(16),
                    // ignore: deprecated_member_use
                    color: AppColors.primary.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: ResponsiveHelper.height(40)),
                RoleCard(
                  title: AuthStrings.roleUser,
                  description: AuthStrings.roleUserDesc,
                  icon: Icons.person_outline,
                  isSelected: _selectedRole == UserRole.user,
                  onTap: () => setState(() => _selectedRole = UserRole.user),
                ),
                SizedBox(height: ResponsiveHelper.height(16)),
                RoleCard(
                  title: AuthStrings.roleOwner,
                  description: AuthStrings.roleOwnerDesc,
                  icon: Icons.business_outlined,
                  isSelected: _selectedRole == UserRole.owner,
                  onTap: () => setState(() => _selectedRole = UserRole.owner),
                ),
                const Spacer(),
                SocialButton(
                  text: AuthStrings.continueButton,
                  icon: Icons.arrow_forward,
                  onPressed: _continue,
                ),
                SizedBox(height: ResponsiveHelper.height(24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
