import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../../../models/message_model.dart';

void showMessageActionsSheet(
  BuildContext context, {
  required MessageModel message,
  VoidCallback? onReply,
}) {
  HapticFeedback.mediumImpact();
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) =>
        MessageActionsSheet(message: message, onReply: onReply),
  );
}

class MessageActionsSheet extends StatelessWidget {
  final MessageModel message;
  final VoidCallback? onReply;

  const MessageActionsSheet({super.key, required this.message, this.onReply});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ResponsiveHelper.radius(24)),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHandle(),
            _buildMenuItem(
              context,
              icon: Icons.reply_rounded,
              label: 'رد',
              onTap: () {
                Navigator.pop(context);
                onReply?.call();
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.copy_rounded,
              label: 'نسخ',
              onTap: () => _handleCopy(context),
            ),
            _buildMenuItem(
              context,
              icon: Icons.forward_rounded,
              label: 'إعادة توجيه',
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement forward
              },
            ),
            if (message.isSentByMe)
              _buildMenuItem(
                context,
                icon: Icons.delete_rounded,
                label: 'حذف',
                color: AppColors.error,
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement delete
                },
              ),
            SizedBox(height: ResponsiveHelper.height(8)),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(12)),
      width: ResponsiveHelper.width(40),
      height: ResponsiveHelper.height(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(2)),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    final itemColor = color ?? Colors.black87;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(24),
          vertical: ResponsiveHelper.height(16),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Icon(icon, color: itemColor, size: ResponsiveHelper.width(22)),
            SizedBox(width: ResponsiveHelper.width(16)),
            Text(
              label,
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(15),
                fontWeight: FontWeight.w600,
                color: itemColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleCopy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: message.message));
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم نسخ النص',
          style: GoogleFonts.cairo(),
          textDirection: TextDirection.rtl,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        ),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
