import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class MediaVideoCard extends StatelessWidget {
  final String videoName;
  final int index;
  final VoidCallback onRemove;

  const MediaVideoCard({
    super.key,
    required this.videoName,
    required this.index,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ResponsiveHelper.height(10)),
      padding: EdgeInsets.all(ResponsiveHelper.width(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          _buildVideoIcon(),
          SizedBox(width: ResponsiveHelper.width(12)),
          _buildVideoInfo(),
          _buildDeleteButton(),
        ],
      ),
    );
  }

  Widget _buildVideoIcon() {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(12)),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
      ),
      child: Icon(
        Icons.videocam_rounded,
        color: AppColors.secondary,
        size: ResponsiveHelper.width(24),
      ),
    );
  }

  Widget _buildVideoInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            videoName,
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(14),
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: ResponsiveHelper.height(4)),
          Text(
            'فيديو ${index + 1}',
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(12),
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteButton() {
    return IconButton(
      onPressed: onRemove,
      icon: Icon(
        Icons.delete_outline_rounded,
        color: Colors.red,
        size: ResponsiveHelper.width(20),
      ),
    );
  }
}
