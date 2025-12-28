import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../../models/message_model.dart';
import 'message/message_actions_sheet.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final VoidCallback? onReply;

  const MessageBubble({super.key, required this.message, this.onReply});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () =>
          showMessageActionsSheet(context, message: message, onReply: onReply),
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
          decoration: _buildDecoration(),
          child: Column(
            crossAxisAlignment: message.isSentByMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              _buildMessageText(),
              SizedBox(height: ResponsiveHelper.height(4)),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      gradient: message.isSentByMe
          ? LinearGradient(colors: [AppColors.primary, AppColors.secondary])
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

  Widget _buildFooter() {
    return Row(
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
}
