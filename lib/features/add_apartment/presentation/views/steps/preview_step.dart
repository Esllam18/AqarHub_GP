import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../../widgets/custom_step_button.dart';

class PreviewStep extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  // Placeholder image URL from reliable source
  static const String placeholderImageUrl =
      'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800&q=80';

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
                  // Title
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

                  SizedBox(height: ResponsiveHelper.height(24)),

                  // Images Preview
                  _buildSectionTitle('صور العقار'),
                  SizedBox(height: ResponsiveHelper.height(12)),
                  SizedBox(
                    height: ResponsiveHelper.height(200),
                    child: _buildImagesList(),
                  ),

                  SizedBox(height: ResponsiveHelper.height(24)),

                  // Basic Info Card
                  _buildInfoCard(
                    title: 'المعلومات الأساسية',
                    icon: Icons.info_outline_rounded,
                    children: [
                      _buildInfoRow('العنوان', data['title'] ?? 'غير محدد'),
                      _buildInfoRow('عدد الغرف', '${data['rooms'] ?? 0}'),
                      _buildInfoRow(
                        'عدد الحمامات',
                        '${data['bathrooms'] ?? 0}',
                      ),
                      _buildInfoRow('المساحة', '${data['area'] ?? 0} م²'),
                    ],
                  ),

                  SizedBox(height: ResponsiveHelper.height(16)),

                  // Location Card
                  _buildInfoCard(
                    title: 'الموقع',
                    icon: Icons.location_on_rounded,
                    children: [
                      _buildInfoRow(
                        'المحافظة',
                        data['governorate'] ?? 'غير محدد',
                      ),
                      _buildInfoRow('المدينة', data['city'] ?? 'غير محدد'),
                      if (data['neighborhood'] != null)
                        _buildInfoRow('الحي', data['neighborhood']),
                    ],
                  ),

                  SizedBox(height: ResponsiveHelper.height(16)),

                  // Type & Category Card
                  _buildInfoCard(
                    title: 'النوع والفئة',
                    icon: Icons.category_rounded,
                    children: [
                      _buildInfoRow(
                        'الفئة',
                        data['category'] == 'sale' ? 'للبيع' : 'للإيجار',
                      ),
                      _buildInfoRow('النوع', _getTypeLabel(data['type'])),
                    ],
                  ),

                  SizedBox(height: ResponsiveHelper.height(16)),

                  // Amenities Card
                  if ((data['amenities'] as List?)?.isNotEmpty == true)
                    _buildInfoCard(
                      title: 'المرافق والخدمات',
                      icon: Icons.star_rounded,
                      children: [
                        Wrap(
                          spacing: ResponsiveHelper.width(8),
                          runSpacing: ResponsiveHelper.height(8),
                          textDirection: TextDirection.rtl,
                          children: (data['amenities'] as List)
                              .map((amenity) => _buildAmenityChip(amenity))
                              .toList(),
                        ),
                      ],
                    ),

                  SizedBox(height: ResponsiveHelper.height(16)),

                  // Description Card
                  if (data['description'] != null &&
                      data['description'].toString().isNotEmpty)
                    _buildInfoCard(
                      title: 'الوصف',
                      icon: Icons.description_rounded,
                      children: [
                        Text(
                          data['description'],
                          style: GoogleFonts.tajawal(
                            fontSize: ResponsiveHelper.fontSize(14),
                            color: Colors.grey.shade700,
                            height: 1.6,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),

                  SizedBox(height: ResponsiveHelper.height(16)),

                  // Price Card with Verification
                  _buildPriceCard(),

                  SizedBox(height: ResponsiveHelper.height(20)),
                ],
              ),
            ),
          ),

          // Bottom Buttons
          Container(
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
          ),
        ],
      ),
    );
  }

  Widget _buildImagesList() {
    final images = data['images'] as List?;

    // If no images or empty list, show placeholder
    if (images == null || images.isEmpty) {
      return _buildPlaceholderImage();
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      reverse: false, // Changed: scroll from right to left naturally
      itemCount: images.length,
      itemBuilder: (context, index) {
        final imageUrl = images[index]?.toString() ?? '';
        return _buildImageCard(imageUrl, index == 0);
      },
    );
  }

  Widget _buildImageCard(String imageUrl, bool isMain) {
    // Validate URL
    final String validUrl = _isValidImageUrl(imageUrl)
        ? imageUrl
        : placeholderImageUrl;

    return Container(
      width: ResponsiveHelper.width(280),
      margin: EdgeInsets.only(
        right: ResponsiveHelper.width(12), // Changed from left to right for RTL
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image with error handling
            Image.network(
              validUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey.shade200,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image_rounded,
                        size: ResponsiveHelper.width(50),
                        color: Colors.grey.shade400,
                      ),
                      SizedBox(height: ResponsiveHelper.height(8)),
                      Text(
                        'فشل تحميل الصورة',
                        style: GoogleFonts.tajawal(
                          fontSize: ResponsiveHelper.fontSize(12),
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Main image badge
            if (isMain)
              Positioned(
                top: ResponsiveHelper.height(12),
                right: ResponsiveHelper.width(12),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.width(12),
                    vertical: ResponsiveHelper.height(6),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(
                      ResponsiveHelper.radius(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: Colors.white,
                        size: ResponsiveHelper.width(14),
                      ),
                      SizedBox(width: ResponsiveHelper.width(4)),
                      Text(
                        'الصورة الرئيسية',
                        style: GoogleFonts.tajawal(
                          fontSize: ResponsiveHelper.fontSize(11),
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: ResponsiveHelper.width(280),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: ResponsiveHelper.width(60),
            color: Colors.grey.shade400,
          ),
          SizedBox(height: ResponsiveHelper.height(12)),
          Text(
            'لم يتم إضافة صور',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(14),
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: ResponsiveHelper.height(4)),
          Text(
            'ارجع للخطوة السابقة لإضافة صور',
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(12),
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  bool _isValidImageUrl(String url) {
    if (url.isEmpty) return false;
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.cairo(
        fontSize: ResponsiveHelper.fontSize(16),
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      textDirection: TextDirection.rtl,
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                padding: EdgeInsets.all(ResponsiveHelper.width(8)),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(8),
                  ),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: ResponsiveHelper.width(20),
                ),
              ),
              SizedBox(width: ResponsiveHelper.width(10)),
              Text(
                title,
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(16),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveHelper.height(12)),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveHelper.height(8)),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(13),
              color: Colors.grey.shade600,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(14),
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
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
        _getAmenityLabel(amenity),
        style: GoogleFonts.tajawal(
          fontSize: ResponsiveHelper.fontSize(12),
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPriceCard() {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(20)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['category'] == 'rent' ? 'الإيجار الشهري' : 'سعر البيع',
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(14),
                      color: AppColors.white.withOpacity(0.9),
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: ResponsiveHelper.height(4)),
                  Text(
                    '${data['price'] ?? 0} جنيه',
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(28),
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              if (data['isVerified'] == true)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.width(12),
                    vertical: ResponsiveHelper.height(8),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(
                      ResponsiveHelper.radius(10),
                    ),
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        color: AppColors.primary,
                        size: ResponsiveHelper.width(18),
                      ),
                      SizedBox(width: ResponsiveHelper.width(4)),
                      Text(
                        'معتمد',
                        style: GoogleFonts.cairo(
                          fontSize: ResponsiveHelper.fontSize(13),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _getTypeLabel(String? type) {
    const typeLabels = {
      'apartment': 'شقة',
      'villa': 'فيلا',
      'studio': 'استوديو',
      'penthouse': 'بنتهاوس',
      'duplex': 'دوبلكس',
      'chalet': 'شاليه',
    };
    return typeLabels[type] ?? type ?? 'غير محدد';
  }

  String _getAmenityLabel(String amenity) {
    const amenityLabels = {
      'wifi': 'واي فاي',
      'parking': 'موقف سيارات',
      'elevator': 'مصعد',
      'ac': 'تكييف',
      'security': 'حراسة',
      'pool': 'حمام سباحة',
      'gym': 'جيم',
      'garden': 'حديقة',
      'balcony': 'بلكونة',
      'furnished': 'مفروش',
      'kitchen': 'مطبخ',
      'laundry': 'غسالة',
      'dishwasher': 'غسالة أطباق',
      'heating': 'تدفئة',
      'intercom': 'انتركم',
      'cctv': 'كاميرات مراقبة',
      'pet_friendly': 'يسمح بالحيوانات',
      'sea_view': 'إطلالة بحرية',
      'city_view': 'إطلالة على المدينة',
      'smart_home': 'منزل ذكي',
    };
    return amenityLabels[amenity] ?? amenity;
  }
}
