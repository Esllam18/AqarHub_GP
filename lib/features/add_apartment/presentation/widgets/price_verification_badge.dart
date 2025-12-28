import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class PriceVerificationBadge extends StatelessWidget {
  final bool isVerified;
  final String message;

  const PriceVerificationBadge({
    super.key,
    required this.isVerified,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      padding: EdgeInsets.all(ResponsiveHelper.width(16)),
      decoration: BoxDecoration(
        color: isVerified
            ? Colors.green.withOpacity(0.1)
            : Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        border: Border.all(
          color: isVerified
              ? Colors.green.withOpacity(0.3)
              : Colors.orange.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            padding: EdgeInsets.all(ResponsiveHelper.width(10)),
            decoration: BoxDecoration(
              color: isVerified
                  ? Colors.green.withOpacity(0.2)
                  : Colors.orange.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isVerified ? Icons.verified_rounded : Icons.info_outline_rounded,
              color: isVerified ? Colors.green : Colors.orange.shade700,
              size: ResponsiveHelper.width(24),
            ),
          ),
          SizedBox(width: ResponsiveHelper.width(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isVerified ? 'تم التحقق بنجاح' : 'تنبيه',
                  style: GoogleFonts.cairo(
                    fontSize: ResponsiveHelper.fontSize(16),
                    fontWeight: FontWeight.bold,
                    color: isVerified ? Colors.green : Colors.orange.shade700,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: ResponsiveHelper.height(4)),
                Text(
                  message,
                  style: GoogleFonts.tajawal(
                    fontSize: ResponsiveHelper.fontSize(13),
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
