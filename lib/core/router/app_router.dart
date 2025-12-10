import 'package:aqar_hub_gp/features/home/views/home_view.dart';
import 'package:flutter/material.dart';
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

// Make router a getter instead of a global variable
GoRouter get router => GoRouter(
  initialLocation: RouteNames.welcome,
  debugLogDiagnostics: true,
  routes: [
    // Welcome/Splash Screen
    GoRoute(
      path: RouteNames.welcome,
      name: RouteNames.welcome,
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context,
        state: state,
        child: BlocProvider(
          create: (_) => getIt<AuthCubit>(),
          child: const WelcomeView(),
        ),
      ),
    ),

    // Email Login Screen
    GoRoute(
      path: RouteNames.login,
      name: RouteNames.login,
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context,
        state: state,
        child: BlocProvider(
          create: (_) => getIt<AuthCubit>(),
          child: const EmailAuthView(),
        ),
      ),
    ),

    // Sign Up Screen
    GoRoute(
      path: RouteNames.signUp,
      name: RouteNames.signUp,
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context,
        state: state,
        child: BlocProvider(
          create: (_) => getIt<AuthCubit>(),
          child: const SignUpView(),
        ),
      ),
    ),

    // Forgot Password Screen
    GoRoute(
      path: RouteNames.forgotPassword,
      name: RouteNames.forgotPassword,
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context,
        state: state,
        child: BlocProvider(
          create: (_) => getIt<AuthCubit>(),
          child: const ForgotPasswordView(),
        ),
      ),
    ),

    // Role Selection Screen
    GoRoute(
      path: RouteNames.roleSelection,
      name: RouteNames.roleSelection,
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context,
        state: state,
        child: BlocProvider(
          create: (_) => getIt<AuthCubit>(),
          child: const RoleSelectionView(),
        ),
      ),
    ),

    // Complete Profile Screen
    GoRoute(
      path: RouteNames.completeProfile,
      name: RouteNames.completeProfile,
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context,
        state: state,
        child: BlocProvider(
          create: (_) => getIt<AuthCubit>(),
          child: const CompleteProfileView(),
        ),
      ),
    ),

    // Home Screen
    GoRoute(
      path: RouteNames.home,
      name: RouteNames.home,
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context,
        state: state,
        child: const HomeView(),
      ),
    ),
  ],

  // Error handling
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 80, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'خطأ في التنقل',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            state.error.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go(RouteNames.welcome),
            child: const Text('العودة للرئيسية'),
          ),
        ],
      ),
    ),
  ),
);

// Custom page transition
CustomTransitionPage _buildPageWithTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
  );
}
