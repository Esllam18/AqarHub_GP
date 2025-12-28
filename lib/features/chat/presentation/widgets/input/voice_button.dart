import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class VoiceButton extends StatelessWidget {
  final bool isRecording;
  final Function(LongPressStartDetails) onLongPressStart;
  final Function(LongPressEndDetails) onLongPressEnd;

  const VoiceButton({
    super.key,
    required this.isRecording,
    required this.onLongPressStart,
    required this.onLongPressEnd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: onLongPressStart,
      onLongPressEnd: onLongPressEnd,
      child: Container(
        key: const ValueKey('voice'),
        width: ResponsiveHelper.width(48),
        height: ResponsiveHelper.width(48),
        decoration: BoxDecoration(
          color: isRecording ? AppColors.error : Colors.grey.shade200,
          shape: BoxShape.circle,
          boxShadow: isRecording
              ? [
                  BoxShadow(
                    color: AppColors.error.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Icon(
          Icons.mic_rounded,
          color: isRecording ? AppColors.white : Colors.grey.shade700,
          size: ResponsiveHelper.width(22),
        ),
      ),
    );
  }
}
