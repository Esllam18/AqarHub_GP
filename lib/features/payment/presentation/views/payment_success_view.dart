import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';

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
    final now = DateTime.now();
    final dateString =
        '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year} - ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: const SizedBox(),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(ResponsiveHelper.width(20)),
              child: Column(
                children: [
                  SizedBox(height: ResponsiveHelper.height(20)),

                  // Success Icon
                  Container(
                    width: ResponsiveHelper.width(120),
                    height: ResponsiveHelper.width(120),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.success.withOpacity(0.1),
                    ),
                    child: Icon(
                      Icons.check_circle_rounded,
                      size: ResponsiveHelper.width(80),
                      color: AppColors.success,
                    ),
                  ),

                  SizedBox(height: ResponsiveHelper.height(24)),

                  Text(
                    'تم الدفع بنجاح!',
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(28),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: ResponsiveHelper.height(12)),

                  Text(
                    'تم إرسال تأكيد الحجز إلى بريدك الإلكتروني',
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(14),
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: ResponsiveHelper.height(32)),

                  // Transaction Details Card
                  Container(
                    padding: EdgeInsets.all(ResponsiveHelper.width(20)),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(
                        ResponsiveHelper.radius(16),
                      ),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow(
                          'رقم العملية',
                          '#$transactionId',
                          isBold: true,
                        ),
                        _buildDivider(),
                        _buildDetailRow('التاريخ', dateString),
                        _buildDivider(),
                        _buildDetailRow(
                          'المبلغ المدفوع',
                          '${amount + 10} جنيه',
                          valueColor: AppColors.primary,
                          isBold: true,
                        ),
                        _buildDivider(),
                        _buildDetailRow(
                          'طريقة الدفع',
                          _getPaymentMethodName(paymentMethod),
                        ),
                        _buildDivider(),
                        _buildDetailRow('العقار', apartmentTitle),
                        _buildDivider(),
                        _buildDetailRow('نوع الدفع', 'رسوم حجز معاينة'),
                      ],
                    ),
                  ),

                  SizedBox(height: ResponsiveHelper.height(24)),

                  // Info Card
                  Container(
                    padding: EdgeInsets.all(ResponsiveHelper.width(16)),
                    decoration: BoxDecoration(
                      color: AppColors.info.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                        ResponsiveHelper.radius(12),
                      ),
                      border: Border.all(
                        color: AppColors.info.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: AppColors.info,
                          size: ResponsiveHelper.width(24),
                        ),
                        SizedBox(width: ResponsiveHelper.width(12)),
                        Expanded(
                          child: Text(
                            'سيتواصل معك المالك قريباً لتحديد موعد المعاينة',
                            style: GoogleFonts.tajawal(
                              fontSize: ResponsiveHelper.fontSize(13),
                              color: AppColors.info,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: ResponsiveHelper.height(24)),
                ],
              ),
            ),
          ),

          // Action Buttons
          Container(
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
                  // Download Receipt
                  OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'سيتم إضافة هذه الميزة قريباً',
                            style: GoogleFonts.tajawal(color: Colors.white),
                          ),
                          backgroundColor: AppColors.info,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              ResponsiveHelper.radius(12),
                            ),
                          ),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: ResponsiveHelper.height(14),
                      ),
                      side: BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(12),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long_rounded,
                          color: AppColors.primary,
                          size: ResponsiveHelper.width(20),
                        ),
                        SizedBox(width: ResponsiveHelper.width(8)),
                        Text(
                          'تحميل الإيصال',
                          style: GoogleFonts.cairo(
                            fontSize: ResponsiveHelper.fontSize(15),
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: ResponsiveHelper.height(12)),

                  // Back to Home
                  ElevatedButton(
                    onPressed: () {
                      context.go(RouteNames.mainLayout);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(
                        vertical: ResponsiveHelper.height(14),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(12),
                        ),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_rounded,
                          size: ResponsiveHelper.width(20),
                        ),
                        SizedBox(width: ResponsiveHelper.width(8)),
                        Text(
                          'العودة للرئيسية',
                          style: GoogleFonts.cairo(
                            fontSize: ResponsiveHelper.fontSize(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(14),
              color: Colors.grey.shade600,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(14),
                fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
                color: valueColor ?? Colors.black87,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey.shade300,
      height: ResponsiveHelper.height(1),
    );
  }

  String _getPaymentMethodName(String method) {
    const methods = {
      'card': 'بطاقة ائتمان',
      'fawry': 'فوري',
      'vodafone': 'فودافون كاش',
      'instapay': 'انستاباي',
      'cash': 'نقداً',
    };
    return methods[method] ?? method;
  }
}
