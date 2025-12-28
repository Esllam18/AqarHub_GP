import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

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
            'سياسة الخصوصية',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Last Updated
              Container(
                padding: EdgeInsets.all(ResponsiveHelper.width(12)),
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(12),
                  ),
                  border: Border.all(color: AppColors.info.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      color: AppColors.info,
                      size: ResponsiveHelper.width(18),
                    ),
                    SizedBox(width: ResponsiveHelper.width(8)),
                    Text(
                      'آخر تحديث: 15 ديسمبر 2024',
                      style: GoogleFonts.tajawal(
                        fontSize: ResponsiveHelper.fontSize(13),
                        color: AppColors.info,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: ResponsiveHelper.height(24)),

              _buildSection(
                '1. المقدمة',
                'نحن في عقار هاب نلتزم بحماية خصوصيتك وبياناتك الشخصية. توضح سياسة الخصوصية هذه كيفية جمع واستخدام وحماية معلوماتك الشخصية عند استخدام تطبيقنا.',
              ),

              _buildSection(
                '2. المعلومات التي نجمعها',
                'نقوم بجمع المعلومات التالية:\n\n'
                    '• معلومات الحساب: الاسم، البريد الإلكتروني، رقم الهاتف\n'
                    '• معلومات العقارات: صور وتفاصيل العقارات المعروضة\n'
                    '• بيانات الاستخدام: كيفية تفاعلك مع التطبيق\n'
                    '• معلومات الدفع: تفاصيل المعاملات المالية',
              ),

              _buildSection(
                '3. استخدام المعلومات',
                'نستخدم المعلومات التي نجمعها للأغراض التالية:\n\n'
                    '• تقديم وتحسين خدماتنا\n'
                    '• التواصل معك بخصوص حسابك\n'
                    '• معالجة المدفوعات والحجوزات\n'
                    '• إرسال إشعارات مهمة\n'
                    '• تحسين تجربة المستخدم',
              ),

              _buildSection(
                '4. مشاركة المعلومات',
                'لا نقومببيع أو تأجير معلوماتك الشخصية لأطراف ثالثة. قد نشارك معلوماتك في الحالات التالية:\n\n'
                    '• مع مقدمي الخدمات الموثوقين\n'
                    '• عند الطلب القانوني من الجهات الرسمية\n'
                    '• لحماية حقوقنا وأمان المستخدمين',
              ),

              _buildSection(
                '5. أمان البيانات',
                'نتخذ إجراءات أمنية صارمة لحماية بياناتك:\n\n'
                    '• تشفير البيانات أثناء النقل والتخزين\n'
                    '• خوادم آمنة ومحمية\n'
                    '• فحص أمني دوري\n'
                    '• التحديثات الأمنية المستمرة',
              ),

              _buildSection(
                '6. حقوقك',
                'لديك الحق في:\n\n'
                    '• الوصول إلى بياناتك الشخصية\n'
                    '• تصحيح البيانات غير الدقيقة\n'
                    '• حذف حسابك وبياناتك\n'
                    '• الاعتراض على معالجة بياناتك\n'
                    '• نقل بياناتك إلى خدمة أخرى',
              ),

              _buildSection(
                '7. ملفات تعريف الارتباط (Cookies)',
                'نستخدم ملفات تعريف الارتباط لتحسين تجربتك وتخصيص المحتوى. يمكنك التحكم في هذه الملفات من خلال إعدادات المتصفح.',
              ),

              _buildSection(
                '8. التغييرات على سياسة الخصوصية',
                'قد نقوم بتحديث سياسة الخصوصية من وقت لآخر. سنقوم بإشعارك بأي تغييرات جوهرية عبر التطبيق أو البريد الإلكتروني.',
              ),

              _buildSection(
                '9. اتصل بنا',
                'إذا كان لديك أي استفسارات حول سياسة الخصوصية، يمكنك التواصل معنا عبر:\n\n'
                    'البريد الإلكتروني: privacy@aqarhub.com\n'
                    'الهاتف: +20 100 123 4567',
              ),

              SizedBox(height: ResponsiveHelper.height(40)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(16),
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: ResponsiveHelper.height(12)),
        Text(
          content,
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(14),
            color: Colors.grey.shade700,
            height: 1.8,
          ),
        ),
        SizedBox(height: ResponsiveHelper.height(24)),
      ],
    );
  }
}
