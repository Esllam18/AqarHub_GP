import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/help_support_widgets/help_section_title.dart';
import '../widgets/help_support_widgets/contact_card.dart';
import '../widgets/help_support_widgets/faq_item.dart';
import '../widgets/help_support_widgets/report_button.dart';
import '../widgets/profile_dialogs/report_problem_dialog.dart';

class HelpSupportView extends StatelessWidget {
  const HelpSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(ResponsiveHelper.width(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContactSection(context),
              SizedBox(height: ResponsiveHelper.height(32)),
              _buildFAQSection(),
              SizedBox(height: ResponsiveHelper.height(32)),
              _buildReportSection(context),
              SizedBox(height: ResponsiveHelper.height(40)),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HelpSectionTitle(title: 'تواصل معنا'),
        SizedBox(height: ResponsiveHelper.height(12)),
        ContactCard(
          icon: Icons.phone_rounded,
          title: 'اتصل بنا',
          subtitle: '+20 100 123 4567',
          color: AppColors.primary,
          onTap: () => _makePhoneCall('+20 100 123 4567'),
        ),
        SizedBox(height: ResponsiveHelper.height(12)),
        ContactCard(
          icon: Icons.email_rounded,
          title: 'راسلنا عبر البريد',
          subtitle: 'support@aqarhub.com',
          color: AppColors.info,
          onTap: () => _sendEmail('support@aqarhub.com'),
        ),
        SizedBox(height: ResponsiveHelper.height(12)),
        ContactCard(
          icon: Icons.chat_bubble_rounded,
          title: 'الدردشة المباشرة',
          subtitle: 'متاح من 9 صباحاً - 6 مساءً',
          color: AppColors.success,
          onTap: () => _showComingSoonSnackbar(context),
        ),
      ],
    );
  }

  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HelpSectionTitle(title: 'الأسئلة الشائعة'),
        SizedBox(height: ResponsiveHelper.height(12)),
        const FAQItem(
          question: 'كيف يمكنني حجز معاينة عقار؟',
          answer:
              'يمكنك حجز معاينة عن طريق الضغط على زر "احجز معاينة" في صفحة تفاصيل العقار، ثم إتمام عملية الدفع.',
        ),
        SizedBox(height: ResponsiveHelper.height(12)),
        const FAQItem(
          question: 'هل يمكنني استرجاع رسوم الحجز؟',
          answer:
              'نعم، يمكن استرجاع رسوم الحجز في حالة إلغاء المعاينة قبل 24 ساعة من الموعد المحدد.',
        ),
        SizedBox(height: ResponsiveHelper.height(12)),
        const FAQItem(
          question: 'كيف أضيف عقاري للإيجار؟',
          answer:
              'من الصفحة الرئيسية، اضغط على زر "+" ثم املأ بيانات العقار وأضف الصور المطلوبة.',
        ),
        SizedBox(height: ResponsiveHelper.height(12)),
        const FAQItem(
          question: 'ما هي طرق الدفع المتاحة؟',
          answer:
              'نوفر عدة طرق للدفع: بطاقة ائتمان، فوري، فودافون كاش، إنستاباي، والدفع نقداً.',
        ),
      ],
    );
  }

  Widget _buildReportSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HelpSectionTitle(title: 'الإبلاغ عن مشكلة'),
        SizedBox(height: ResponsiveHelper.height(12)),
        ReportButton(onTap: () => showReportProblemDialog(context)),
      ],
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

  void _showComingSoonSnackbar(BuildContext context) {
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
  }
}
