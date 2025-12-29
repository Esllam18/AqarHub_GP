import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../shared/payment_method_card.dart';

class PaymentMethodsList extends StatelessWidget {
  final String selectedMethod;
  final Function(String) onMethodSelected;

  const PaymentMethodsList({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _paymentMethods.map((method) {
        return Padding(
          padding: EdgeInsets.only(bottom: ResponsiveHelper.height(12)),
          child: PaymentMethodCard(
            title: method['title'] as String,
            subtitle: method['subtitle'] as String,
            icon: method['icon'] as IconData,
            color: method['color'] as Color,
            isSelected: selectedMethod == method['id'],
            onTap: () => onMethodSelected(method['id'] as String),
          ),
        );
      }).toList(),
    );
  }

  static final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 'card',
      'title': 'بطاقة ائتمان/خصم',
      'subtitle': 'Visa, Mastercard, Meeza',
      'icon': Icons.credit_card_rounded,
      'color': Color(0xFF1E88E5),
    },
    {
      'id': 'fawry',
      'title': 'فوري Fawry',
      'subtitle': 'ادفع من أي فرع فوري',
      'icon': Icons.store_rounded,
      'color': Color(0xFFFF6F00),
    },
    {
      'id': 'vodafone',
      'title': 'فودافون كاش',
      'subtitle': 'الدفع عبر محفظة فودافون',
      'icon': Icons.phone_android_rounded,
      'color': Color(0xFFE60000),
    },
    {
      'id': 'instapay',
      'title': 'انستاباي Instapay',
      'subtitle': 'الدفع الفوري عبر البنوك',
      'icon': Icons.account_balance_rounded,
      'color': Color(0xFF00897B),
    },
    {
      'id': 'cash',
      'title': 'نقداً عند المعاينة',
      'subtitle': 'ادفع مباشرة للمالك',
      'icon': Icons.payments_rounded,
      'color': Color(0xFF43A047),
    },
  ];
}
