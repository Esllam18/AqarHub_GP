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
import '../widgets/social_button.dart';

class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView({super.key});

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cityController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _finish() {
    final state = context.read<AuthCubit>().state;
    String? uid;

    if (state is AuthNeedsProfileCompletion) {
      uid = state.user.uid;
    }

    if (uid != null) {
      context.read<AuthCubit>().completeProfile(
        uid: uid,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        city: _cityController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var authStrings = AuthStrings;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              NavigationService.navigateAndClear(context, RouteNames.home);
            },
            child: Text(
              AuthStrings.skip,
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(16),
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            NavigationService.navigateAndClear(context, RouteNames.home);
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
              child: SingleChildScrollView(
                padding: EdgeInsets.all(ResponsiveHelper.width(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ResponsiveHelper.height(20)),
                    Text(
                      AuthStrings.completeProfileTitle,
                      style: GoogleFonts.cairo(
                        fontSize: ResponsiveHelper.fontSize(28),
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.height(8)),
                    Text(
                      AuthStrings.completeProfileSubtitle,
                      style: GoogleFonts.tajawal(
                        fontSize: ResponsiveHelper.fontSize(16),
                        // ignore: deprecated_member_use
                        color: AppColors.primary.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.height(40)),
                    _buildTextField(
                      controller: _firstNameController,
                      label: AuthStrings.firstNameLabel,
                      icon: Icons.person_outline,
                    ),
                    SizedBox(height: ResponsiveHelper.height(16)),
                    _buildTextField(
                      controller: _lastNameController,
                      label: AuthStrings.lastNameLabel,
                      icon: Icons.person_outline,
                    ),
                    SizedBox(height: ResponsiveHelper.height(16)),
                    _buildTextField(
                      controller: _emailController,
                      label: AuthStrings.emailLabel,
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: ResponsiveHelper.height(16)),
                    _buildTextField(
                      controller: _cityController,
                      label: AuthStrings.cityLabel,
                      icon: Icons.location_city_outlined,
                    ),
                    SizedBox(height: ResponsiveHelper.height(40)),
                    SocialButton(
                      text: state is AuthLoading
                          ? AuthStrings.loading
                          : AuthStrings.finishButton,
                      icon: Icons.check_circle_outline,
                      onPressed: state is AuthLoading ? () {} : _finish,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.cairo(
        fontSize: ResponsiveHelper.fontSize(16),
        color: AppColors.primary,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.tajawal(
          fontSize: ResponsiveHelper.fontSize(14),
          // ignore: deprecated_member_use
          color: AppColors.primary.withOpacity(0.7),
        ),
        prefixIcon: Icon(
          icon,
          color: AppColors.primary,
          size: ResponsiveHelper.width(24),
        ),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}
