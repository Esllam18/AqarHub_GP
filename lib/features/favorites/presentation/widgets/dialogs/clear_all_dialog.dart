import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ClearAllDialog extends StatelessWidget {
  final int favoritesCount;
  final VoidCallback onConfirm;

  const ClearAllDialog({
    super.key,
    required this.favoritesCount,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(24)),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(24)),
        ),
        padding: EdgeInsets.all(ResponsiveHelper.width(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAnimatedIcon(),
            SizedBox(height: ResponsiveHelper.height(20)),
            _buildTitle(),
            SizedBox(height: ResponsiveHelper.height(12)),
            _buildDescription(),
            SizedBox(height: ResponsiveHelper.height(8)),
            _buildWarningBox(),
            SizedBox(height: ResponsiveHelper.height(24)),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedIcon() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: ResponsiveHelper.width(80),
            height: ResponsiveHelper.width(80),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.error.withOpacity(0.2),
                  AppColors.error.withOpacity(0.1),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.delete_sweep_rounded,
              color: AppColors.error,
              size: ResponsiveHelper.width(40),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle() {
    return Text(
      'مسح جميع المفضلة؟',
      style: GoogleFonts.cairo(
        fontSize: ResponsiveHelper.fontSize(22),
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      textDirection: TextDirection.rtl,
    );
  }

  Widget _buildDescription() {
    return Text(
      'سيتم حذف جميع العقارات ($favoritesCount عقار) من المفضلة بشكل نهائي.',
      textAlign: TextAlign.center,
      style: GoogleFonts.tajawal(
        fontSize: ResponsiveHelper.fontSize(14),
        color: Colors.grey.shade600,
        height: 1.6,
      ),
      textDirection: TextDirection.rtl,
    );
  }

  Widget _buildWarningBox() {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(12)),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.05),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        border: Border.all(color: AppColors.error.withOpacity(0.2), width: 1),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Icon(
            Icons.warning_rounded,
            color: AppColors.error,
            size: ResponsiveHelper.width(18),
          ),
          SizedBox(width: ResponsiveHelper.width(8)),
          Expanded(
            child: Text(
              'لا يمكن التراجع عن هذا الإجراء',
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(12),
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(child: _buildCancelButton(context)),
        SizedBox(width: ResponsiveHelper.width(12)),
        Expanded(child: _buildDeleteButton(context)),
      ],
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(14)),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.close_rounded,
              color: Colors.grey.shade700,
              size: ResponsiveHelper.width(18),
            ),
            SizedBox(width: ResponsiveHelper.width(6)),
            Text(
              'إلغاء',
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(14),
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onConfirm();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(14)),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.error, AppColors.error.withOpacity(0.8)],
          ),
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          boxShadow: [
            BoxShadow(
              color: AppColors.error.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete_rounded,
              color: AppColors.white,
              size: ResponsiveHelper.width(18),
            ),
            SizedBox(width: ResponsiveHelper.width(6)),
            Text(
              'مسح الكل',
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(14),
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
