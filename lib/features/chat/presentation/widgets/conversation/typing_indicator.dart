import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(12),
        vertical: ResponsiveHelper.height(8),
      ),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.width(16),
            vertical: ResponsiveHelper.height(12),
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _AnimatedDot(delay: 0),
              SizedBox(width: ResponsiveHelper.width(4)),
              _AnimatedDot(delay: 1),
              SizedBox(width: ResponsiveHelper.width(4)),
              _AnimatedDot(delay: 2),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedDot extends StatefulWidget {
  final int delay;

  const _AnimatedDot({required this.delay});

  @override
  State<_AnimatedDot> createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<_AnimatedDot> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        final animationValue = ((value + widget.delay * 0.3) % 1.0);
        return Transform.translate(
          offset: Offset(0, -5 * (1 - (animationValue - 0.5).abs() * 2)),
          child: Container(
            width: ResponsiveHelper.width(8),
            height: ResponsiveHelper.width(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
      onEnd: () {
        if (mounted) setState(() {});
      },
    );
  }
}
