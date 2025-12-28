import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

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
        // Card Number
        Text(
          'رقم البطاقة',
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(14),
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: ResponsiveHelper.height(8)),
        TextFormField(
          controller: cardNumberController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
            _CardNumberInputFormatter(),
          ],
          decoration: InputDecoration(
            hintText: '1234 5678 9012 3456',
            hintStyle: GoogleFonts.cairo(color: Colors.grey.shade400),
            prefixIcon: Icon(
              Icons.credit_card_rounded,
              color: AppColors.primary,
            ),
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
          ),
          style: GoogleFonts.cairo(fontSize: ResponsiveHelper.fontSize(16)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'يرجى إدخال رقم البطاقة';
            }
            if (value.replaceAll(' ', '').length < 16) {
              return 'رقم البطاقة غير صحيح';
            }
            return null;
          },
        ),

        SizedBox(height: ResponsiveHelper.height(20)),

        // Card Holder Name
        Text(
          'اسم حامل البطاقة',
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(14),
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: ResponsiveHelper.height(8)),
        TextFormField(
          controller: cardHolderController,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.characters,
          decoration: InputDecoration(
            hintText: 'AHMED MOHAMED',
            hintStyle: GoogleFonts.cairo(color: Colors.grey.shade400),
            prefixIcon: Icon(
              Icons.person_outline_rounded,
              color: AppColors.primary,
            ),
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
          ),
          style: GoogleFonts.cairo(fontSize: ResponsiveHelper.fontSize(16)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'يرجى إدخال الاسم';
            }
            return null;
          },
        ),

        SizedBox(height: ResponsiveHelper.height(20)),

        // Expiry and CVV
        Row(
          children: [
            // Expiry Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تاريخ الانتهاء',
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(14),
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.height(8)),
                  TextFormField(
                    controller: expiryController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                      _ExpiryDateInputFormatter(),
                    ],
                    decoration: InputDecoration(
                      hintText: 'MM/YY',
                      hintStyle: GoogleFonts.cairo(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: AppColors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(12),
                        ),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(12),
                        ),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(12),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                    ),
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(16),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'مطلوب';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),

            SizedBox(width: ResponsiveHelper.width(16)),

            // CVV
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CVV',
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(14),
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.height(8)),
                  TextFormField(
                    controller: cvvController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    decoration: InputDecoration(
                      hintText: '123',
                      hintStyle: GoogleFonts.cairo(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: AppColors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(12),
                        ),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(12),
                        ),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(12),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                    ),
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(16),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'مطلوب';
                      }
                      if (value.length < 3) {
                        return 'غير صحيح';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Card Number Formatter
class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

// Expiry Date Formatter
class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != text.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
