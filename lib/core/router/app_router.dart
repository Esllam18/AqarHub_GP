import 'package:aqar_hub_gp/features/home/views/home_view.dart';
import 'package:aqar_hub_gp/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:aqar_hub_gp/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:aqar_hub_gp/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:aqar_hub_gp/features/splash/presentation/views/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/authentication/presentation/cubit/auth_cubit.dart';
import '../../features/authentication/presentation/views/welcome_view.dart';
import '../../features/authentication/presentation/views/email_auth_view.dart';
import '../../features/authentication/presentation/views/sign_up_view.dart';
import '../../features/authentication/presentation/views/forgot_password_view.dart';
import '../../features/authentication/presentation/views/role_selection_view.dart';
import '../../features/authentication/presentation/views/complete_profile_view.dart';
import '../di/injection_container.dart';
import 'route_names.dart';

final GoRouter router = GoRouter(
  initialLocation: RouteNames.splash,
  routes: [
    // Splash Screen
    GoRoute(
      path: RouteNames.splash,
      name: RouteNames.splash,
      builder: (context, state) => BlocProvider<SplashCubit>(
        create: (context) => SplashCubit(),
        child: const SplashView(),
      ),
    ),

    // Onboarding Screen
    GoRoute(
      path: RouteNames.onboarding,
      name: RouteNames.onboarding,
      builder: (context, state) => BlocProvider<OnboardingCubit>(
        create: (context) => OnboardingCubit(),
        child: const OnboardingView(),
      ),
    ),

    // Welcome Screen
    GoRoute(
      path: RouteNames.welcome,
      name: RouteNames.welcome,
      builder: (context, state) => BlocProvider<AuthCubit>(
        create: (context) => getIt<AuthCubit>(),
        child: const WelcomeView(),
      ),
    ),

    // Email / Login Screen
    GoRoute(
      path: RouteNames.login,
      name: RouteNames.login,
      builder: (context, state) => BlocProvider<AuthCubit>(
        create: (context) => getIt<AuthCubit>(),
        child: const EmailAuthView(),
      ),
    ),

    // Sign Up Screen
    GoRoute(
      path: RouteNames.signUp,
      name: RouteNames.signUp,
      builder: (context, state) => BlocProvider<AuthCubit>(
        create: (context) => getIt<AuthCubit>(),
        child: const SignUpView(),
      ),
    ),

    // Forgot Password Screen
    GoRoute(
      path: RouteNames.forgotPassword,
      name: RouteNames.forgotPassword,
      builder: (context, state) => BlocProvider<AuthCubit>(
        create: (context) => getIt<AuthCubit>(),
        child: const ForgotPasswordView(),
      ),
    ),

    // Role Selection Screen
    GoRoute(
      path: RouteNames.roleSelection,
      name: RouteNames.roleSelection,
      builder: (context, state) => BlocProvider<AuthCubit>(
        create: (context) => getIt<AuthCubit>(),
        child: const RoleSelectionView(),
      ),
    ),

    // Complete Profile Screen
    GoRoute(
      path: RouteNames.completeProfile,
      name: RouteNames.completeProfile,
      builder: (context, state) => BlocProvider<AuthCubit>(
        create: (context) => getIt<AuthCubit>(),
        child: const CompleteProfileView(),
      ),
    ),

    // Home Screen
    GoRoute(
      path: RouteNames.home,
      name: RouteNames.home,
      builder: (context, state) {
        final user = state.extra as dynamic;
        return BlocProvider<AuthCubit>(
          create: (context) => getIt<AuthCubit>(),
          child: HomeView(user: user),
        );
      },
    ),

    // Forgot Password Screen
  ],
);
