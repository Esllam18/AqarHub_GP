import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(context: context, builder: (context) => const LogoutDialog());
}

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        ),
        title: _buildTitle(),
        content: _buildContent(),
        actions: [_buildCancelButton(context), _buildLogoutButton(context)],
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        Icon(
          Icons.logout_rounded,
          color: AppColors.error,
          size: ResponsiveHelper.width(24),
        ),
        SizedBox(width: ResponsiveHelper.width(12)),
        Text(
          'تسجيل الخروج',
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(18),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Text(
      'هل أنت متأكد من تسجيل الخروج من حسابك؟',
      style: GoogleFonts.tajawal(
        fontSize: ResponsiveHelper.fontSize(14),
        color: Colors.grey.shade700,
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

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        context.go('/${RouteNames.welcome}');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.error,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
        ),
      ),
      child: Text(
        'تسجيل الخروج',
        style: GoogleFonts.cairo(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
