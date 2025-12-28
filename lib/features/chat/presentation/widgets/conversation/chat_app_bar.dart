import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../../../models/chat_model.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ChatModel chat;
  final bool isTyping;

  const ChatAppBar({super.key, required this.chat, this.isTyping = false});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_forward_rounded,
          color: Colors.black87,
          size: ResponsiveHelper.width(24),
        ),
        onPressed: () => context.pop(),
      ),
      title: _buildTitle(),
      actions: _buildActions(),
    );
  }

  Widget _buildTitle() {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        _buildAvatar(),
        SizedBox(width: ResponsiveHelper.width(10)),
        _buildUserInfo(),
      ],
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        Container(
          width: ResponsiveHelper.width(42),
          height: ResponsiveHelper.width(42),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: chat.isOnline ? AppColors.success : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: ClipOval(
            child: Image.network(
              chat.userImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade200,
                  child: Icon(
                    Icons.person,
                    size: ResponsiveHelper.width(20),
                    color: Colors.grey.shade400,
                  ),
                );
              },
            ),
          ),
        ),
        if (chat.isOnline) _buildOnlineIndicator(),
      ],
    );
  }

  Widget _buildOnlineIndicator() {
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        width: ResponsiveHelper.width(12),
        height: ResponsiveHelper.width(12),
        decoration: BoxDecoration(
          color: AppColors.success,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white, width: 2),
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          chat.userName,
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(16),
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        _buildStatus(),
      ],
    );
  }

  Widget _buildStatus() {
    String statusText;
    Color statusColor;

    if (isTyping) {
      statusText = 'يكتب الآن...';
      statusColor = AppColors.primary;
    } else if (chat.isOnline) {
      statusText = 'متصل الآن';
      statusColor = AppColors.success;
    } else {
      return const SizedBox.shrink();
    }

    return Text(
      statusText,
      style: GoogleFonts.tajawal(
        fontSize: ResponsiveHelper.fontSize(11),
        color: statusColor,
        fontWeight: FontWeight.w600,
      ),
      textDirection: TextDirection.rtl,
    );
  }

  List<Widget> _buildActions() {
    return [
      IconButton(
        icon: Icon(
          Icons.call_rounded,
          color: AppColors.primary,
          size: ResponsiveHelper.width(22),
        ),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(
          Icons.more_vert_rounded,
          color: Colors.black87,
          size: ResponsiveHelper.width(22),
        ),
        onPressed: () {},
      ),
    ];
  }
}
