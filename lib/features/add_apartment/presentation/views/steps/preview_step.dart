import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../../widgets/custom_step_button.dart';
import '../../widgets/preview/preview_images_list.dart';
import '../../widgets/preview/preview_info_card.dart';
import '../../widgets/preview/preview_price_card.dart';
import '../../widgets/preview/preview_section_title.dart';
import '../../utils/apartment_label_helper.dart';

class PreviewStep extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  const PreviewStep({
    super.key,
    required this.data,
    required this.onBack,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(ResponsiveHelper.width(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: ResponsiveHelper.height(24)),
                  PreviewSectionTitle(title: 'صور العقار'),
                  SizedBox(height: ResponsiveHelper.height(12)),
                  SizedBox(
                    height: ResponsiveHelper.height(200),
                    child: PreviewImagesList(images: data['images'] as List?),
                  ),
                  SizedBox(height: ResponsiveHelper.height(24)),
                  _buildBasicInfoCard(),
                  SizedBox(height: ResponsiveHelper.height(16)),
                  _buildLocationCard(),
                  SizedBox(height: ResponsiveHelper.height(16)),
                  _buildTypeCategoryCard(),
                  SizedBox(height: ResponsiveHelper.height(16)),
                  if (_hasAmenities()) _buildAmenitiesCard(),
                  if (_hasAmenities())
                    SizedBox(height: ResponsiveHelper.height(16)),
                  if (_hasDescription()) _buildDescriptionCard(),
                  if (_hasDescription())
                    SizedBox(height: ResponsiveHelper.height(16)),
                  PreviewPriceCard(data: data),
                  SizedBox(height: ResponsiveHelper.height(20)),
                ],
              ),
            ),
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مراجعة نهائية',
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(24),
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: ResponsiveHelper.height(8)),
        Text(
          'راجع بيانات العقار قبل النشر',
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(14),
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildBasicInfoCard() {
    return PreviewInfoCard(
      title: 'المعلومات الأساسية',
      icon: Icons.info_outline_rounded,
      items: {
        'العنوان': data['title'] ?? 'غير محدد',
        'عدد الغرف': '${data['rooms'] ?? 0}',
        'عدد الحمامات': '${data['bathrooms'] ?? 0}',
        'المساحة': '${data['area'] ?? 0} م²',
      },
    );
  }

  Widget _buildLocationCard() {
    final items = <String, String>{
      'المحافظة': data['governorate'] ?? 'غير محدد',
      'المدينة': data['city'] ?? 'غير محدد',
    };

    if (data['neighborhood'] != null) {
      items['الحي'] = data['neighborhood'];
    }

    return PreviewInfoCard(
      title: 'الموقع',
      icon: Icons.location_on_rounded,
      items: items,
    );
  }

  Widget _buildTypeCategoryCard() {
    return PreviewInfoCard(
      title: 'النوع والفئة',
      icon: Icons.category_rounded,
      items: {
        'الفئة': data['category'] == 'sale' ? 'للبيع' : 'للإيجار',
        'النوع': ApartmentLabelHelper.getTypeLabel(data['type']),
      },
    );
  }

  Widget _buildAmenitiesCard() {
    return PreviewInfoCard(
      title: 'المرافق والخدمات',
      icon: Icons.star_rounded,
      customContent: Wrap(
        spacing: ResponsiveHelper.width(8),
        runSpacing: ResponsiveHelper.height(8),
        textDirection: TextDirection.rtl,
        children: (data['amenities'] as List)
            .map((amenity) => _buildAmenityChip(amenity))
            .toList(),
      ),
    );
  }

  Widget _buildDescriptionCard() {
    return PreviewInfoCard(
      title: 'الوصف',
      icon: Icons.description_rounded,
      customContent: Text(
        data['description'],
        style: GoogleFonts.tajawal(
          fontSize: ResponsiveHelper.fontSize(14),
          color: Colors.grey.shade700,
          height: 1.6,
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }

  Widget _buildAmenityChip(String amenity) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(12),
        vertical: ResponsiveHelper.height(6),
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
        border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 1),
      ),
      child: Text(
        ApartmentLabelHelper.getAmenityLabel(amenity),
        style: GoogleFonts.tajawal(
          fontSize: ResponsiveHelper.fontSize(12),
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(20)),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
            child: CustomStepButton(
              text: 'السابق',
              onPressed: onBack,
              isPrimary: false,
            ),
          ),
          SizedBox(width: ResponsiveHelper.width(12)),
          Expanded(
            flex: 2,
            child: CustomStepButton(
              text: 'نشر العقار',
              onPressed: onSubmit,
              icon: Icons.check_circle_rounded,
            ),
          ),
        ],
      ),
    );
  }

  bool _hasAmenities() {
    return (data['amenities'] as List?)?.isNotEmpty == true;
  }

  bool _hasDescription() {
    return data['description'] != null &&
        data['description'].toString().isNotEmpty;
  }
}
