import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../../widgets/custom_step_button.dart';
import '../../widgets/category_card.dart';

class CategoryTypeStep extends StatefulWidget {
  final Map<String, dynamic> data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const CategoryTypeStep({
    super.key,
    required this.data,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<CategoryTypeStep> createState() => _CategoryTypeStepState();
}

class _CategoryTypeStepState extends State<CategoryTypeStep> {
  String? _selectedCategory;
  String? _selectedType;

  final List<Map<String, dynamic>> _categories = [
    {'id': 'sale', 'title': 'للبيع', 'icon': Icons.sell_rounded},
    {'id': 'rent', 'title': 'للإيجار', 'icon': Icons.key_rounded},
  ];

  final List<Map<String, dynamic>> _types = [
    {'id': 'apartment', 'title': 'شقة', 'icon': Icons.apartment_rounded},
    {'id': 'villa', 'title': 'فيلا', 'icon': Icons.villa_rounded},
    {'id': 'studio', 'title': 'استوديو', 'icon': Icons.home_work_rounded},
    {'id': 'penthouse', 'title': 'بنتهاوس', 'icon': Icons.roofing_rounded},
    {'id': 'duplex', 'title': 'دوبلكس', 'icon': Icons.stairs_rounded},
    {'id': 'chalet', 'title': 'شاليه', 'icon': Icons.beach_access_rounded},
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.data['category'];
    _selectedType = widget.data['type'];
  }

  void _saveAndNext() {
    widget.data['category'] = _selectedCategory;
    widget.data['type'] = _selectedType;
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
              'نوع العقار',
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(24),
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: ResponsiveHelper.height(8)),
            Text(
              'اختر الفئة ونوع العقار',
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(14),
                color: Colors.grey.shade600,
              ),
            ),

            SizedBox(height: ResponsiveHelper.height(32)),

            // Category Selection
            _buildSectionTitle('الفئة'),
            SizedBox(height: ResponsiveHelper.height(12)),
            Row(
              textDirection: TextDirection.rtl,
              children: _categories.map((category) {
                final isSelected = _selectedCategory == category['id'];

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: category == _categories.last
                          ? 0
                          : ResponsiveHelper.width(12),
                    ),
                    child: CategoryCard(
                      title: category['title'],
                      icon: category['icon'],
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          _selectedCategory = category['id'];
                        });
                      },
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: ResponsiveHelper.height(24)),

            // Type Selection
            _buildSectionTitle('نوع العقار'),
            SizedBox(height: ResponsiveHelper.height(12)),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: ResponsiveHelper.width(12),
                mainAxisSpacing: ResponsiveHelper.height(12),
                childAspectRatio: 1.4,
              ),
              itemCount: _types.length,
              itemBuilder: (context, index) {
                final type = _types[index];
                final isSelected = _selectedType == type['id'];

                return CategoryCard(
                  title: type['title'],
                  icon: type['icon'],
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      _selectedType = type['id'];
                    });
                  },
                );
              },
            ),

            SizedBox(height: ResponsiveHelper.height(40)),

            // Buttons
            Row(
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
                        _selectedCategory != null && _selectedType != null,
                  ),
                ),
              ],
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
}
