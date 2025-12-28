import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ChatActionBar extends StatelessWidget {
  final VoidCallback onTap;

  const ChatActionBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(ResponsiveHelper.width(16)),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: ResponsiveHelper.height(14),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ),
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(14),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: [
                  Icon(
                    Icons.chat_bubble_rounded,
                    color: AppColors.white,
                    size: ResponsiveHelper.width(22),
                  ),
                  SizedBox(width: ResponsiveHelper.width(10)),
                  Text(
                    'محادثة المالك',
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(16),
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
