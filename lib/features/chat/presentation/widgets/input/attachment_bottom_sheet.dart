import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'attachment_option_item.dart';

void showAttachmentBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => const AttachmentBottomSheet(),
  );
}

class AttachmentBottomSheet extends StatelessWidget {
  const AttachmentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ResponsiveHelper.radius(24)),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHandle(),
            _buildContent(context),
            SizedBox(height: ResponsiveHelper.height(8)),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(12)),
      width: ResponsiveHelper.width(40),
      height: ResponsiveHelper.height(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(2)),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ResponsiveHelper.width(24)),
      child: Column(
        children: [
          Text(
            'إرفاق ملف',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(18),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: ResponsiveHelper.height(20)),
          _buildOptions(context),
        ],
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AttachmentOptionItem(
          icon: Icons.camera_alt_rounded,
          label: 'كاميرا',
          color: Colors.purple,
          onTap: () => Navigator.pop(context),
        ),
        AttachmentOptionItem(
          icon: Icons.photo_library_rounded,
          label: 'معرض',
          color: Colors.pink,
          onTap: () => Navigator.pop(context),
        ),
        AttachmentOptionItem(
          icon: Icons.insert_drive_file_rounded,
          label: 'ملف',
          color: Colors.blue,
          onTap: () => Navigator.pop(context),
        ),
        AttachmentOptionItem(
          icon: Icons.location_on_rounded,
          label: 'موقع',
          color: Colors.green,
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
