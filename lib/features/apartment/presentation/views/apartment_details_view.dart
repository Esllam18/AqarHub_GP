import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/auto_image_carousel.dart';
import '../widgets/premium_price_card.dart';
import '../widgets/location_card.dart';
import '../widgets/professional_amenities.dart';
import '../widgets/description_section.dart';
import '../widgets/enhanced_contact_card.dart';
import '../widgets/details/apartment_title_badges.dart';
import '../widgets/details/booking_section.dart';
import '../widgets/details/details_app_bar.dart';
import '../widgets/details/chat_action_bar.dart';

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

  final String _apartmentTitle = 'شقة استوديو فاخرة في موقع مميز';
  final String _description =
      'شقة استوديو حديثة ومجهزة بالكامل في موقع مميز بمدينة نصر. تتميز الشقة بتصميم عصري وإطلالة رائعة. قريبة من جميع الخدمات والمواصلات. مثالية للأفراد أو الأزواج الشباب.\n\nتشمل الشقة:\n• غرفة معيشة واسعة\n• مطبخ مجهز بالكامل\n• حمام حديث\n• شرفة واسعة\n\nالموقع قريب من:\n• محطة المترو (5 دقائق)\n• سيتي ستارز (10 دقائق)\n• المستشفيات والمدارس';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            _buildMainContent(),
            _buildTopAppBar(),
            _buildBottomChatBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: AutoImageCarousel(images: _images)),
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
                _buildTitleSection(),
                SizedBox(height: ResponsiveHelper.height(16)),
                _buildPriceSection(),
                SizedBox(height: ResponsiveHelper.height(16)),
                _buildLocationSection(),
                SizedBox(height: ResponsiveHelper.height(20)),
                _buildAmenitiesSection(),
                SizedBox(height: ResponsiveHelper.height(20)),
                _buildDescriptionSection(),
                SizedBox(height: ResponsiveHelper.height(24)),
                _buildBookingSection(),
                SizedBox(height: ResponsiveHelper.height(20)),
                _buildContactSection(),
                SizedBox(height: ResponsiveHelper.height(100)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(20)),
      child: ApartmentTitleBadges(
        title: _apartmentTitle,
        isVerified: true,
        rating: 4.8,
        reviewsCount: 245,
      ),
    );
  }

  Widget _buildPriceSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(20)),
      child: const PremiumPriceCard(
        price: 3500,
        bedrooms: 2,
        bathrooms: 1,
        area: 80,
      ),
    );
  }

  Widget _buildLocationSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(20)),
      child: LocationCard(
        address: 'شارع عباس العقاد، مدينة نصر، القاهرة',
        onTap: _openGoogleMaps,
      ),
    );
  }

  Widget _buildAmenitiesSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(20)),
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
    );
  }

  Widget _buildDescriptionSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(20)),
      child: DescriptionSection(description: _description),
    );
  }

  Widget _buildBookingSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(20)),
      child: BookingSection(apartmentTitle: _apartmentTitle),
    );
  }

  Widget _buildContactSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(20)),
      child: const EnhancedContactCard(
        ownerName: 'أحمد محمد',
        ownerImage: 'https://i.pravatar.cc/150?img=33',
        phoneNumber: '+20 100 123 4567',
        whatsappNumber: '+20 100 123 4567',
        responseTime: '< 5 دقائق',
        rating: 4.9,
      ),
    );
  }

  Widget _buildTopAppBar() {
    return DetailsAppBar(
      isFavorite: _isFavorite,
      onBack: () => context.pop(),
      onShare: () {},
      onFavoriteToggle: _toggleFavorite,
    );
  }

  Widget _buildBottomChatBar() {
    return ChatActionBar(onTap: _openChat);
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void _openChat() {
    // TODO: Navigate to chat
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
