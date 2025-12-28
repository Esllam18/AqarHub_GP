import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../../models/message_model.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final VoidCallback? onReply;

  const MessageBubble({super.key, required this.message, this.onReply});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showMessageMenu(context),
      child: Align(
        alignment: message.isSentByMe
            ? AlignmentDirectional.centerEnd
            : AlignmentDirectional.centerStart,
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: ResponsiveHelper.height(4),
            horizontal: ResponsiveHelper.width(12),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.width(14),
            vertical: ResponsiveHelper.height(10),
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            gradient: message.isSentByMe
                ? LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  )
                : null,
            color: message.isSentByMe ? null : AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(ResponsiveHelper.radius(16)),
              topRight: Radius.circular(ResponsiveHelper.radius(16)),
              bottomLeft: message.isSentByMe
                  ? Radius.circular(ResponsiveHelper.radius(16))
                  : Radius.circular(ResponsiveHelper.radius(4)),
              bottomRight: message.isSentByMe
                  ? Radius.circular(ResponsiveHelper.radius(4))
                  : Radius.circular(ResponsiveHelper.radius(16)),
            ),
            boxShadow: [
              BoxShadow(
                color: message.isSentByMe
                    ? AppColors.primary.withOpacity(0.2)
                    : Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: message.isSentByMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              // Message Text with URL detection
              _buildMessageText(),

              SizedBox(height: ResponsiveHelper.height(4)),

              // Time & Read Status
              Row(
                mainAxisSize: MainAxisSize.min,
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    message.time,
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(10),
                      color: message.isSentByMe
                          ? AppColors.white.withOpacity(0.8)
                          : Colors.grey.shade600,
                    ),
                  ),
                  if (message.isSentByMe) ...[
                    SizedBox(width: ResponsiveHelper.width(4)),
                    _buildDeliveryStatus(),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageText() {
    return Text(
      message.message,
      style: GoogleFonts.tajawal(
        fontSize: ResponsiveHelper.fontSize(14),
        color: message.isSentByMe ? AppColors.white : Colors.black87,
        height: 1.4,
      ),
      textDirection: TextDirection.rtl,
    );
  }

  Widget _buildDeliveryStatus() {
    IconData icon;
    Color color;

    if (message.isRead) {
      icon = Icons.done_all_rounded;
      color = Colors.blue.shade300;
    } else {
      icon = Icons.done_rounded;
      color = AppColors.white.withOpacity(0.8);
    }

    return Icon(icon, size: ResponsiveHelper.width(14), color: color);
  }

  void _showMessageMenu(BuildContext context) {
    HapticFeedback.mediumImpact();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
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
              // Handle
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: ResponsiveHelper.height(12),
                ),
                width: ResponsiveHelper.width(40),
                height: ResponsiveHelper.height(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(2),
                  ),
                ),
              ),

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
                onTap: () {
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
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(12),
                        ),
                      ),
                      backgroundColor: AppColors.success,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
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
}
