import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

void showLanguageDialog(BuildContext context) {
  showDialog(context: context, builder: (context) => const LanguageDialog());
}

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        ),
        title: Text(
          'اختر اللغة',
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(18),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption(context, 'العربية', true),
            SizedBox(height: ResponsiveHelper.height(12)),
            _buildLanguageOption(context, 'English', false),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String language,
    bool isSelected,
  ) {
    return InkWell(
      onTap: () => _handleLanguageSelect(context),
      borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
      child: Container(
        padding: EdgeInsets.all(ResponsiveHelper.width(16)),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: isSelected ? AppColors.primary : Colors.grey.shade400,
            ),
            SizedBox(width: ResponsiveHelper.width(12)),
            Text(
              language,
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(15),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColors.primary : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLanguageSelect(BuildContext context) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            'سيتم تغيير اللغة قريباً',
            style: GoogleFonts.tajawal(color: Colors.white),
          ),
        ),
        backgroundColor: AppColors.info,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        ),
      ),
    );
  }
}
