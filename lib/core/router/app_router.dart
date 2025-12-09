import 'package:aqar_hub_gp/features/authentication/Presentation/cubit/auth_cubit.dart';
import 'package:aqar_hub_gp/features/authentication/Presentation/views/complete_profile_view.dart';
import 'package:aqar_hub_gp/features/authentication/Presentation/views/otp_verification_view.dart';
import 'package:aqar_hub_gp/features/authentication/Presentation/views/phone_auth_view.dart';
import 'package:aqar_hub_gp/features/authentication/Presentation/views/role_selection_view.dart';
import 'package:aqar_hub_gp/features/authentication/Presentation/views/welcome_view.dart';
import 'package:aqar_hub_gp/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:aqar_hub_gp/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:aqar_hub_gp/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:aqar_hub_gp/features/splash/presentation/views/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../di/injection_container.dart';
import 'route_names.dart';

final router = GoRouter(
  initialLocation: RouteNames.splash,
  routes: [
    // Splash Screen
    GoRoute(
      path: RouteNames.splash,
      name: RouteNames.splash,
      builder: (context, state) => BlocProvider(
        create: (context) => SplashCubit(),
        child: const SplashView(),
      ),
    ),

    // Onboarding Screen
    GoRoute(
      path: RouteNames.onboarding,
      name: RouteNames.onboarding,
      builder: (context, state) => BlocProvider(
        create: (context) => OnboardingCubit(),
        child: const OnboardingView(),
      ),
    ),

    // Welcome Screen
    GoRoute(
      path: RouteNames.welcome,
      name: RouteNames.welcome,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<AuthCubit>(),
        child: const WelcomeView(),
      ),
    ),

    // Phone Auth Screen
    GoRoute(
      path: RouteNames.login,
      name: RouteNames.login,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<AuthCubit>(),
        child: const PhoneAuthView(),
      ),
    ),

    // OTP Verification Screen
    GoRoute(
      path: RouteNames.otp,
      name: RouteNames.otp,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return BlocProvider(
          create: (context) => sl<AuthCubit>(),
          child: OtpVerificationView(
            verificationId: args['verificationId'],
            phoneNumber: args['phoneNumber'],
          ),
        );
      },
    ),

    // Role Selection Screen
    GoRoute(
      path: RouteNames.roleSelection,
      name: RouteNames.roleSelection,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<AuthCubit>(),
        child: const RoleSelectionView(),
      ),
    ),

    // Complete Profile Screen
    GoRoute(
      path: RouteNames.completeProfile,
      name: RouteNames.completeProfile,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<AuthCubit>(),
        child: const CompleteProfileView(),
      ),
    ),

    // Home Screen
    GoRoute(
      path: RouteNames.home,
      name: RouteNames.home,
      builder: (context, state) {
        final user = state.extra as dynamic;
        return BlocProvider(
          create: (context) => sl<AuthCubit>(),
          child: HomeView(user: user),
        );
      },
    ),
  ],
);
