import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';
import '../widgets/success_widgets/success_icon.dart';
import '../widgets/success_widgets/transaction_details_card.dart';
import '../widgets/success_widgets/info_notification_card.dart';
import '../widgets/success_widgets/download_receipt_button.dart';
import '../widgets/success_widgets/back_to_home_button.dart';

class PaymentSuccessView extends StatelessWidget {
  final String apartmentTitle;
  final int amount;
  final String apartmentId;
  final String paymentMethod;
  final String transactionId;

  const PaymentSuccessView({
    super.key,
    required this.apartmentTitle,
    required this.amount,
    required this.apartmentId,
    required this.paymentMethod,
    required this.transactionId,
  });

  @override
  Widget build(BuildContext context) {
    final dateString = _formatDateTime(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: const SizedBox(),
      ),
      body: Column(
        children: [
          Expanded(child: _buildContent(dateString)),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildContent(String dateString) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(ResponsiveHelper.width(20)),
      child: Column(
        children: [
          SizedBox(height: ResponsiveHelper.height(20)),
          const SuccessIcon(),
          SizedBox(height: ResponsiveHelper.height(24)),
          _buildSuccessTitle(),
          SizedBox(height: ResponsiveHelper.height(12)),
          _buildSuccessSubtitle(),
          SizedBox(height: ResponsiveHelper.height(32)),
          TransactionDetailsCard(
            transactionId: transactionId,
            dateString: dateString,
            totalAmount: amount + 10,
            paymentMethod: paymentMethod,
            apartmentTitle: apartmentTitle,
          ),
          SizedBox(height: ResponsiveHelper.height(24)),
          const InfoNotificationCard(
            message: 'سيتواصل معك المالك قريباً لتحديد موعد المعاينة',
          ),
          SizedBox(height: ResponsiveHelper.height(24)),
        ],
      ),
    );
  }

  Widget _buildSuccessTitle() {
    return Text(
      'تم الدفع بنجاح!',
      style: GoogleFonts.cairo(
        fontSize: ResponsiveHelper.fontSize(28),
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildSuccessSubtitle() {
    return Text(
      'تم إرسال تأكيد الحجز إلى بريدك الإلكتروني',
      style: GoogleFonts.tajawal(
        fontSize: ResponsiveHelper.fontSize(14),
        color: Colors.grey.shade600,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(20)),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            DownloadReceiptButton(onPressed: () => _showComingSoon(context)),
            SizedBox(height: ResponsiveHelper.height(12)),
            BackToHomeButton(
              onPressed: () => context.go(RouteNames.mainLayout),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/'
        '${dateTime.month.toString().padLeft(2, '0')}/'
        '${dateTime.year} - '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'سيتم إضافة هذه الميزة قريباً',
          style: GoogleFonts.tajawal(color: Colors.white),
        ),
        backgroundColor: AppColors.info,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        ),
      ),
    );
  }
}
