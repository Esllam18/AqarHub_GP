import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class TermsOfServiceView extends StatelessWidget {
  const TermsOfServiceView({super.key});

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
            'الشروط والأحكام',
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
                '1. قبول الشروط',
                'باستخدامك لتطبيق عقار هب، فإنك توافق على الالتزام بهذه الشروط والأحكام. إذا كنت لا توافق على أي جزء من هذه الشروط، يرجى عدم استخدام التطبيق.',
              ),

              _buildSection(
                '2. استخدام التطبيق',
                'يحق لك استخدام التطبيق للأغراض القانونية فقط. يجب عليك:\n\n'
                    '• تقديم معلومات دقيقة وصحيحة\n'
                    '• الحفاظ على سرية معلومات حسابك\n'
                    '• عدم انتهاك حقوق الآخرين\n'
                    '• عدم استخدام التطبيق لأغراض احتيالية',
              ),

              _buildSection(
                '3. حسابات المستخدمين',
                'أنت مسؤول عن:\n\n'
                    '• الحفاظ على سرية كلمة المرور\n'
                    '• جميع الأنشطة التي تتم من حسابك\n'
                    '• إبلاغنا فوراً عن أي استخدام غير مصرح به\n'
                    '• تحديث معلوماتك بانتظام',
              ),

              _buildSection(
                '4. العقارات والمحتوى',
                'عند نشر عقار، أنت توافق على:\n\n'
                    '• أن المعلومات المقدمة صحيحة ودقيقة\n'
                    '• امتلاك الحق في تأجير العقار\n'
                    '• عدم نشر محتوى مضلل أو احتيالي\n'
                    '• الالتزام بالقوانين المحلية',
              ),

              _buildSection(
                '5. الرسوم والمدفوعات',
                'نحتفظ بالحق في:\n\n'
                    '• فرض رسوم على خدمات معينة\n'
                    '• تغيير الأسعار بإشعار مسبق\n'
                    '• معالجة المبالغ المستردة وفقاً لسياستنا\n'
                    '• تعليق الخدمات عند عدم الدفع',
              ),

              _buildSection(
                '6. إلغاء الحجز والاسترداد',
                'سياسة الإلغاء:\n\n'
                    '• يمكن إلغاء الحجز قبل 24 ساعة من الموعد\n'
                    '• يتم استرداد المبلغ خلال 3-5 أيام عمل\n'
                    '• قد تطبق رسوم إلغاء في حالات معينة\n'
                    '• الإلغاء المتكرر قد يؤدي لتعليق الحساب',
              ),

              _buildSection(
                '7. المسؤولية',
                'عقار هب غير مسؤول عن:\n\n'
                    '• دقة المعلومات المقدمة من المستخدمين\n'
                    '• النزاعات بين المستخدمين\n'
                    '• حالة العقارات المعروضة\n'
                    '• الأضرار الناتجة عن استخدام التطبيق',
              ),

              _buildSection(
                '8. الملكية الفكرية',
                'جميع المحتويات والعلامات التجارية في التطبيق مملوكة لعقار هب. لا يجوز:\n\n'
                    '• نسخ أو توزيع المحتوى\n'
                    '• استخدام العلامات التجارية بدون إذن\n'
                    '• إعادة هندسة التطبيق\n'
                    '• استخدام المحتوى لأغراض تجارية',
              ),

              _buildSection(
                '9. إنهاء الحساب',
                'يحق لنا إنهاء أو تعليق حسابك في حالة:\n\n'
                    '• انتهاك الشروط والأحكام\n'
                    '• نشاط احتيالي أو مشبوه\n'
                    '• عدم الامتثال للقوانين\n'
                    '• الإضرار بمستخدمين آخرين',
              ),

              _buildSection(
                '10. التغييرات على الشروط',
                'نحتفظ بالحق في تعديل هذه الشروط في أي وقت. سيتم إشعارك بأي تغييرات جوهرية. استمرارك في استخدام التطبيق يعني قبولك للشروط المحدثة.',
              ),

              _buildSection(
                '11. القانون الحاكم',
                'تخضع هذه الشروط وتفسر وفقاً لقوانين جمهورية مصر العربية. أي نزاع سيتم حله في المحاكم المصرية المختصة.',
              ),

              _buildSection(
                '12. اتصل بنا',
                'للاستفسارات حول الشروط والأحكام:\n\n'
                    'البريد الإلكتروني: legal@aqarhub.com\n'
                    'الهاتف: +20 100 123 4567\n'
                    'العنوان: القاهرة، مصر',
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
