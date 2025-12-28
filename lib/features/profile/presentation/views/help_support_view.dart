import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportView extends StatelessWidget {
  const HelpSupportView({super.key});

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
            'المساعدة والدعم',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(18),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(ResponsiveHelper.width(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contact Methods
              _buildSectionTitle('تواصل معنا'),
              SizedBox(height: ResponsiveHelper.height(12)),
              _buildContactCard(
                context,
                Icons.phone_rounded,
                'اتصل بنا',
                '+20 100 123 4567',
                AppColors.primary,
                () => _makePhoneCall('+20 100 123 4567'),
              ),
              SizedBox(height: ResponsiveHelper.height(12)),
              _buildContactCard(
                context,
                Icons.email_rounded,
                'راسلنا عبر البريد',
                'support@aqarhub.com',
                AppColors.info,
                () => _sendEmail('support@aqarhub.com'),
              ),
              SizedBox(height: ResponsiveHelper.height(12)),
              _buildContactCard(
                context,
                Icons.chat_bubble_rounded,
                'الدردشة المباشرة',
                'متاح من 9 صباحاً - 6 مساءً',
                AppColors.success,
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          'سيتم إضافة الدردشة المباشرة قريباً',
                          style: GoogleFonts.tajawal(color: Colors.white),
                        ),
                      ),
                      backgroundColor: AppColors.info,
                    ),
                  );
                },
              ),

              SizedBox(height: ResponsiveHelper.height(32)),

              // FAQ Section
              _buildSectionTitle('الأسئلة الشائعة'),
              SizedBox(height: ResponsiveHelper.height(12)),
              _buildFAQItem(
                'كيف يمكنني حجز معاينة عقار؟',
                'يمكنك حجز معاينة عن طريق الضغط على زر "احجز معاينة" في صفحة تفاصيل العقار، ثم إتمام عملية الدفع.',
              ),
              SizedBox(height: ResponsiveHelper.height(12)),
              _buildFAQItem(
                'هل يمكنني استرجاع رسوم الحجز؟',
                'نعم، يمكن استرجاع رسوم الحجز في حالة إلغاء المعاينة قبل 24 ساعة من الموعد المحدد.',
              ),
              SizedBox(height: ResponsiveHelper.height(12)),
              _buildFAQItem(
                'كيف أضيف عقاري للإيجار؟',
                'من الصفحة الرئيسية، اضغط على زر "+" ثم املأ بيانات العقار وأضف الصور المطلوبة.',
              ),
              SizedBox(height: ResponsiveHelper.height(12)),
              _buildFAQItem(
                'ما هي طرق الدفع المتاحة؟',
                'نوفر عدة طرق للدفع: بطاقة ائتمان، فوري، فودافون كاش، إنستاباي، والدفع نقداً.',
              ),

              SizedBox(height: ResponsiveHelper.height(32)),

              // Report Problem
              _buildSectionTitle('الإبلاغ عن مشكلة'),
              SizedBox(height: ResponsiveHelper.height(12)),
              _buildReportButton(context),

              SizedBox(height: ResponsiveHelper.height(40)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.cairo(
        fontSize: ResponsiveHelper.fontSize(16),
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
      child: Container(
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
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(10),
                ),
              ),
              child: Icon(icon, color: color, size: ResponsiveHelper.width(24)),
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
                    subtitle,
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(13),
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_back_ios_rounded,
              size: ResponsiveHelper.width(16),
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.help_rounded,
                color: AppColors.primary,
                size: ResponsiveHelper.width(20),
              ),
              SizedBox(width: ResponsiveHelper.width(12)),
              Expanded(
                child: Text(
                  question,
                  style: GoogleFonts.cairo(
                    fontSize: ResponsiveHelper.fontSize(14),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveHelper.height(8)),
          Padding(
            padding: EdgeInsets.only(right: ResponsiveHelper.width(32)),
            child: Text(
              answer,
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(13),
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportButton(BuildContext context) {
    return InkWell(
      onTap: () {
        _showReportDialog(context);
      },
      borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(16)),
        decoration: BoxDecoration(
          color: AppColors.error.withOpacity(0.1),
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          border: Border.all(color: AppColors.error.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.report_problem_rounded,
              color: AppColors.error,
              size: ResponsiveHelper.width(22),
            ),
            SizedBox(width: ResponsiveHelper.width(12)),
            Text(
              'الإبلاغ عن مشكلة',
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(15),
                fontWeight: FontWeight.bold,
                color: AppColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _sendEmail(String email) async {
    final uri = Uri.parse('mailto:$email?subject=طلب دعم - عقار هب');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _showReportDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
          ),
          title: Text(
            'الإبلاغ عن مشكلة',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(18),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: controller,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'اكتب وصف المشكلة...',
              hintStyle: GoogleFonts.tajawal(color: Colors.grey.shade400),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(12),
                ),
              ),
            ),
            style: GoogleFonts.tajawal(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'إلغاء',
                style: GoogleFonts.cairo(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        'تم إرسال البلاغ بنجاح. سنتواصل معك قريباً',
                        style: GoogleFonts.tajawal(color: Colors.white),
                      ),
                    ),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(8),
                  ),
                ),
              ),
              child: Text(
                'إرسال',
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
