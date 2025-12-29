import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class SaveCardCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  const SaveCardCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!isChecked),
      child: Row(
        children: [
          _buildCheckbox(),
          SizedBox(width: ResponsiveHelper.width(12)),
          Text(
            'حفظ البطاقة للمرات القادمة',
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(14),
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox() {
    return Container(
      width: ResponsiveHelper.width(24),
      height: ResponsiveHelper.width(24),
      decoration: BoxDecoration(
        color: isChecked ? AppColors.primary : Colors.transparent,
        border: Border.all(
          color: isChecked ? AppColors.primary : Colors.grey.shade400,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(6)),
      ),
      child: isChecked
          ? Icon(
              Icons.check_rounded,
              size: ResponsiveHelper.width(16),
              color: Colors.white,
            )
          : null,
    );
  }
}
