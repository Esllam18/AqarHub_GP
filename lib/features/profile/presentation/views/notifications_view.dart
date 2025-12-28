import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

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
            'الإشعارات',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(18),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        'تم وضع علامة مقروء على جميع الإشعارات',
                        style: GoogleFonts.tajawal(color: Colors.white),
                      ),
                    ),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              child: Text(
                'قراءة الكل',
                style: GoogleFonts.cairo(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(ResponsiveHelper.width(16)),
          itemCount: 10,
          itemBuilder: (context, index) {
            return _buildNotificationCard(context, index);
          },
        ),
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, int index) {
    final isUnread = index < 3;
    final notificationType = index % 4;

    IconData icon;
    Color iconColor;
    String title;
    String message;

    switch (notificationType) {
      case 0:
        icon = Icons.check_circle_rounded;
        iconColor = AppColors.success;
        title = 'تم قبول طلب المعاينة';
        message = 'وافق المالك على طلب معاينة العقار';
        break;
      case 1:
        icon = Icons.message_rounded;
        iconColor = AppColors.primary;
        title = 'رسالة جديدة';
        message = 'لديك رسالة جديدة من أحمد محمد';
        break;
      case 2:
        icon = Icons.payments_rounded;
        iconColor = AppColors.info;
        title = 'عملية دفع ناجحة';
        message = 'تمت عملية الدفع بنجاح - 210 جنيه';
        break;
      default:
        icon = Icons.apartment_rounded;
        iconColor = AppColors.secondary;
        title = 'عقار جديد متاح';
        message = 'تم إضافة عقار جديد يناسب تفضيلاتك';
    }

    return Dismissible(
      key: Key('notification_$index'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: ResponsiveHelper.width(20)),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        ),
        child: Icon(
          Icons.delete_rounded,
          color: Colors.white,
          size: ResponsiveHelper.width(24),
        ),
      ),
      onDismissed: (direction) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'تم حذف الإشعار',
                style: GoogleFonts.tajawal(color: Colors.white),
              ),
            ),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: ResponsiveHelper.height(12)),
        decoration: BoxDecoration(
          color: isUnread
              ? AppColors.primary.withOpacity(0.05)
              : AppColors.white,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          border: Border.all(
            color: isUnread
                ? AppColors.primary.withOpacity(0.2)
                : Colors.grey.shade200,
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(ResponsiveHelper.width(12)),
          leading: Container(
            padding: EdgeInsets.all(ResponsiveHelper.width(10)),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: ResponsiveHelper.width(24),
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.cairo(
                    fontSize: ResponsiveHelper.fontSize(15),
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              if (isUnread)
                Container(
                  width: ResponsiveHelper.width(8),
                  height: ResponsiveHelper.width(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ResponsiveHelper.height(4)),
              Text(
                message,
                style: GoogleFonts.tajawal(
                  fontSize: ResponsiveHelper.fontSize(13),
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: ResponsiveHelper.height(8)),
              Text(
                'منذ ${index + 1} ساعة',
                style: GoogleFonts.tajawal(
                  fontSize: ResponsiveHelper.fontSize(11),
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
