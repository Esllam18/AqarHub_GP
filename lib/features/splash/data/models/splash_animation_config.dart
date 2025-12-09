import 'package:aqar_hub_gp/core/consts/app_durations.dart';

class SplashAnimationConfig {
  // Animation Durations
  final Duration logoAnimationDuration;
  final Duration textAnimationDuration;
  final Duration backgroundAnimationDuration;
  final Duration delayBeforeNavigation;

  // Logo Animation Values
  final double logoScaleBegin;
  final double logoScaleEnd;
  final double logoRotateBegin;
  final double logoRotateEnd;

  // Text Animation Values
  final double textSlideBegin;
  final double textSlideEnd;

  const SplashAnimationConfig({
    this.logoAnimationDuration = AppDurations.veryLong,
    this.textAnimationDuration = AppDurations.long,
    this.backgroundAnimationDuration = AppDurations.veryLong,
    this.delayBeforeNavigation = AppDurations.long,
    this.logoScaleBegin = 0.0,
    this.logoScaleEnd = 1.0,
    this.logoRotateBegin = -0.5,
    this.logoRotateEnd = 0.0,
    this.textSlideBegin = 50.0,
    this.textSlideEnd = 0.0,
  });
}
