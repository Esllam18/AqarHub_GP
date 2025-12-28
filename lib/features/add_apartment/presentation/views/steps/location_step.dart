import 'package:aqar_hub_gp/core/locations/egyptian_locations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../../widgets/custom_step_button.dart';

class LocationStep extends StatefulWidget {
  final Map<String, dynamic> data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const LocationStep({
    super.key,
    required this.data,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<LocationStep> createState() => _LocationStepState();
}

class _LocationStepState extends State<LocationStep> {
  String? _selectedGovernorate;
  String? _selectedCity;
  String? _selectedNeighborhood;

  List<String> _governorates = [];
  List<String> _cities = [];
  List<String> _neighborhoods = [];

  @override
  void initState() {
    super.initState();
    _governorates = EgyptianLocations.getGovernorates();

    // Restore saved data
    _selectedGovernorate = widget.data['governorate'];
    _selectedCity = widget.data['city'];
    _selectedNeighborhood = widget.data['neighborhood'];

    if (_selectedGovernorate != null) {
      _cities = EgyptianLocations.getCities(_selectedGovernorate!);

      if (_selectedCity != null) {
        _neighborhoods = EgyptianLocations.getNeighborhoods(
          _selectedGovernorate!,
          _selectedCity!,
        );
      }
    }
  }

  void _onGovernorateSelected(String governorate) {
    setState(() {
      _selectedGovernorate = governorate;
      _selectedCity = null;
      _selectedNeighborhood = null;
      _cities = EgyptianLocations.getCities(governorate);
      _neighborhoods = [];
    });
  }

  void _onCitySelected(String city) {
    setState(() {
      _selectedCity = city;
      _selectedNeighborhood = null;
      _neighborhoods = EgyptianLocations.getNeighborhoods(
        _selectedGovernorate!,
        city,
      );
    });
  }

  void _onNeighborhoodSelected(String neighborhood) {
    setState(() {
      _selectedNeighborhood = neighborhood;
    });
  }

  void _saveAndNext() {
    widget.data['governorate'] = _selectedGovernorate;
    widget.data['city'] = _selectedCity;
    widget.data['neighborhood'] = _selectedNeighborhood;
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
                  // Title
                  Text(
                    'الموقع',
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(24),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.height(8)),
                  Text(
                    'حدد موقع العقار بدقة',
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(14),
                      color: Colors.grey.shade600,
                    ),
                  ),

                  SizedBox(height: ResponsiveHelper.height(32)),

                  // 1. Governorate Selection
                  _buildSectionTitle('المحافظة', null),
                  SizedBox(height: ResponsiveHelper.height(16)),
                  _buildChipsList(
                    items: _governorates,
                    selectedItem: _selectedGovernorate,
                    onSelected: _onGovernorateSelected,
                  ),

                  // 2. City/Center Selection
                  if (_selectedGovernorate != null) ...[
                    SizedBox(height: ResponsiveHelper.height(32)),
                    _buildSectionTitle(
                      'المركز / المدينة',
                      '${_cities.length} مركز',
                    ),
                    SizedBox(height: ResponsiveHelper.height(16)),
                    _buildChipsList(
                      items: _cities,
                      selectedItem: _selectedCity,
                      onSelected: _onCitySelected,
                    ),
                  ],

                  // 3. Neighborhood Selection
                  if (_selectedCity != null) ...[
                    SizedBox(height: ResponsiveHelper.height(32)),
                    _buildSectionTitle(
                      'الحي / المنطقة',
                      '${_neighborhoods.length} منطقة',
                    ),
                    SizedBox(height: ResponsiveHelper.height(16)),
                    _buildChipsList(
                      items: _neighborhoods,
                      selectedItem: _selectedNeighborhood,
                      onSelected: _onNeighborhoodSelected,
                    ),
                  ],

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
                    isEnabled:
                        _selectedGovernorate != null &&
                        _selectedCity != null &&
                        _selectedNeighborhood != null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, String? count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.rtl,
      children: [
        Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(16),
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        if (count != null)
          Text(
            count,
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(13),
              color: Colors.grey.shade600,
            ),
          ),
      ],
    );
  }

  Widget _buildChipsList({
    required List<String> items,
    required String? selectedItem,
    required Function(String) onSelected,
  }) {
    return Wrap(
      spacing: ResponsiveHelper.width(12),
      runSpacing: ResponsiveHelper.height(12),
      children: items.map((item) {
        final isSelected = selectedItem == item;
        return _buildChip(
          label: item,
          isSelected: isSelected,
          onTap: () => onSelected(item),
        );
      }).toList(),
    );
  }

  Widget _buildChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(20),
          vertical: ResponsiveHelper.height(12),
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(14),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? Colors.white : Colors.black87,
          ),
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}
