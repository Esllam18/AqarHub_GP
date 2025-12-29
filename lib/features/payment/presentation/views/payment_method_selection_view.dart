import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';
import '../widgets/shared/payment_header.dart';
import '../widgets/shared/payment_summary_card.dart';
import '../widgets/selection_widgets/payment_methods_list.dart';
import '../widgets/selection_widgets/continue_button.dart';

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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildAppBar(),
        body: Column(
          children: [
            Expanded(child: _buildContent()),
            ContinueButton(onPressed: _continueToPayment),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(ResponsiveHelper.width(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PaymentHeader(
            apartmentTitle: widget.apartmentTitle,
            amount: widget.amount,
          ),
          SizedBox(height: ResponsiveHelper.height(24)),
          Text(
            'اختر طريقة الدفع المناسبة',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(16),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: ResponsiveHelper.height(16)),
          PaymentMethodsList(
            selectedMethod: _selectedMethod,
            onMethodSelected: (method) {
              setState(() => _selectedMethod = method);
            },
          ),
          SizedBox(height: ResponsiveHelper.height(24)),
          PaymentSummaryCard(amount: widget.amount, serviceFee: 10),
          SizedBox(height: ResponsiveHelper.height(24)),
        ],
      ),
    );
  }

  void _continueToPayment() {
    if (_selectedMethod == 'card') {
      context.push(
        '/${RouteNames.cardPayment}',
        extra: {
          'apartmentTitle': widget.apartmentTitle,
          'amount': widget.amount,
          'apartmentId': widget.apartmentId,
        },
      );
    } else {
      context.push(
        '/${RouteNames.paymentProcessing}',
        extra: {
          'apartmentTitle': widget.apartmentTitle,
          'amount': widget.amount,
          'apartmentId': widget.apartmentId,
          'paymentMethod': _selectedMethod,
        },
      );
    }
  }
}
