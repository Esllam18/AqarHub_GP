import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';
import '../widgets/credit_card_input.dart';
import '../widgets/payment_summary_card.dart';

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

  void _processPayment() {
    if (_formKey.currentState!.validate()) {
      context.push(
        '/${RouteNames.paymentProcessing}', // ✅ ADD /
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
            'معلومات البطاقة',
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Security Badge
                      Container(
                        padding: EdgeInsets.all(ResponsiveHelper.width(16)),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            ResponsiveHelper.radius(12),
                          ),
                          border: Border.all(
                            color: AppColors.success.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock_rounded,
                              color: AppColors.success,
                              size: ResponsiveHelper.width(24),
                            ),
                            SizedBox(width: ResponsiveHelper.width(12)),
                            Expanded(
                              child: Text(
                                'بياناتك آمنة ومشفرة بتقنية SSL',
                                style: GoogleFonts.tajawal(
                                  fontSize: ResponsiveHelper.fontSize(13),
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: ResponsiveHelper.height(24)),

                      // Card Input Form
                      CreditCardInput(
                        cardNumberController: _cardNumberController,
                        cardHolderController: _cardHolderController,
                        expiryController: _expiryController,
                        cvvController: _cvvController,
                      ),

                      SizedBox(height: ResponsiveHelper.height(20)),

                      // Save Card Checkbox
                      InkWell(
                        onTap: () {
                          setState(() {
                            _saveCard = !_saveCard;
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              width: ResponsiveHelper.width(24),
                              height: ResponsiveHelper.width(24),
                              decoration: BoxDecoration(
                                color: _saveCard
                                    ? AppColors.primary
                                    : Colors.transparent,
                                border: Border.all(
                                  color: _saveCard
                                      ? AppColors.primary
                                      : Colors.grey.shade400,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                  ResponsiveHelper.radius(6),
                                ),
                              ),
                              child: _saveCard
                                  ? Icon(
                                      Icons.check_rounded,
                                      size: ResponsiveHelper.width(16),
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                            SizedBox(width: ResponsiveHelper.width(12)),
                            Text(
                              'حفظ البطاقة للمرات القادمة',
                              style: GoogleFonts.tajawal(
                                fontSize: ResponsiveHelper.fontSize(14),
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: ResponsiveHelper.height(24)),

                      // Payment Summary
                      PaymentSummaryCard(amount: widget.amount, serviceFee: 10),

                      SizedBox(height: ResponsiveHelper.height(24)),

                      // Accepted Cards
                      Text(
                        'البطاقات المقبولة',
                        style: GoogleFonts.cairo(
                          fontSize: ResponsiveHelper.fontSize(14),
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: ResponsiveHelper.height(12)),
                      Row(
                        children: [
                          _buildCardLogo('💳 Visa'),
                          SizedBox(width: ResponsiveHelper.width(12)),
                          _buildCardLogo('💳 Mastercard'),
                          SizedBox(width: ResponsiveHelper.width(12)),
                          _buildCardLogo('💳 Meeza'),
                        ],
                      ),

                      SizedBox(height: ResponsiveHelper.height(24)),
                    ],
                  ),
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
                  onPressed: _processPayment,
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
                      Icon(
                        Icons.lock_rounded,
                        size: ResponsiveHelper.width(20),
                        color: Colors.white,
                      ),
                      SizedBox(width: ResponsiveHelper.width(12)),
                      Text(
                        'ادفع ${widget.amount + 10} جنيه',
                        style: GoogleFonts.cairo(
                          fontSize: ResponsiveHelper.fontSize(16),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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

  Widget _buildCardLogo(String text) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(12),
        vertical: ResponsiveHelper.height(6),
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        text,
        style: GoogleFonts.cairo(
          fontSize: ResponsiveHelper.fontSize(12),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
