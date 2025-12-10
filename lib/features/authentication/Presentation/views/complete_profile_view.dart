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

class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView({super.key});

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _cityController = TextEditingController();
  String? _firstNameError;
  String? _lastNameError;
  String? _cityError;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _finish() {
    if (!_validate()) return;

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
        city: _cityController.text.trim(),
      );
    }
  }

  bool _validate() {
    setState(() {
      _firstNameError = _firstNameController.text.trim().isEmpty
          ? ValidationStrings.firstNameRequired
          : null;
      _lastNameError = _lastNameController.text.trim().isEmpty
          ? ValidationStrings.lastNameRequired
          : null;
      _cityError = _cityController.text.trim().isEmpty
          ? ValidationStrings.cityRequired
          : null;
    });
    return _firstNameError == null &&
        _lastNameError == null &&
        _cityError == null;
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
      actions: [
        TextButton(
          onPressed: () =>
              NavigationService.navigateAndClear(context, RouteNames.home),
          child: Text(
            AuthStrings.skip,
            style: TextStyle(
              fontSize: ResponsiveHelper.fontSize(16),
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  void _handleStateChange(BuildContext context, AuthState state) {
    if (state is AuthSuccess) {
      NavigationService.navigateAndClear(context, RouteNames.home);
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
                  title: AuthStrings.completeProfileTitle,
                  subtitle: AuthStrings.completeProfileSubtitle,
                ),
                SizedBox(height: ResponsiveHelper.height(40)),
                CustomTextField(
                  controller: _firstNameController,
                  label: AuthStrings.firstNameLabel,
                  icon: Icons.person_outline,
                  errorText: _firstNameError,
                ),
                SizedBox(height: ResponsiveHelper.height(16)),
                CustomTextField(
                  controller: _lastNameController,
                  label: AuthStrings.lastNameLabel,
                  icon: Icons.person_outline,
                  errorText: _lastNameError,
                ),
                SizedBox(height: ResponsiveHelper.height(16)),
                CustomTextField(
                  controller: _cityController,
                  label: AuthStrings.cityLabel,
                  icon: Icons.location_city_outlined,
                  errorText: _cityError,
                ),
                SizedBox(height: ResponsiveHelper.height(40)),
                LoadingButton(
                  isLoading: state is AuthLoading,
                  text: AuthStrings.finishButton,
                  loadingText: AuthStrings.loading,
                  icon: Icons.check_circle_outline,
                  onPressed: _finish,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
