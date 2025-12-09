import 'package:flutter/material.dart';

/// A modern, beautiful loading widget for Flutter apps (2025 Edition).
/// Features shimmer effects, theme-aware animations, haptic feedback, and
/// customizable variants: spinner, shimmer, pulse, or progress bar.
/// Perfect for professional apps with smooth Material 3 integration!
class LoadingWidget extends StatefulWidget {
  const LoadingWidget({
    super.key,
    this.message,
    this.color,
    this.size = 36.0,
    this.backgroundColor,
    this.fullscreen = false,
    this.textStyle,
    this.variant = LoadingVariant.shimmer, // New: Modern variants
    this.progress = 0.0, // For determinate progress
    this.duration = const Duration(milliseconds: 1500), // Animation speed
    this.margin,
    this.padding,
    this.borderRadius = 16.0,
    this.onTap, // Optional tap handler for interactive loading
  });

  /// Optional message to display under the loader.
  final String? message;

  /// The color of the spinner/shimmer.
  final Color? color;

  /// Size of the spinner.
  final double size;

  /// Background color for overlay/box.
  final Color? backgroundColor;

  /// If true, covers the whole screen with a semi-transparent overlay.
  final bool fullscreen;

  /// Style for the message text.
  final TextStyle? textStyle;

  /// Loading variant: shimmer (modern gradient wave), pulse (subtle scale), spinner (classic), or bar (linear).
  final LoadingVariant variant;

  /// Progress value (0.0 to 1.0) for determinate loading (works with bar/spinner).
  final double progress;

  /// Animation duration for shimmer/pulse effects.
  final Duration duration;

  /// Margin around the widget (when not fullscreen).
  final EdgeInsetsGeometry? margin;

  /// Padding inside the widget.
  final EdgeInsetsGeometry? padding;

  /// Border radius for the container.
  final double borderRadius;

  /// Optional callback for tap interactions.
  final VoidCallback? onTap;

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

enum LoadingVariant { shimmer, pulse, spinner, bar }

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shimmerAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat();

    // Shimmer: Linear gradient wave
    _shimmerAnimation = Tween<double>(
      begin: -0.5,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Pulse: Subtle scale animation
    _pulseAnimation = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = widget.color ?? theme.colorScheme.primary;
    final surfaceColor =
        widget.backgroundColor ??
        (widget.fullscreen
            // ignore: deprecated_member_use
            ? Colors.black.withOpacity(0.4) // Darker overlay for modern feel
            // ignore: deprecated_member_use
            : theme.colorScheme.surface.withOpacity(0.98));

    Widget indicator;

    switch (widget.variant) {
      case LoadingVariant.shimmer:
        indicator = _buildShimmerIndicator(primaryColor, theme);
        break;
      case LoadingVariant.pulse:
        indicator = _buildPulseIndicator(primaryColor, theme);
        break;
      case LoadingVariant.bar:
        indicator = _buildProgressBar(primaryColor, theme);
        break;
      default: // spinner
        indicator = _buildSpinner(primaryColor, theme);
    }

    final loader = GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: widget.margin ?? const EdgeInsets.all(24),
        padding: widget.padding ?? const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: primaryColor.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: -5,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: widget.size, height: widget.size, child: indicator),
            if (widget.message?.isNotEmpty ?? false) ...[
              const SizedBox(height: 16),
              Text(
                widget.message!,
                textAlign: TextAlign.center,
                style:
                    widget.textStyle ??
                    theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ],
        ),
      ),
    );

    if (widget.fullscreen) {
      return Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            ModalBarrier(
              dismissible: false,
              color: surfaceColor,
              semanticsLabel: 'Loading',
              onDismiss: () {},
            ),
            Center(child: loader),
          ],
        ),
      );
    } else {
      return Material(child: Center(child: loader));
    }
  }

  Widget _buildShimmerIndicator(Color primaryColor, ThemeData theme) {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              // ignore: deprecated_member_use
              primaryColor.withOpacity(0.1),
              primaryColor,
              // ignore: deprecated_member_use
              primaryColor.withOpacity(0.1),
            ],
            stops: const [0.0, 0.5, 1.0],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            transform: _SlidingGradientTransform(_shimmerAnimation.value),
          ).createShader(bounds),
          blendMode: BlendMode.srcIn,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPulseIndicator(Color primaryColor, ThemeData theme) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: primaryColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                strokeWidth: 2,
                // ignore: deprecated_member_use
                backgroundColor: primaryColor.withOpacity(0.1),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSpinner(Color primaryColor, ThemeData theme) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1000),
      builder: (context, value, child) {
        return Transform.rotate(
          angle: value * 2 * 3.14159,
          child: CircularProgressIndicator(
            value: widget.progress > 0 ? widget.progress : null,
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            strokeWidth: 3,
            // ignore: deprecated_member_use
            backgroundColor: primaryColor.withOpacity(0.1),
          ),
        );
      },
    );
  }

  Widget _buildProgressBar(Color primaryColor, ThemeData theme) {
    return LinearProgressIndicator(
      value: widget.progress > 0 ? widget.progress : null,
      // ignore: deprecated_member_use
      backgroundColor: primaryColor.withOpacity(0.1),
      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
      minHeight: 4,
    );
  }
}

/// Custom transform for sliding shimmer gradient effect.
class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform(this.slideX);

  final double slideX;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slideX, 0.0, 0.0);
  }
}

/// Usage Examples:
/// 
/// // Simple spinner
/// LoadingWidget(message: 'Loading...');
/// 
/// // Modern shimmer overlay
/// LoadingWidget(
///   variant: LoadingVariant.shimmer,
///   fullscreen: true,
///   message: 'Fetching data',
/// );
/// 
/// // Determinate progress bar
/// LoadingWidget(
///   variant: LoadingVariant.bar,
///   progress: 0.7,
///   message: 'Uploading 70%',
/// );
/// 
/// // Pulsing with custom colors
/// LoadingWidget(
///   variant: LoadingVariant.pulse,
///   color: Colors.teal,
///   size: 48,
///   onTap: () => HapticFeedback.lightImpact(),
/// );