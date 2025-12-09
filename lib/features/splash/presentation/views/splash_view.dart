import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'package:aqar_hub_gp/core/services/navigation_service.dart';
import 'package:aqar_hub_gp/features/splash/data/models/splash_animation_config.dart';
import 'package:aqar_hub_gp/features/splash/presentation/manager/splash_animation_manager.dart';
import 'package:aqar_hub_gp/features/splash/presentation/widgets/splash_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    // Create animation config
    const config = SplashAnimationConfig();

    // Initialize animation manager
    _animationManager = SplashAnimationManager(config: config);
    _animationManager.initialize(this);

    // Start animation sequence
    _startAnimationSequence();
  }

  /// Start the animation sequence
  void _startAnimationSequence() {
    // Emit splash started state
    context.read<SplashCubit>().startSplash();

    // Start animations
    _animationManager.startSequence().then((_) {
      // Complete splash
      // ignore: use_build_context_synchronously
      context.read<SplashCubit>().completeSplash();

      // Navigate to next screen
      _handleNavigation();
    });
  }

  ///  navigation to next screen
  void _handleNavigation() {
    NavigationService.navigateToAndReplace(context, RouteNames.onboarding);
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
              // Animated Background
              SplashBackgroundWidget(
                backgroundAnimation: _animationManager.backgroundAnimation,
              ),

              // Animated Content (Logo + Text)
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
