import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // ✅ Import Font Awesome
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class EnhancedContactCard extends StatelessWidget {
  final String ownerName;
  final String ownerImage;
  final String phoneNumber;
  final String whatsappNumber;
  final String responseTime;
  final double rating;

  const EnhancedContactCard({
    super.key,
    required this.ownerName,
    required this.ownerImage,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.responseTime,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(14)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(14)),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Owner Info
          Row(
            textDirection: TextDirection.rtl,
            children: [
              // Owner Image
              Container(
                width: ResponsiveHelper.width(55),
                height: ResponsiveHelper.width(55),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
                child: ClipOval(
                  child: Image.network(
                    ownerImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.person,
                          size: ResponsiveHelper.width(28),
                          color: Colors.grey.shade400,
                        ),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(width: ResponsiveHelper.width(12)),

              // Owner Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(
                          ownerName,
                          style: GoogleFonts.cairo(
                            fontSize: ResponsiveHelper.fontSize(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(width: ResponsiveHelper.width(6)),
                        // Verified Badge
                        Container(
                          padding: EdgeInsets.all(ResponsiveHelper.width(3)),
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_rounded,
                            color: AppColors.white,
                            size: ResponsiveHelper.width(12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ResponsiveHelper.height(4)),
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: ResponsiveHelper.width(14),
                        ),
                        SizedBox(width: ResponsiveHelper.width(3)),
                        Text(
                          rating.toString(),
                          style: GoogleFonts.cairo(
                            fontSize: ResponsiveHelper.fontSize(12),
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(width: ResponsiveHelper.width(6)),
                        Container(
                          width: 3,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: ResponsiveHelper.width(6)),
                        Text(
                          'يرد خلال $responseTime',
                          style: GoogleFonts.tajawal(
                            fontSize: ResponsiveHelper.fontSize(10),
                            color: Colors.grey.shade600,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: ResponsiveHelper.height(12)),

          // Action Buttons (WhatsApp & Call only)
          Row(
            textDirection: TextDirection.rtl,
            children: [
              // WhatsApp Button
              Expanded(
                child: _buildContactButton(
                  icon: FontAwesomeIcons.whatsapp, // ✅ Use Font Awesome
                  label: 'واتساب',
                  color: const Color(0xFF25D366),
                  onTap: () => _launchWhatsApp(whatsappNumber),
                ),
              ),

              SizedBox(width: ResponsiveHelper.width(12)),

              // Call Button
              Expanded(
                child: _buildContactButton(
                  icon: Icons.phone_rounded,
                  label: 'اتصال',
                  color: AppColors.primary,
                  onTap: () => _makePhoneCall(phoneNumber),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(10)),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            FaIcon(
              // ✅ Use FaIcon for Font Awesome icons
              icon,
              color: color,
              size: ResponsiveHelper.width(18),
            ),
            SizedBox(width: ResponsiveHelper.width(6)),
            Text(
              label,
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(13),
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchWhatsApp(String number) async {
    final url = 'https://wa.me/$number';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  void _makePhoneCall(String number) async {
    final url = 'tel:$number';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
