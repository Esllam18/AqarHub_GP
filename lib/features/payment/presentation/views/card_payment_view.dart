import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';
import '../widgets/card_payment_widgets/credit_card_input.dart';
import '../widgets/card_payment_widgets/security_badge.dart';
import '../widgets/card_payment_widgets/save_card_checkbox.dart';
import '../widgets/card_payment_widgets/accepted_cards_section.dart';
import '../widgets/card_payment_widgets/payment_action_button.dart';
import '../widgets/shared/payment_summary_card.dart';

class CardPaymentView extends StatefulWidget {
  final String apartmentTitle;
  final int amount;
  final String apartmentId;

  const CardPaymentView({
    super.key,
    required this.apartmentTitle,
    required this.amount,
    required this.apartmentId,
  });

  @override
  State<CardPaymentView> createState() => _CardPaymentViewState();
}

class _CardPaymentViewState extends State<CardPaymentView> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  bool _saveCard = false;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildAppBar(),
        body: Column(
          children: [
            Expanded(child: _buildForm()),
            PaymentActionButton(
              totalAmount: widget.amount + 10,
              onPressed: _processPayment,
            ),
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
        'معلومات البطاقة',
        style: GoogleFonts.cairo(
          fontSize: ResponsiveHelper.fontSize(18),
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(ResponsiveHelper.width(20)),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SecurityBadge(),
            SizedBox(height: ResponsiveHelper.height(24)),
            CreditCardInput(
              cardNumberController: _cardNumberController,
              cardHolderController: _cardHolderController,
              expiryController: _expiryController,
              cvvController: _cvvController,
            ),
            SizedBox(height: ResponsiveHelper.height(20)),
            SaveCardCheckbox(
              isChecked: _saveCard,
              onChanged: (value) => setState(() => _saveCard = value),
            ),
            SizedBox(height: ResponsiveHelper.height(24)),
            PaymentSummaryCard(amount: widget.amount, serviceFee: 10),
            SizedBox(height: ResponsiveHelper.height(24)),
            const AcceptedCardsSection(),
            SizedBox(height: ResponsiveHelper.height(24)),
          ],
        ),
      ),
    );
  }

  void _processPayment() {
    if (_formKey.currentState!.validate()) {
      context.push(
        '/${RouteNames.paymentProcessing}',
        extra: {
          'apartmentTitle': widget.apartmentTitle,
          'amount': widget.amount,
          'apartmentId': widget.apartmentId,
          'paymentMethod': 'card',
          'cardNumber': _cardNumberController.text,
          'cardHolder': _cardHolderController.text,
        },
      );
    }
  }
}
