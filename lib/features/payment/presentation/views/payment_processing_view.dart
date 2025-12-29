import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';
import '../widgets/processing_widgets/animated_loading_indicator.dart';
import '../widgets/processing_widgets/process_step_item.dart';

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
    _simulatePaymentProcessing();
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
              AnimatedLoadingIndicator(controller: _controller),
              SizedBox(height: ResponsiveHelper.height(32)),
              _buildTitle(),
              SizedBox(height: ResponsiveHelper.height(12)),
              _buildSubtitle(),
              SizedBox(height: ResponsiveHelper.height(32)),
              _buildProcessSteps(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'جاري المعالجة...',
      style: GoogleFonts.cairo(
        fontSize: ResponsiveHelper.fontSize(24),
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'يرجى الانتظار، جاري التحقق من الدفع',
      style: GoogleFonts.tajawal(
        fontSize: ResponsiveHelper.fontSize(14),
        color: Colors.grey.shade600,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildProcessSteps() {
    return Column(
      children: [
        const ProcessStepItem(text: 'التحقق من البيانات', isActive: true),
        SizedBox(height: ResponsiveHelper.height(12)),
        const ProcessStepItem(text: 'معالجة الدفع', isActive: true),
        SizedBox(height: ResponsiveHelper.height(12)),
        const ProcessStepItem(text: 'تأكيد العملية', isActive: false),
      ],
    );
  }

  void _simulatePaymentProcessing() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go(
          '/${RouteNames.paymentSuccess}',
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
}
