import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class PaymentHeader extends StatelessWidget {
  final String apartmentTitle;
  final int amount;

  const PaymentHeader({
    super.key,
    required this.apartmentTitle,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          _buildIcon(),
          SizedBox(width: ResponsiveHelper.width(16)),
          Expanded(child: _buildInfo()),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: ResponsiveHelper.width(60),
      height: ResponsiveHelper.width(60),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
      ),
      child: Icon(
        Icons.apartment_rounded,
        color: AppColors.primary,
        size: ResponsiveHelper.width(30),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          apartmentTitle,
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(15),
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: ResponsiveHelper.height(4)),
        Row(
          children: [
            Icon(
              Icons.payments_rounded,
              size: ResponsiveHelper.width(16),
              color: AppColors.primary,
            ),
            SizedBox(width: ResponsiveHelper.width(4)),
            Text(
              'رسوم الحجز: $amount جنيه',
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(13),
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
