import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/consts/home_strings.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class SearchInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSendPressed;

  const SearchInputField({
    super.key,
    required this.controller,
    required this.onSendPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Expanded(child: _buildTextField(context)),
            SizedBox(width: ResponsiveHelper.width(12)),
            _buildSendButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: HomeStrings.typeMessage,
        hintStyle: GoogleFonts.tajawal(
          color: Colors.grey.shade400,
          fontSize: ResponsiveHelper.fontSize(14),
        ),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(25)),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(20),
          vertical: ResponsiveHelper.height(12),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.mic_rounded,
            color: AppColors.primary.withOpacity(0.6),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'ميزة البحث الصوتي قريباً',
                  style: GoogleFonts.tajawal(),
                  textDirection: TextDirection.rtl,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      ),
      style: GoogleFonts.tajawal(fontSize: ResponsiveHelper.fontSize(14)),
      textDirection: TextDirection.rtl,
      maxLines: null,
      textInputAction: TextInputAction.send,
      onSubmitted: (_) => onSendPressed(),
    );
  }

  Widget _buildSendButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: ResponsiveHelper.width(24),
        child: IconButton(
          icon: Icon(
            Icons.send_rounded,
            color: AppColors.white,
            size: ResponsiveHelper.width(20),
          ),
          onPressed: onSendPressed,
        ),
      ),
    );
  }
}
