import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'package:aqar_hub_gp/core/services/navigation_service.dart';
import 'package:aqar_hub_gp/features/splash/data/models/splash_animation_config.dart';
import 'package:aqar_hub_gp/features/splash/presentation/manager/splash_animation_manager.dart';
import 'package:aqar_hub_gp/features/splash/presentation/widgets/splash_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/splash_cubit.dart';
import '../cubit/splash_state.dart';
import '../widgets/splash_content_widget.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late SplashAnimationManager _animationManager;

  @override
  void initState() {
    super.initState();
    _initializeAndStartAnimations();
  }

  /// Initialize and start all animations
  void _initializeAndStartAnimations() {
    const config = SplashAnimationConfig();
    _animationManager = SplashAnimationManager(config: config);
    _animationManager.initialize(this);
    _startAnimationSequence();
  }

  /// Start the animation sequence
  void _startAnimationSequence() {
    context.read<SplashCubit>().startSplash();
    _animationManager.startSequence().then((_) async {
      context.read<SplashCubit>().completeSplash();
      await _handleNavigation();
    });
  }

  /// Check user authentication status
  Future<bool> _checkAuthentication() async {
    try {
      await Future.delayed(const Duration(milliseconds: 100));

      final prefs = await SharedPreferences.getInstance();
      final isAuthenticated = prefs.getBool('isAuthenticated') ?? false;

      // DEBUG: Print authentication status
      debugPrint('🔍 Checking authentication status: $isAuthenticated');

      return isAuthenticated;
    } catch (e) {
      debugPrint('❌ Error checking authentication: $e');
      return false;
    }
  }

  /// navigation to next screen based on authentication
  Future<void> _handleNavigation() async {
    final isAuthenticated = await _checkAuthentication();

    if (!mounted) return;

    if (isAuthenticated) {
      debugPrint('✅ User authenticated - Navigating to HOME');
      NavigationService.navigateToAndReplace(context, RouteNames.mainLayout);
    } else {
      debugPrint('❌ User NOT authenticated - Navigating to ONBOARDING');
      NavigationService.navigateToAndReplace(context, RouteNames.onboarding);
    }
  }

  @override
  void dispose() {
    _animationManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          return Stack(
            children: [
              SplashBackgroundWidget(
                backgroundAnimation: _animationManager.backgroundAnimation,
              ),
              SafeArea(
                child: Center(
                  child: SplashContentWidget(
                    logoScaleAnimation: _animationManager.logoScaleAnimation,
                    logoRotateAnimation: _animationManager.logoRotateAnimation,
                    logoFadeAnimation: _animationManager.logoFadeAnimation,
                    textSlideAnimation: _animationManager.textSlideAnimation,
                    textFadeAnimation: _animationManager.textFadeAnimation,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
