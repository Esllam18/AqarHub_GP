import 'package:aqar_hub_gp/core/consts/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

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
            'عن التطبيق',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(18),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(ResponsiveHelper.width(20)),
          child: Column(
            children: [
              SizedBox(height: ResponsiveHelper.height(20)),

              // App Logo
              Center(
                child: Image.asset(
                  AppImages.logo,
                  width: ResponsiveHelper.width(80),
                  height: ResponsiveHelper.width(80),
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: ResponsiveHelper.height(24)),

              // App Name
              Text(
                'عقار هاب',
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(28),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              SizedBox(height: ResponsiveHelper.height(8)),

              // Version
              Text(
                'الإصدار 1.0.0',
                style: GoogleFonts.tajawal(
                  fontSize: ResponsiveHelper.fontSize(14),
                  color: Colors.grey.shade600,
                ),
              ),

              SizedBox(height: ResponsiveHelper.height(32)),

              // Description Card
              Container(
                padding: EdgeInsets.all(ResponsiveHelper.width(20)),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'من نحن',
                      style: GoogleFonts.cairo(
                        fontSize: ResponsiveHelper.fontSize(18),
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.height(12)),
                    Text(
                      'عقار هاب هو تطبيق عقاري شامل يهدف إلى تسهيل عملية البحث عن السكن في مصر. نوفر منصة آمنة وموثوقة تربط بين الباحثين عن السكن وأصحاب العقارات.\n\n'
                      'نؤمن بأن إيجاد السكن المناسب يجب أن يكون تجربة سهلة وممتعة. لذلك صممنا تطبيقاً عصرياً وسهل الاستخدام يوفر جميع الأدوات اللازمة لإتمام عملية البحث والحجز.',
                      style: GoogleFonts.tajawal(
                        fontSize: ResponsiveHelper.fontSize(14),
                        color: Colors.grey.shade700,
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: ResponsiveHelper.height(24)),

              // Features
              _buildFeatureCard(
                Icons.search_rounded,
                'بحث ذكي',
                'نظام بحث متقدم للعثور على العقار المثالي',
              ),
              SizedBox(height: ResponsiveHelper.height(12)),
              _buildFeatureCard(
                Icons.verified_rounded,
                'عقارات موثقة',
                'جميع العقارات مراجعة ومتحقق منها',
              ),
              SizedBox(height: ResponsiveHelper.height(12)),
              _buildFeatureCard(
                Icons.payment_rounded,
                'دفع آمن',
                'نظام دفع متعدد وآمن 100%',
              ),
              SizedBox(height: ResponsiveHelper.height(12)),
              _buildFeatureCard(
                Icons.support_agent_rounded,
                'دعم فني',
                'فريق دعم متاح على مدار الساعة',
              ),

              SizedBox(height: ResponsiveHelper.height(32)),

              // Social Media
              Text(
                'تابعنا على',
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(16),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: ResponsiveHelper.height(16)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(
                    Icons.facebook_rounded,
                    const Color(0xFF1877F2),
                    () => _openUrl('https://facebook.com'),
                  ),
                  SizedBox(width: ResponsiveHelper.width(16)),
                  _buildSocialButton(
                    Icons.email_rounded,
                    const Color(0xFF34A853),
                    () => _openUrl('mailto:info@aqarhub.com'),
                  ),
                  SizedBox(width: ResponsiveHelper.width(16)),
                  _buildSocialButton(
                    Icons.language_rounded,
                    const Color(0xFF5865F2),
                    () => _openUrl('https://aqarhub.com'),
                  ),
                ],
              ),

              SizedBox(height: ResponsiveHelper.height(32)),

              // Contact Info
              Container(
                padding: EdgeInsets.all(ResponsiveHelper.width(16)),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(12),
                  ),
                  border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    _buildContactRow(Icons.email_rounded, 'info@aqarhub.com'),
                    SizedBox(height: ResponsiveHelper.height(8)),
                    _buildContactRow(Icons.phone_rounded, '+20 100 123 4567'),
                    SizedBox(height: ResponsiveHelper.height(8)),
                    _buildContactRow(Icons.location_on_rounded, 'القاهرة، مصر'),
                  ],
                ),
              ),

              SizedBox(height: ResponsiveHelper.height(32)),

              // Copyright
              Text(
                '© 2024 عقار هب. جميع الحقوق محفوظة.',
                style: GoogleFonts.tajawal(
                  fontSize: ResponsiveHelper.fontSize(12),
                  color: Colors.grey.shade500,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: ResponsiveHelper.height(40)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String description) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(ResponsiveHelper.width(12)),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: ResponsiveHelper.width(24),
            ),
          ),
          SizedBox(width: ResponsiveHelper.width(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.cairo(
                    fontSize: ResponsiveHelper.fontSize(15),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: ResponsiveHelper.height(4)),
                Text(
                  description,
                  style: GoogleFonts.tajawal(
                    fontSize: ResponsiveHelper.fontSize(13),
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
      child: Container(
        padding: EdgeInsets.all(ResponsiveHelper.width(16)),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        ),
        child: Icon(icon, color: color, size: ResponsiveHelper.width(28)),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: ResponsiveHelper.width(18), color: AppColors.primary),
        SizedBox(width: ResponsiveHelper.width(12)),
        Text(
          text,
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(13),
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
