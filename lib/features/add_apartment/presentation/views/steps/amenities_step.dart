import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../../widgets/custom_step_button.dart';
import '../../widgets/amenity_selection_chip.dart';

class AmenitiesStep extends StatefulWidget {
  final Map<String, dynamic> data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AmenitiesStep({
    super.key,
    required this.data,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<AmenitiesStep> createState() => _AmenitiesStepState();
}

class _AmenitiesStepState extends State<AmenitiesStep> {
  final Set<String> _selectedAmenities = {};

  final List<Map<String, dynamic>> _amenitiesList = [
    {'id': 'wifi', 'title': 'واي فاي', 'icon': Icons.wifi_rounded},
    {
      'id': 'parking',
      'title': 'موقف سيارات',
      'icon': Icons.local_parking_rounded,
    },
    {'id': 'elevator', 'title': 'مصعد', 'icon': Icons.elevator_rounded},
    {'id': 'ac', 'title': 'تكييف', 'icon': Icons.ac_unit_rounded},
    {'id': 'security', 'title': 'حراسة', 'icon': Icons.security_rounded},
    {'id': 'pool', 'title': 'حمام سباحة', 'icon': Icons.pool_rounded},
    {'id': 'gym', 'title': 'جيم', 'icon': Icons.fitness_center_rounded},
    {'id': 'garden', 'title': 'حديقة', 'icon': Icons.park_rounded},
    {'id': 'balcony', 'title': 'بلكونة', 'icon': Icons.balcony_rounded},
    {'id': 'furnished', 'title': 'مفروش', 'icon': Icons.chair_rounded},
    {'id': 'kitchen', 'title': 'مطبخ', 'icon': Icons.kitchen_rounded},
    {
      'id': 'laundry',
      'title': 'غسالة',
      'icon': Icons.local_laundry_service_rounded,
    },
    {
      'id': 'dishwasher',
      'title': 'غسالة أطباق',
      'icon': Icons.countertops_rounded,
    },
    {'id': 'heating', 'title': 'تدفئة', 'icon': Icons.whatshot_rounded},
    {'id': 'intercom', 'title': 'انتركم', 'icon': Icons.phone_in_talk_rounded},
    {'id': 'cctv', 'title': 'كاميرات مراقبة', 'icon': Icons.videocam_rounded},
    {
      'id': 'pet_friendly',
      'title': 'يسمح بالحيوانات',
      'icon': Icons.pets_rounded,
    },
    {'id': 'sea_view', 'title': 'إطلالة بحرية', 'icon': Icons.water_rounded},
    {
      'id': 'city_view',
      'title': 'إطلالة على المدينة',
      'icon': Icons.location_city_rounded,
    },
    {'id': 'smart_home', 'title': 'منزل ذكي', 'icon': Icons.lightbulb_rounded},
  ];

  @override
  void initState() {
    super.initState();
    final amenities = widget.data['amenities'] as List<dynamic>?;
    if (amenities != null) {
      _selectedAmenities.addAll(amenities.cast<String>());
    }
  }

  void _toggleAmenity(String amenityId) {
    setState(() {
      if (_selectedAmenities.contains(amenityId)) {
        _selectedAmenities.remove(amenityId);
      } else {
        _selectedAmenities.add(amenityId);
      }
    });
  }

  void _saveAndNext() {
    widget.data['amenities'] = _selectedAmenities.toList();
    widget.onNext();
  }

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
                  // Title with animation
                  Text(
                    'المرافق والخدمات',
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(24),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.height(8)),
                  Text(
                    'اختر المرافق المتوفرة في العقار',
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(14),
                      color: Colors.grey.shade600,
                    ),
                  ),

                  SizedBox(height: ResponsiveHelper.height(16)),

                  // Selected count indicator
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.width(16),
                      vertical: ResponsiveHelper.height(12),
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.1),
                          AppColors.secondary.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(
                        ResponsiveHelper.radius(12),
                      ),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.primary,
                          size: ResponsiveHelper.width(20),
                        ),
                        SizedBox(width: ResponsiveHelper.width(8)),
                        Text(
                          'تم اختيار ${_selectedAmenities.length} من ${_amenitiesList.length}',
                          style: GoogleFonts.cairo(
                            fontSize: ResponsiveHelper.fontSize(14),
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: ResponsiveHelper.height(24)),

                  // Amenities Grid (Twitter-style)
                  Wrap(
                    spacing: ResponsiveHelper.width(10),
                    runSpacing: ResponsiveHelper.height(10),
                    textDirection: TextDirection.rtl,
                    children: _amenitiesList.map((amenity) {
                      final isSelected = _selectedAmenities.contains(
                        amenity['id'],
                      );

                      return AmenitySelectionChip(
                        title: amenity['title'],
                        icon: amenity['icon'],
                        isSelected: isSelected,
                        onTap: () => _toggleAmenity(amenity['id']),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: ResponsiveHelper.height(20)),
                ],
              ),
            ),
          ),

          // Bottom Buttons (Fixed)
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
                    onPressed: widget.onBack,
                    isPrimary: false,
                  ),
                ),
                SizedBox(width: ResponsiveHelper.width(12)),
                Expanded(
                  flex: 2,
                  child: CustomStepButton(
                    text: 'التالي',
                    onPressed: _saveAndNext,
                    isEnabled: _selectedAmenities.isNotEmpty,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
