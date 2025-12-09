import 'package:aqar_hub_gp/features/splash/data/models/splash_animation_config.dart';
import 'package:flutter/material.dart';

class SplashAnimationManager {
  // Animation Controllers
  late AnimationController logoController;
  late AnimationController textController;
  late AnimationController backgroundController;

  // Logo Animations
  late Animation<double> logoScaleAnimation;
  late Animation<double> logoRotateAnimation;
  late Animation<double> logoFadeAnimation;

  // Text Animations
  late Animation<double> textSlideAnimation;
  late Animation<double> textFadeAnimation;

  // Background Animation
  late Animation<double> backgroundAnimation;

  final SplashAnimationConfig config;

  SplashAnimationManager({required this.config});

  /// Initialize all animations
  void initialize(TickerProvider vsync) {
    _initializeLogoAnimations(vsync);
    _initializeTextAnimations(vsync);
    _initializeBackgroundAnimation(vsync);
  }

  /// Initialize logo animations
  void _initializeLogoAnimations(TickerProvider vsync) {
    logoController = AnimationController(
      duration: config.logoAnimationDuration,
      vsync: vsync,
    );

    logoScaleAnimation =
        Tween<double>(
          begin: config.logoScaleBegin,
          end: config.logoScaleEnd,
        ).animate(
          CurvedAnimation(parent: logoController, curve: Curves.elasticOut),
        );

    logoRotateAnimation =
        Tween<double>(
          begin: config.logoRotateBegin,
          end: config.logoRotateEnd,
        ).animate(
          CurvedAnimation(parent: logoController, curve: Curves.easeOutCubic),
        );

    logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );
  }

  /// Initialize text animations
  void _initializeTextAnimations(TickerProvider vsync) {
    textController = AnimationController(
      duration: config.textAnimationDuration,
      vsync: vsync,
    );

    textSlideAnimation =
        Tween<double>(
          begin: config.textSlideBegin,
          end: config.textSlideEnd,
        ).animate(
          CurvedAnimation(parent: textController, curve: Curves.easeOutCubic),
        );

    textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: textController, curve: Curves.easeIn));
  }

  /// Initialize background animation
  void _initializeBackgroundAnimation(TickerProvider vsync) {
    backgroundController = AnimationController(
      duration: config.backgroundAnimationDuration,
      vsync: vsync,
    );

    backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: backgroundController, curve: Curves.easeInOut),
    );
  }

  /// Start animation sequence
  Future<void> startSequence() async {
    // Start background animation
    backgroundController.forward();

    // Start logo animation
    await logoController.forward();

    // Start text animation after logo
    await textController.forward();

    // Wait before completing
    await Future.delayed(config.delayBeforeNavigation);
  }

  void dispose() {
    logoController.dispose();
    textController.dispose();
    backgroundController.dispose();
  }
}
