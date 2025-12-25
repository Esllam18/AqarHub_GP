import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(12)),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            // Text Field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(25),
                  ),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        textDirection: TextDirection.rtl,
                        style: GoogleFonts.tajawal(
                          fontSize: ResponsiveHelper.fontSize(14),
                          color: Colors.black87,
                        ),
                        decoration: InputDecoration(
                          hintText: 'اكتب رسالتك...',
                          hintTextDirection: TextDirection.rtl,
                          hintStyle: GoogleFonts.tajawal(
                            fontSize: ResponsiveHelper.fontSize(14),
                            color: Colors.grey.shade500,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(16),
                            vertical: ResponsiveHelper.height(12),
                          ),
                        ),
                        maxLines: null,
                        textInputAction: TextInputAction.newline,
                      ),
                    ),
                    // Emoji & Attachment
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.emoji_emotions_outlined,
                            color: Colors.grey.shade600,
                            size: ResponsiveHelper.width(22),
                          ),
                          onPressed: () {
                            // TODO: Show emoji picker
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.attach_file_rounded,
                            color: Colors.grey.shade600,
                            size: ResponsiveHelper.width(22),
                          ),
                          onPressed: () {
                            // TODO: Attach file
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(width: ResponsiveHelper.width(8)),

            // Send Button
            GestureDetector(
              onTap: onSend,
              child: Container(
                width: ResponsiveHelper.width(48),
                height: ResponsiveHelper.width(48),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.send_rounded,
                  color: AppColors.white,
                  size: ResponsiveHelper.width(22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
