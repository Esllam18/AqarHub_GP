import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../../models/chat_model.dart';

class ChatListItem extends StatelessWidget {
  final ChatModel chat;
  final VoidCallback onTap;

  const ChatListItem({super.key, required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(16),
          vertical: ResponsiveHelper.height(6),
        ),
        padding: EdgeInsets.all(ResponsiveHelper.width(12)),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(14)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            // User Image with Online Indicator
            Stack(
              children: [
                Container(
                  width: ResponsiveHelper.width(56),
                  height: ResponsiveHelper.width(56),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: chat.unreadCount > 0
                          ? AppColors.primary
                          : Colors.grey.shade200,
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
                            size: ResponsiveHelper.width(28),
                            color: Colors.grey.shade400,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if (chat.isOnline)
                  Positioned(
                    bottom: 2,
                    left: 2,
                    child: Container(
                      width: ResponsiveHelper.width(14),
                      height: ResponsiveHelper.width(14),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(width: ResponsiveHelper.width(12)),

            // Chat Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        chat.userName,
                        style: GoogleFonts.cairo(
                          fontSize: ResponsiveHelper.fontSize(15),
                          fontWeight: chat.unreadCount > 0
                              ? FontWeight.bold
                              : FontWeight.w600,
                          color: Colors.black87,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        chat.time,
                        style: GoogleFonts.tajawal(
                          fontSize: ResponsiveHelper.fontSize(11),
                          color: chat.unreadCount > 0
                              ? AppColors.primary
                              : Colors.grey.shade600,
                          fontWeight: chat.unreadCount > 0
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ResponsiveHelper.height(6)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        child: Text(
                          chat.lastMessage,
                          style: GoogleFonts.tajawal(
                            fontSize: ResponsiveHelper.fontSize(13),
                            color: chat.unreadCount > 0
                                ? Colors.black87
                                : Colors.grey.shade600,
                            fontWeight: chat.unreadCount > 0
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                          textDirection: TextDirection.rtl,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (chat.unreadCount > 0)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(8),
                            vertical: ResponsiveHelper.height(4),
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.primary, AppColors.secondary],
                            ),
                            borderRadius: BorderRadius.circular(
                              ResponsiveHelper.radius(12),
                            ),
                          ),
                          child: Text(
                            chat.unreadCount.toString(),
                            style: GoogleFonts.cairo(
                              fontSize: ResponsiveHelper.fontSize(11),
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
