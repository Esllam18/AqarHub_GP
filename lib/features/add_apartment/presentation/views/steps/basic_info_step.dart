import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../../widgets/custom_step_button.dart';

class BasicInfoStep extends StatefulWidget {
  final Map<String, dynamic> data;
  final VoidCallback onNext;

  const BasicInfoStep({super.key, required this.data, required this.onNext});

  @override
  State<BasicInfoStep> createState() => _BasicInfoStepState();
}

class _BasicInfoStepState extends State<BasicInfoStep> {
  final _titleController = TextEditingController();
  int _selectedRooms = 1;
  int _selectedBathrooms = 1;
  int _area = 50;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.data['title'] ?? '';
    _selectedRooms = widget.data['rooms'] ?? 1;
    _selectedBathrooms = widget.data['bathrooms'] ?? 1;

    // ✅ FIX: Ensure area is within slider bounds (30-500)
    final savedArea = widget.data['area'] ?? 50;
    _area = savedArea < 30 ? 50 : (savedArea > 500 ? 500 : savedArea);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _saveAndNext() {
    widget.data['title'] = _titleController.text;
    widget.data['rooms'] = _selectedRooms;
    widget.data['bathrooms'] = _selectedBathrooms;
    widget.data['area'] = _area;
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(ResponsiveHelper.width(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'المعلومات الأساسية',
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(24),
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: ResponsiveHelper.height(8)),
            Text(
              'أدخل التفاصيل الأساسية للعقار',
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(14),
                color: Colors.grey.shade600,
              ),
            ),

            SizedBox(height: ResponsiveHelper.height(32)),

            // Apartment Title
            _buildSectionTitle('عنوان العقار'),
            SizedBox(height: ResponsiveHelper.height(12)),
            TextField(
              controller: _titleController,
              textDirection: TextDirection.rtl,
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(14),
              ),
              decoration: InputDecoration(
                hintText: 'مثال: شقة فاخرة في موقع مميز',
                hintTextDirection: TextDirection.rtl,
                hintStyle: GoogleFonts.tajawal(color: Colors.grey.shade400),
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
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
            ),

            SizedBox(height: ResponsiveHelper.height(24)),

            // Number of Rooms
            _buildSectionTitle('عدد الغرف'),
            SizedBox(height: ResponsiveHelper.height(12)),
            _buildNumberSelector(
              value: _selectedRooms,
              min: 1,
              max: 10,
              onChanged: (val) => setState(() => _selectedRooms = val),
            ),

            SizedBox(height: ResponsiveHelper.height(24)),

            // Number of Bathrooms
            _buildSectionTitle('عدد الحمامات'),
            SizedBox(height: ResponsiveHelper.height(12)),
            _buildNumberSelector(
              value: _selectedBathrooms,
              min: 1,
              max: 6,
              onChanged: (val) => setState(() => _selectedBathrooms = val),
            ),

            SizedBox(height: ResponsiveHelper.height(24)),

            // Area
            _buildSectionTitle('المساحة (متر مربع)'),
            SizedBox(height: ResponsiveHelper.height(12)),
            Container(
              padding: EdgeInsets.all(ResponsiveHelper.width(16)),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(12),
                ),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        '$_area م²',
                        style: GoogleFonts.cairo(
                          fontSize: ResponsiveHelper.fontSize(20),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      Icon(
                        Icons.square_foot_rounded,
                        color: AppColors.primary,
                        size: ResponsiveHelper.width(24),
                      ),
                    ],
                  ),
                  SizedBox(height: ResponsiveHelper.height(12)),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: AppColors.primary,
                      inactiveTrackColor: Colors.grey.shade300,
                      thumbColor: AppColors.primary,
                      overlayColor: AppColors.primary.withOpacity(0.2),
                      trackHeight: ResponsiveHelper.height(4),
                    ),
                    child: Slider(
                      value: _area.toDouble(),
                      min: 30,
                      max: 500,
                      divisions: 94,
                      onChanged: (val) => setState(() => _area = val.toInt()),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: ResponsiveHelper.height(40)),

            // Next Button
            CustomStepButton(
              text: 'التالي',
              onPressed: _saveAndNext,
              isEnabled: _titleController.text.isNotEmpty,
            ),

            SizedBox(height: ResponsiveHelper.height(20)),
          ],
        ),
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
      textDirection: TextDirection.rtl,
    );
  }

  Widget _buildNumberSelector({
    required int value,
    required int min,
    required int max,
    required Function(int) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(max - min + 1, (index) {
          final number = min + index;
          final isSelected = value == number;

          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(number),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.all(ResponsiveHelper.width(4)),
                padding: EdgeInsets.symmetric(
                  vertical: ResponsiveHelper.height(12),
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(8),
                  ),
                ),
                child: Text(
                  '$number',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    fontSize: ResponsiveHelper.fontSize(16),
                    fontWeight: FontWeight.bold,
                    color: isSelected ? AppColors.white : Colors.black87,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
