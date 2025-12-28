import 'package:aqar_hub_gp/features/add_apartment/presentation/views/add_apartment_flow_view.dart';
import 'package:aqar_hub_gp/features/add_apartment/presentation/views/success_view.dart';
import 'package:aqar_hub_gp/features/apartment/presentation/views/apartment_details_view.dart';
import 'package:aqar_hub_gp/features/chat/models/chat_model.dart';
import 'package:aqar_hub_gp/features/chat/presentation/views/chat_conversation_view.dart';
import 'package:aqar_hub_gp/features/home_seeker/presentation/views/smart_search_view.dart';
import 'package:aqar_hub_gp/features/main_layout/presentation/views/main_layout_view.dart';
import 'package:aqar_hub_gp/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:aqar_hub_gp/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:aqar_hub_gp/features/owner/presentation/views/owner_home_view.dart';
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
        create: (context) => getIt<AuthCubit>(),
        child: const WelcomeView(),
      ),
    ),

    // Email / Login Screen
    GoRoute(
      path: RouteNames.login,
      name: RouteNames.login,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: const EmailAuthView(),
      ),
    ),

    // Sign Up Screen
    GoRoute(
      path: RouteNames.signUp,
      name: RouteNames.signUp,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: const SignUpView(),
      ),
    ),

    // Forgot Password Screen
    GoRoute(
      path: RouteNames.forgotPassword,
      name: RouteNames.forgotPassword,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: const ForgotPasswordView(),
      ),
    ),

    // Role Selection Screen
    GoRoute(
      path: RouteNames.roleSelection,
      name: RouteNames.roleSelection,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: const RoleSelectionView(),
      ),
    ),

    // Complete Profile Screen
    GoRoute(
      path: RouteNames.completeProfile,
      name: RouteNames.completeProfile,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: const CompleteProfileView(),
      ),
    ),

    // Main Layout (NEW)
    GoRoute(
      path: RouteNames.mainLayout,
      name: RouteNames.mainLayout,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final isOwner = extra?['isOwner'] as bool? ?? true;
        final user = extra?['user'];
        return MainLayoutView(isOwner: isOwner, user: user);
      },
    ),

    // Home Screen (Legacy - Keep for backward compatibility)

    // Owner Home (Legacy - Keep for backward compatibility)
    GoRoute(
      path: RouteNames.ownerHome,
      name: RouteNames.ownerHome,
      builder: (context, state) => OwnerHomeView(),
    ),

    // Smart Search (NEW)
    GoRoute(
      path: RouteNames.smartSearch,
      name: RouteNames.smartSearch,
      builder: (context, state) => const SmartSearchView(),
    ),

    // Apartment Details (NEW)
    GoRoute(
      path: RouteNames.apartmentDetails,
      name: RouteNames.apartmentDetails,
      builder: (context, state) {
        // final apartmentId = state.extra as String?;
        return const ApartmentDetailsView();
      },
    ),

    GoRoute(
      path: '/chat/:chatId',
      name: 'chatConversation',
      builder: (context, state) {
        final chat = state.extra as ChatModel;
        return ChatConversationView(chat: chat);
      },
    ),
    GoRoute(
      path: '/add-apartment',
      name: RouteNames.addApartment,
      builder: (context, state) => const AddApartmentFlowView(),
    ),
    GoRoute(
      path: '/add-apartment-success',
      name: RouteNames.addApartmentSuccess,
      builder: (context, state) {
        final isVerified = state.extra as bool? ?? false;
        return AddApartmentSuccessView(isVerified: isVerified);
      },
    ),
  ],
);
