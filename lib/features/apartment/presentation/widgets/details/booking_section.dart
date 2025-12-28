import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'benefit_item.dart';

class BookingSection extends StatelessWidget {
  final String apartmentTitle;
  final int bookingFee;

  const BookingSection({
    super.key,
    required this.apartmentTitle,
    this.bookingFee = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(20)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: ResponsiveHelper.height(12)),
          _buildDescription(),
          SizedBox(height: ResponsiveHelper.height(16)),
          _buildBenefitsRow(),
          SizedBox(height: ResponsiveHelper.height(16)),
          _buildPaymentButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Container(
          padding: EdgeInsets.all(ResponsiveHelper.width(10)),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
          ),
          child: Icon(
            Icons.event_available_rounded,
            color: Colors.white,
            size: ResponsiveHelper.width(24),
          ),
        ),
        SizedBox(width: ResponsiveHelper.width(12)),
        Expanded(
          child: Text(
            'احجز معاينة الآن',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      'ادفع رسوم الحجز لتأكيد موعد المعاينة مع المالك',
      style: GoogleFonts.tajawal(
        fontSize: ResponsiveHelper.fontSize(13),
        color: Colors.white.withOpacity(0.95),
        height: 1.5,
      ),
      textDirection: TextDirection.rtl,
    );
  }

  Widget _buildBenefitsRow() {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        BenefitItem(icon: Icons.verified_rounded, text: 'ضمان الموعد'),
        SizedBox(width: ResponsiveHelper.width(16)),
        BenefitItem(icon: Icons.schedule_rounded, text: 'رد سريع'),
        SizedBox(width: ResponsiveHelper.width(16)),
        BenefitItem(icon: Icons.shield_rounded, text: 'آمن ومضمون'),
      ],
    );
  }

  Widget _buildPaymentButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _handlePayment(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(24),
          vertical: ResponsiveHelper.height(14),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        textDirection: TextDirection.rtl,
        children: [
          Icon(
            Icons.payments_rounded,
            color: AppColors.primary,
            size: ResponsiveHelper.width(22),
          ),
          SizedBox(width: ResponsiveHelper.width(12)),
          Text(
            'ادفع $bookingFee جنيه - احجز الآن',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(16),
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  void _handlePayment(BuildContext context) {
    context.push(
      '/${RouteNames.paymentMethodSelection}',
      extra: {
        'apartmentTitle': apartmentTitle,
        'amount': bookingFee,
        'apartmentId': 'apt_demo_123',
      },
    );
  }
}
