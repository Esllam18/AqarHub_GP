import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../../utils/card_input_formatters.dart';

class CreditCardInput extends StatelessWidget {
  final TextEditingController cardNumberController;
  final TextEditingController cardHolderController;
  final TextEditingController expiryController;
  final TextEditingController cvvController;

  const CreditCardInput({
    super.key,
    required this.cardNumberController,
    required this.cardHolderController,
    required this.expiryController,
    required this.cvvController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCardNumberField(),
        SizedBox(height: ResponsiveHelper.height(20)),
        _buildCardHolderField(),
        SizedBox(height: ResponsiveHelper.height(20)),
        Row(
          children: [
            Expanded(child: _buildExpiryField()),
            SizedBox(width: ResponsiveHelper.width(16)),
            Expanded(child: _buildCVVField()),
          ],
        ),
      ],
    );
  }

  Widget _buildCardNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('رقم البطاقة'),
        SizedBox(height: ResponsiveHelper.height(8)),
        TextFormField(
          controller: cardNumberController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
            CardNumberInputFormatter(),
          ],
          decoration: _buildInputDecoration(
            hintText: '1234 5678 9012 3456',
            icon: Icons.credit_card_rounded,
          ),
          style: GoogleFonts.cairo(fontSize: ResponsiveHelper.fontSize(16)),
          validator: _validateCardNumber,
        ),
      ],
    );
  }

  Widget _buildCardHolderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('اسم حامل البطاقة'),
        SizedBox(height: ResponsiveHelper.height(8)),
        TextFormField(
          controller: cardHolderController,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.characters,
          decoration: _buildInputDecoration(
            hintText: 'AHMED MOHAMED',
            icon: Icons.person_outline_rounded,
          ),
          style: GoogleFonts.cairo(fontSize: ResponsiveHelper.fontSize(16)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'يرجى إدخال الاسم';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildExpiryField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('تاريخ الانتهاء'),
        SizedBox(height: ResponsiveHelper.height(8)),
        TextFormField(
          controller: expiryController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(4),
            ExpiryDateInputFormatter(),
          ],
          decoration: _buildInputDecoration(hintText: 'MM/YY'),
          style: GoogleFonts.cairo(fontSize: ResponsiveHelper.fontSize(16)),
          validator: (value) {
            if (value == null || value.isEmpty) return 'مطلوب';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCVVField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('CVV'),
        SizedBox(height: ResponsiveHelper.height(8)),
        TextFormField(
          controller: cvvController,
          keyboardType: TextInputType.number,
          obscureText: true,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3),
          ],
          decoration: _buildInputDecoration(hintText: '123'),
          style: GoogleFonts.cairo(fontSize: ResponsiveHelper.fontSize(16)),
          validator: (value) {
            if (value == null || value.isEmpty) return 'مطلوب';
            if (value.length < 3) return 'غير صحيح';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.cairo(
        fontSize: ResponsiveHelper.fontSize(14),
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    IconData? icon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.cairo(color: Colors.grey.shade400),
      prefixIcon: icon != null ? Icon(icon, color: AppColors.primary) : null,
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
    );
  }

  String? _validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال رقم البطاقة';
    }
    if (value.replaceAll(' ', '').length < 16) {
      return 'رقم البطاقة غير صحيح';
    }
    return null;
  }
}
