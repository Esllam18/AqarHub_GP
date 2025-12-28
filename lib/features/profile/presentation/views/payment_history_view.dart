import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class PaymentHistoryView extends StatelessWidget {
  const PaymentHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: AppColors.primary),
            onPressed: () => context.pop(),
          ),
          title: Text(
            'سجل المدفوعات',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(18),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(ResponsiveHelper.width(16)),
          itemCount: 8,
          itemBuilder: (context, index) {
            return _buildPaymentCard(index);
          },
        ),
      ),
    );
  }

  Widget _buildPaymentCard(int index) {
    final isSuccess = index % 3 != 2;
    return Container(
      margin: EdgeInsets.only(bottom: ResponsiveHelper.height(12)),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(ResponsiveHelper.width(10)),
                    decoration: BoxDecoration(
                      color: (isSuccess ? AppColors.success : AppColors.error)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                        ResponsiveHelper.radius(10),
                      ),
                    ),
                    child: Icon(
                      isSuccess
                          ? Icons.check_circle_rounded
                          : Icons.cancel_rounded,
                      color: isSuccess ? AppColors.success : AppColors.error,
                      size: ResponsiveHelper.width(24),
                    ),
                  ),
                  SizedBox(width: ResponsiveHelper.width(12)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'رسوم حجز معاينة',
                        style: GoogleFonts.cairo(
                          fontSize: ResponsiveHelper.fontSize(15),
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: ResponsiveHelper.height(4)),
                      Text(
                        '${25 - index}/12/2024',
                        style: GoogleFonts.tajawal(
                          fontSize: ResponsiveHelper.fontSize(12),
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '210 جنيه',
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(16),
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.height(4)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.width(8),
                      vertical: ResponsiveHelper.height(4),
                    ),
                    decoration: BoxDecoration(
                      color: (isSuccess ? AppColors.success : AppColors.error)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                        ResponsiveHelper.radius(12),
                      ),
                    ),
                    child: Text(
                      isSuccess ? 'مكتمل' : 'فشل',
                      style: GoogleFonts.tajawal(
                        fontSize: ResponsiveHelper.fontSize(11),
                        fontWeight: FontWeight.bold,
                        color: isSuccess ? AppColors.success : AppColors.error,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: ResponsiveHelper.height(12)),
          Divider(color: Colors.grey.shade200, height: 1),
          SizedBox(height: ResponsiveHelper.height(8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'رقم العملية: #TXN${123450 + index}',
                style: GoogleFonts.tajawal(
                  fontSize: ResponsiveHelper.fontSize(12),
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                'بطاقة ائتمان',
                style: GoogleFonts.tajawal(
                  fontSize: ResponsiveHelper.fontSize(12),
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
