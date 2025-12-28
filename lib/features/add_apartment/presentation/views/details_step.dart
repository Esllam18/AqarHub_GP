import 'package:aqar_hub_gp/features/add_apartment/presentation/widgets/custom_step_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class DetailsStep extends StatefulWidget {
  final Map<String, dynamic> data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const DetailsStep({
    super.key,
    required this.data,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<DetailsStep> createState() => _DetailsStepState();
}

class _DetailsStepState extends State<DetailsStep> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  List<String> _selectedAmenities = [];

  final Map<String, Map<String, dynamic>> _amenities = {
    'wifi': {'label': 'واي فاي', 'icon': Icons.wifi_rounded},
    'parking': {'label': 'موقف سيارات', 'icon': Icons.local_parking_rounded},
    'elevator': {'label': 'مصعد', 'icon': Icons.elevator_rounded},
    'ac': {'label': 'تكييف', 'icon': Icons.ac_unit_rounded},
    'security': {'label': 'حراسة 24/7', 'icon': Icons.security_rounded},
    'pool': {'label': 'حمام سباحة', 'icon': Icons.pool_rounded},
    'gym': {'label': 'جيم', 'icon': Icons.fitness_center_rounded},
    'garden': {'label': 'حديقة', 'icon': Icons.yard_rounded},
    'balcony': {'label': 'بلكونة', 'icon': Icons.balcony_rounded},
    'furnished': {'label': 'مفروش', 'icon': Icons.weekend_rounded},
  };

  @override
  void initState() {
    super.initState();
    _descriptionController.text = widget.data['description'] ?? '';
    _priceController.text = widget.data['price']?.toString() ?? '';
    _selectedAmenities = List<String>.from(widget.data['amenities'] ?? []);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _toggleAmenity(String amenity) {
    setState(() {
      if (_selectedAmenities.contains(amenity)) {
        _selectedAmenities.remove(amenity);
      } else {
        _selectedAmenities.add(amenity);
      }
    });
  }

  void _saveAndNext() {
    widget.data['description'] = _descriptionController.text;
    widget.data['price'] = int.tryParse(_priceController.text) ?? 0;
    widget.data['amenities'] = _selectedAmenities;
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
                    'التفاصيل والمميزات',
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(24),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.height(8)),
                  Text(
                    'أضف وصف تفصيلي والمرافق المتوفرة',
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(14),
                      color: Colors.grey.shade600,
                    ),
                  ),

                  SizedBox(height: ResponsiveHelper.height(24)),

                  // Price Field
                  _buildSectionTitle('السعر *'),
                  SizedBox(height: ResponsiveHelper.height(12)),
                  TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'أدخل السعر بالجنيه',
                      hintStyle: GoogleFonts.tajawal(
                        color: Colors.grey.shade400,
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(ResponsiveHelper.width(12)),
                        child: Text(
                          'ج.م',
                          style: GoogleFonts.cairo(
                            fontSize: ResponsiveHelper.fontSize(14),
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(12),
                        ),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(12),
                        ),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(12),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                    ),
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(16),
                    ),
                  ),

                  SizedBox(height: ResponsiveHelper.height(24)),

                  // Description Field
                  _buildSectionTitle('الوصف *'),
                  SizedBox(height: ResponsiveHelper.height(12)),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: 'اكتب وصفاً تفصيلياً عن العقار...',
                      hintStyle: GoogleFonts.tajawal(
                        color: Colors.grey.shade400,
                      ),
                      filled: true,
                      fillColor: AppColors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(12),
                        ),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(12),
                        ),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(12),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                    ),
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(14),
                      height: 1.6,
                    ),
                  ),

                  SizedBox(height: ResponsiveHelper.height(24)),

                  // Amenities Section
                  _buildSectionTitle('المرافق والخدمات'),
                  SizedBox(height: ResponsiveHelper.height(12)),
                  Text(
                    'اختر المرافق المتوفرة في العقار',
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(13),
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.height(16)),

                  Wrap(
                    spacing: ResponsiveHelper.width(12),
                    runSpacing: ResponsiveHelper.height(12),
                    children: _amenities.entries.map((entry) {
                      final isSelected = _selectedAmenities.contains(entry.key);
                      return _buildAmenityChip(
                        key: entry.key,
                        label: entry.value['label'],
                        icon: entry.value['icon'],
                        isSelected: isSelected,
                      );
                    }).toList(),
                  ),

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
                        _priceController.text.isNotEmpty &&
                        _descriptionController.text.isNotEmpty,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.cairo(
        fontSize: ResponsiveHelper.fontSize(16),
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildAmenityChip({
    required String key,
    required String label,
    required IconData icon,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () => _toggleAmenity(key),
      borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(16),
          vertical: ResponsiveHelper.height(12),
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey.shade600,
              size: ResponsiveHelper.width(20),
            ),
            SizedBox(width: ResponsiveHelper.width(8)),
            Text(
              label,
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(13),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
