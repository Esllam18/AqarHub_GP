import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart'; // 🆕 ADD THIS
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/auto_image_carousel.dart';
import '../widgets/premium_price_card.dart';
import '../widgets/location_card.dart';
import '../widgets/professional_amenities.dart';
import '../widgets/description_section.dart';
import '../widgets/enhanced_contact_card.dart';

class ApartmentDetailsView extends StatefulWidget {
  const ApartmentDetailsView({super.key});

  @override
  State<ApartmentDetailsView> createState() => _ApartmentDetailsViewState();
}

class _ApartmentDetailsViewState extends State<ApartmentDetailsView> {
  bool _isFavorite = false;

  final List<String> _images = [
    'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
    'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
    'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800',
    'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800',
    'https://images.unsplash.com/photo-1494526585095-c41746248156?w=800',
  ];

  final List<Map<String, dynamic>> _amenities = [
    {'icon': Icons.wifi_rounded, 'name': 'واي فاي'},
    {'icon': Icons.ac_unit_rounded, 'name': 'تكييف'},
    {'icon': Icons.local_parking_rounded, 'name': 'موقف'},
    {'icon': Icons.security_rounded, 'name': 'حراسة'},
    {'icon': Icons.elevator_rounded, 'name': 'مصعد'},
    {'icon': Icons.pool_rounded, 'name': 'مسبح'},
    {'icon': Icons.fitness_center_rounded, 'name': 'جيم'},
    {'icon': Icons.local_laundry_service_rounded, 'name': 'غسالة'},
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            // Main Content
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Image Carousel
                SliverToBoxAdapter(child: AutoImageCarousel(images: _images)),

                // Content
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(ResponsiveHelper.radius(24)),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: ResponsiveHelper.height(16)),

                        // Title & Badges
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                'شقة استوديو فاخرة في موقع مميز',
                                style: GoogleFonts.cairo(
                                  fontSize: ResponsiveHelper.fontSize(17),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  height: 1.3,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              SizedBox(height: ResponsiveHelper.height(10)),

                              // Verified Badge & Rating
                              Row(
                                textDirection: TextDirection.rtl,
                                children: [
                                  // Verified Badge
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ResponsiveHelper.width(10),
                                      vertical: ResponsiveHelper.height(6),
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.success,
                                          AppColors.success.withOpacity(0.8),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        ResponsiveHelper.radius(20),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.success.withOpacity(
                                            0.2,
                                          ),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.verified_rounded,
                                          color: AppColors.white,
                                          size: ResponsiveHelper.width(14),
                                        ),
                                        SizedBox(
                                          width: ResponsiveHelper.width(4),
                                        ),
                                        Text(
                                          'موثق',
                                          style: GoogleFonts.tajawal(
                                            fontSize: ResponsiveHelper.fontSize(
                                              11,
                                            ),
                                            color: AppColors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(width: ResponsiveHelper.width(10)),

                                  // Rating
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ResponsiveHelper.width(10),
                                      vertical: ResponsiveHelper.height(6),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.amber.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(
                                        ResponsiveHelper.radius(20),
                                      ),
                                      border: Border.all(
                                        color: Colors.amber.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          color: Colors.amber,
                                          size: ResponsiveHelper.width(14),
                                        ),
                                        SizedBox(
                                          width: ResponsiveHelper.width(4),
                                        ),
                                        Text(
                                          '4.8',
                                          style: GoogleFonts.cairo(
                                            fontSize: ResponsiveHelper.fontSize(
                                              12,
                                            ),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(
                                          width: ResponsiveHelper.width(4),
                                        ),
                                        Text(
                                          '(245)',
                                          style: GoogleFonts.tajawal(
                                            fontSize: ResponsiveHelper.fontSize(
                                              10,
                                            ),
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: ResponsiveHelper.height(16)),

                        // Price Card
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(20),
                          ),
                          child: const PremiumPriceCard(
                            price: 3500,
                            bedrooms: 2,
                            bathrooms: 1,
                            area: 80,
                          ),
                        ),

                        SizedBox(height: ResponsiveHelper.height(16)),

                        // Location Card
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(20),
                          ),
                          child: LocationCard(
                            address: 'شارع عباس العقاد، مدينة نصر، القاهرة',
                            onTap: _openGoogleMaps,
                          ),
                        ),

                        SizedBox(height: ResponsiveHelper.height(20)),

                        // Amenities
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'المرافق والخدمات',
                                style: GoogleFonts.cairo(
                                  fontSize: ResponsiveHelper.fontSize(16),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              SizedBox(height: ResponsiveHelper.height(12)),
                              ProfessionalAmenities(amenities: _amenities),
                            ],
                          ),
                        ),

                        SizedBox(height: ResponsiveHelper.height(20)),

                        // Description
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: DescriptionSection(
                            description:
                                'شقة استوديو حديثة ومجهزة بالكامل في موقع مميز بمدينة نصر. تتميز الشقة بتصميم عصري وإطلالة رائعة. قريبة من جميع الخدمات والمواصلات. مثالية للأفراد أو الأزواج الشباب.\n\nتشمل الشقة:\n• غرفة معيشة واسعة\n• مطبخ مجهز بالكامل\n• حمام حديث\n• شرفة واسعة\n\nالموقع قريب من:\n• محطة المترو (5 دقائق)\n• سيتي ستارز (10 دقائق)\n• المستشفيات والمدارس',
                          ),
                        ),

                        SizedBox(height: ResponsiveHelper.height(24)),

                        // 🆕 BOOKING SECTION - PAYMENT INTEGRATION
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(20),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(ResponsiveHelper.width(20)),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  AppColors.primary,
                                  AppColors.primary.withOpacity(0.8),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(
                                ResponsiveHelper.radius(16),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
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
                                      padding: EdgeInsets.all(
                                        ResponsiveHelper.width(10),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(
                                          ResponsiveHelper.radius(10),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.event_available_rounded,
                                        color: Colors.white,
                                        size: ResponsiveHelper.width(24),
                                      ),
                                    ),
                                    SizedBox(width: ResponsiveHelper.width(12)),
                                    Expanded(
                                      child: Text(
                                        'احجز معاينة الآن',
                                        style: GoogleFonts.cairo(
                                          fontSize: ResponsiveHelper.fontSize(
                                            18,
                                          ),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: ResponsiveHelper.height(12)),
                                Text(
                                  'ادفع رسوم الحجز لتأكيد موعد المعاينة مع المالك',
                                  style: GoogleFonts.tajawal(
                                    fontSize: ResponsiveHelper.fontSize(13),
                                    color: Colors.white.withOpacity(0.95),
                                    height: 1.5,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                                SizedBox(height: ResponsiveHelper.height(16)),

                                // Benefits Row
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    _buildBenefit(
                                      Icons.verified_rounded,
                                      'ضمان الموعد',
                                    ),
                                    SizedBox(width: ResponsiveHelper.width(16)),
                                    _buildBenefit(
                                      Icons.schedule_rounded,
                                      'رد سريع',
                                    ),
                                    SizedBox(width: ResponsiveHelper.width(16)),
                                    _buildBenefit(
                                      Icons.shield_rounded,
                                      'آمن ومضمون',
                                    ),
                                  ],
                                ),

                                SizedBox(height: ResponsiveHelper.height(16)),

                                // Payment Button
                                ElevatedButton(
                                  onPressed: () {
                                    // ✅ CORRECT - Use full path with leading slash
                                    context.push(
                                      '/${RouteNames.paymentMethodSelection}',
                                      extra: {
                                        'apartmentTitle':
                                            'شقة استوديو فاخرة في موقع مميز',
                                        'amount': 200,
                                        'apartmentId': 'apt_demo_123',
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: AppColors.primary,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ResponsiveHelper.width(24),
                                      vertical: ResponsiveHelper.height(14),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        ResponsiveHelper.radius(12),
                                      ),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      Icon(
                                        Icons.payments_rounded,
                                        color: AppColors.primary,
                                        size: ResponsiveHelper.width(22),
                                      ),
                                      SizedBox(
                                        width: ResponsiveHelper.width(12),
                                      ),
                                      Text(
                                        'ادفع 200 جنيه - احجز الآن',
                                        style: GoogleFonts.cairo(
                                          fontSize: ResponsiveHelper.fontSize(
                                            16,
                                          ),
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: ResponsiveHelper.height(20)),

                        // Enhanced Contact Card
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(20),
                          ),
                          child: const EnhancedContactCard(
                            ownerName: 'أحمد محمد',
                            ownerImage: 'https://i.pravatar.cc/150?img=33',
                            phoneNumber: '+20 100 123 4567',
                            whatsappNumber: '+20 100 123 4567',
                            responseTime: '< 5 دقائق',
                            rating: 4.9,
                          ),
                        ),

                        SizedBox(height: ResponsiveHelper.height(100)),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Top App Bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.width(16),
                      vertical: ResponsiveHelper.height(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      textDirection: TextDirection.rtl,
                      children: [
                        _buildActionButton(
                          icon: Icons.arrow_forward_ios,
                          onTap: () => context.pop(),
                        ),
                        Row(
                          children: [
                            _buildActionButton(
                              icon: Icons.share_rounded,
                              onTap: () {},
                            ),
                            SizedBox(width: ResponsiveHelper.width(12)),
                            _buildActionButton(
                              icon: _isFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              onTap: () {
                                setState(() {
                                  _isFavorite = !_isFavorite;
                                });
                              },
                              color: _isFavorite ? AppColors.error : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Bottom Chat Bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(ResponsiveHelper.width(16)),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: GestureDetector(
                    onTap: () {
                      context.push(RouteNames.chats);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: ResponsiveHelper.height(14),
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.secondary],
                        ),
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(14),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection: TextDirection.rtl,
                        children: [
                          Icon(
                            Icons.chat_bubble_rounded,
                            color: AppColors.white,
                            size: ResponsiveHelper.width(22),
                          ),
                          SizedBox(width: ResponsiveHelper.width(10)),
                          Text(
                            'محادثة المالك',
                            style: GoogleFonts.cairo(
                              fontSize: ResponsiveHelper.fontSize(16),
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ResponsiveHelper.width(42),
        height: ResponsiveHelper.width(42),
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: color ?? Colors.black87,
          size: ResponsiveHelper.width(22),
        ),
      ),
    );
  }

  // 🆕 ADD THIS HELPER METHOD
  Widget _buildBenefit(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: ResponsiveHelper.width(16)),
        SizedBox(width: ResponsiveHelper.width(4)),
        Text(
          text,
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(11),
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _openGoogleMaps() async {
    const double lat = 30.0594;
    const double lng = 31.3464;

    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'تعذر فتح الخريطة',
              style: GoogleFonts.tajawal(),
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}
