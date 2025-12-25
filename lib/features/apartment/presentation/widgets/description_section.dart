import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class DescriptionSection extends StatefulWidget {
  final String description;

  const DescriptionSection({super.key, required this.description});

  @override
  State<DescriptionSection> createState() => _DescriptionSectionState();
}

class _DescriptionSectionState extends State<DescriptionSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(14)), // ✅ Reduced
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(14)),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                padding: EdgeInsets.all(ResponsiveHelper.width(6)),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(8),
                  ),
                ),
                child: Icon(
                  Icons.description_rounded,
                  color: AppColors.primary,
                  size: ResponsiveHelper.width(16),
                ),
              ),
              SizedBox(width: ResponsiveHelper.width(8)),
              Text(
                'الوصف',
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(16),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),

          SizedBox(height: ResponsiveHelper.height(10)),

          // Description Text
          AnimatedCrossFade(
            firstChild: Text(
              widget.description.length > 150
                  ? '${widget.description.substring(0, 150)}...'
                  : widget.description,
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(13), // ✅ Reduced
                color: Colors.grey.shade700,
                height: 1.6,
              ),
              textDirection: TextDirection.rtl,
            ),
            secondChild: Text(
              widget.description,
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(13),
                color: Colors.grey.shade700,
                height: 1.6,
              ),
              textDirection: TextDirection.rtl,
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),

          // Show More/Less Button
          if (widget.description.length > 150)
            Padding(
              padding: EdgeInsets.only(top: ResponsiveHelper.height(10)),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      _isExpanded ? 'عرض أقل' : 'عرض المزيد',
                      style: GoogleFonts.tajawal(
                        fontSize: ResponsiveHelper.fontSize(12),
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.width(4)),
                    Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: AppColors.primary,
                      size: ResponsiveHelper.width(16),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
