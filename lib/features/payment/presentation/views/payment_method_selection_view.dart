import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';
import '../widgets/payment_method_card.dart';
import '../widgets/payment_summary_card.dart';
import '../widgets/payment_header.dart';

class PaymentMethodSelectionView extends StatefulWidget {
  final String apartmentTitle;
  final int amount;
  final String apartmentId;

  const PaymentMethodSelectionView({
    super.key,
    required this.apartmentTitle,
    required this.amount,
    required this.apartmentId,
  });

  @override
  State<PaymentMethodSelectionView> createState() =>
      _PaymentMethodSelectionViewState();
}

class _PaymentMethodSelectionViewState
    extends State<PaymentMethodSelectionView> {
  String _selectedMethod = 'card';

  final List<Map<String, dynamic>> _paymentMethods = [
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

  void _onMethodSelected(String methodId) {
    setState(() {
      _selectedMethod = methodId;
    });
  }

  void _continueToPayment() {
    if (_selectedMethod == 'card') {
      context.push(
        '/${RouteNames.cardPayment}', // ✅ ADD /
        extra: {
          'apartmentTitle': widget.apartmentTitle,
          'amount': widget.amount,
          'apartmentId': widget.apartmentId,
        },
      );
    } else {
      context.push(
        '/${RouteNames.paymentProcessing}', // ✅ ADD /
        extra: {
          'apartmentTitle': widget.apartmentTitle,
          'amount': widget.amount,
          'apartmentId': widget.apartmentId,
          'paymentMethod': _selectedMethod,
        },
      );
    }
  }

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
            'اختر طريقة الدفع',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(18),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(ResponsiveHelper.width(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Info
                    PaymentHeader(
                      apartmentTitle: widget.apartmentTitle,
                      amount: widget.amount,
                    ),

                    SizedBox(height: ResponsiveHelper.height(24)),

                    // Payment Methods
                    Text(
                      'اختر طريقة الدفع المناسبة',
                      style: GoogleFonts.cairo(
                        fontSize: ResponsiveHelper.fontSize(16),
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: ResponsiveHelper.height(16)),

                    // Payment Method Cards
                    ...(_paymentMethods.map((method) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: ResponsiveHelper.height(12),
                        ),
                        child: PaymentMethodCard(
                          title: method['title'],
                          subtitle: method['subtitle'],
                          icon: method['icon'],
                          color: method['color'],
                          isSelected: _selectedMethod == method['id'],
                          onTap: () => _onMethodSelected(method['id']),
                        ),
                      );
                    }).toList()),

                    SizedBox(height: ResponsiveHelper.height(24)),

                    // Payment Summary
                    PaymentSummaryCard(amount: widget.amount, serviceFee: 10),

                    SizedBox(height: ResponsiveHelper.height(24)),
                  ],
                ),
              ),
            ),

            // Bottom Button
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
                child: ElevatedButton(
                  onPressed: _continueToPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(
                      vertical: ResponsiveHelper.height(16),
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
                      Text(
                        'متابعة للدفع',
                        style: GoogleFonts.cairo(
                          fontSize: ResponsiveHelper.fontSize(16),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: ResponsiveHelper.width(8)),
                      Icon(
                        Icons.arrow_back_ios_rounded,
                        size: ResponsiveHelper.width(16),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
