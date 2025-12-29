import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class SearchTypingIndicator extends StatelessWidget {
  const SearchTypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveHelper.height(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          _buildAvatar(),
          SizedBox(width: ResponsiveHelper.width(8)),
          _buildTypingContainer(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: ResponsiveHelper.width(18),
      backgroundColor: AppColors.primary.withOpacity(0.1),
      child: Icon(
        Icons.smart_toy_outlined,
        color: AppColors.primary,
        size: ResponsiveHelper.width(18),
      ),
    );
  }

  Widget _buildTypingContainer() {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(14)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _AnimatedDot(index: 0),
          SizedBox(width: ResponsiveHelper.width(4)),
          _AnimatedDot(index: 1),
          SizedBox(width: ResponsiveHelper.width(4)),
          _AnimatedDot(index: 2),
        ],
      ),
    );
  }
}

class _AnimatedDot extends StatefulWidget {
  final int index;

  const _AnimatedDot({required this.index});

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
        return Container(
          width: ResponsiveHelper.width(8),
          height: ResponsiveHelper.width(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(
              0.3 + (0.7 * ((value + widget.index * 0.33) % 1)),
            ),
            shape: BoxShape.circle,
          ),
        );
      },
      onEnd: () {
        if (mounted) setState(() {});
      },
    );
  }
}
