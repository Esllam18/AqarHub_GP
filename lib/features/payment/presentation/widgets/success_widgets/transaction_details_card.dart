import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'transaction_detail_row.dart';

class TransactionDetailsCard extends StatelessWidget {
  final String transactionId;
  final String dateString;
  final int totalAmount;
  final String paymentMethod;
  final String apartmentTitle;

  const TransactionDetailsCard({
    super.key,
    required this.transactionId,
    required this.dateString,
    required this.totalAmount,
    required this.paymentMethod,
    required this.apartmentTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(20)),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          TransactionDetailRow(
            label: 'رقم العملية',
            value: '#$transactionId',
            isBold: true,
          ),
          _buildDivider(),
          TransactionDetailRow(label: 'التاريخ', value: dateString),
          _buildDivider(),
          TransactionDetailRow(
            label: 'المبلغ المدفوع',
            value: '$totalAmount جنيه',
            valueColor: AppColors.primary,
            isBold: true,
          ),
          _buildDivider(),
          TransactionDetailRow(
            label: 'طريقة الدفع',
            value: _getPaymentMethodName(paymentMethod),
          ),
          _buildDivider(),
          TransactionDetailRow(label: 'العقار', value: apartmentTitle),
          _buildDivider(),
          TransactionDetailRow(label: 'نوع الدفع', value: 'رسوم حجز معاينة'),
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
