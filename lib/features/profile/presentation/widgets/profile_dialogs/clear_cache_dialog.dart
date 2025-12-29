import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

void showClearCacheDialog(BuildContext context) {
  showDialog(context: context, builder: (context) => const ClearCacheDialog());
}

class ClearCacheDialog extends StatelessWidget {
  const ClearCacheDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        ),
        title: Text(
          'مسح ذاكرة التخزين المؤقت',
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(18),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'سيتم مسح الملفات المؤقتة لتحرير مساحة التخزين. هل تريد المتابعة؟',
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(14),
            color: Colors.grey.shade700,
          ),
        ),
        actions: [_buildCancelButton(context), _buildClearButton(context)],
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text(
        'إلغاء',
        style: GoogleFonts.cairo(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildClearButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        _showSuccessSnackbar(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
        ),
      ),
      child: Text(
        'مسح',
        style: GoogleFonts.cairo(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _showSuccessSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            'تم مسح ذاكرة التخزين المؤقت بنجاح',
            style: GoogleFonts.tajawal(color: Colors.white),
          ),
        ),
        backgroundColor: AppColors.success,
      ),
    );
  }
}
