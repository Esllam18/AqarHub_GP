import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestion(),
          SizedBox(height: ResponsiveHelper.height(8)),
          _buildAnswer(),
        ],
      ),
    );
  }

  Widget _buildQuestion() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.help_rounded,
          color: AppColors.primary,
          size: ResponsiveHelper.width(20),
        ),
        SizedBox(width: ResponsiveHelper.width(12)),
        Expanded(
          child: Text(
            question,
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(14),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnswer() {
    return Padding(
      padding: EdgeInsets.only(right: ResponsiveHelper.width(32)),
      child: Text(
        answer,
        style: GoogleFonts.tajawal(
          fontSize: ResponsiveHelper.fontSize(13),
          color: Colors.grey.shade700,
          height: 1.5,
        ),
      ),
    );
  }
}
