import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class PaymentSummaryCard extends StatelessWidget {
  final int amount;
  final int serviceFee;

  const PaymentSummaryCard({
    super.key,
    required this.amount,
    this.serviceFee = 10,
  });

  @override
  Widget build(BuildContext context) {
    final total = amount + serviceFee;

    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(20)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.secondary.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ملخص الدفع',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(16),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: ResponsiveHelper.height(16)),
          _buildSummaryRow('رسوم الحجز', '$amount جنيه'),
          SizedBox(height: ResponsiveHelper.height(12)),
          _buildSummaryRow('رسوم الخدمة', '$serviceFee جنيه'),
          SizedBox(height: ResponsiveHelper.height(12)),
          Divider(color: AppColors.primary.withOpacity(0.3)),
          SizedBox(height: ResponsiveHelper.height(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الإجمالي',
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(16),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Text(
                '$total جنيه',
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(20),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(14),
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(14),
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
