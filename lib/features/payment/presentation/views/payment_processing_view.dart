import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';

class PaymentProcessingView extends StatefulWidget {
  final String apartmentTitle;
  final int amount;
  final String apartmentId;
  final String paymentMethod;
  final String? cardNumber;
  final String? cardHolder;

  const PaymentProcessingView({
    super.key,
    required this.apartmentTitle,
    required this.amount,
    required this.apartmentId,
    required this.paymentMethod,
    this.cardNumber,
    this.cardHolder,
  });

  @override
  State<PaymentProcessingView> createState() => _PaymentProcessingViewState();
}

class _PaymentProcessingViewState extends State<PaymentProcessingView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Simulate payment processing
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go(
          '/${RouteNames.paymentSuccess}', // ✅ ADD /
          extra: {
            'apartmentTitle': widget.apartmentTitle,
            'amount': widget.amount,
            'apartmentId': widget.apartmentId,
            'paymentMethod': widget.paymentMethod,
            'transactionId': 'TXN${DateTime.now().millisecondsSinceEpoch}',
          },
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Loading Circle
              RotationTransition(
                turns: _controller,
                child: Container(
                  width: ResponsiveHelper.width(100),
                  height: ResponsiveHelper.width(100),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: ResponsiveHelper.width(80),
                      height: ResponsiveHelper.width(80),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                      ),
                      child: Icon(
                        Icons.credit_card_rounded,
                        size: ResponsiveHelper.width(40),
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: ResponsiveHelper.height(32)),

              Text(
                'جاري المعالجة...',
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(24),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: ResponsiveHelper.height(12)),

              Text(
                'يرجى الانتظار، جاري التحقق من الدفع',
                style: GoogleFonts.tajawal(
                  fontSize: ResponsiveHelper.fontSize(14),
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: ResponsiveHelper.height(32)),

              // Processing Steps
              _buildProcessStep('التحقق من البيانات', true),
              SizedBox(height: ResponsiveHelper.height(12)),
              _buildProcessStep('معالجة الدفع', true),
              SizedBox(height: ResponsiveHelper.height(12)),
              _buildProcessStep('تأكيد العملية', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProcessStep(String text, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: ResponsiveHelper.width(24),
          height: ResponsiveHelper.width(24),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColors.primary : Colors.grey.shade300,
          ),
          child: isActive
              ? Icon(
                  Icons.check_rounded,
                  size: ResponsiveHelper.width(16),
                  color: Colors.white,
                )
              : null,
        ),
        SizedBox(width: ResponsiveHelper.width(12)),
        Text(
          text,
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(14),
            color: isActive ? Colors.black87 : Colors.grey.shade500,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
