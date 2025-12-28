import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../../widgets/custom_step_button.dart';

class DescriptionStep extends StatefulWidget {
  final Map<String, dynamic> data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const DescriptionStep({
    super.key,
    required this.data,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<DescriptionStep> createState() => _DescriptionStepState();
}

class _DescriptionStepState extends State<DescriptionStep> {
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<String> _quickPhrases = [
    'موقع مميز',
    'تشطيب فاخر',
    'قريب من الخدمات',
    'إطلالة رائعة',
    'هادئ ومريح',
    'مناسب للعائلات',
    'استثمار مربح',
    'بسعر مميز',
  ];

  @override
  void initState() {
    super.initState();
    _descriptionController.text = widget.data['description'] ?? '';
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addPhrase(String phrase) {
    final currentText = _descriptionController.text;
    if (currentText.isNotEmpty && !currentText.endsWith(' ')) {
      _descriptionController.text = '$currentText - $phrase';
    } else {
      _descriptionController.text = '$currentText$phrase';
    }
    setState(() {});
  }

  void _saveAndNext() {
    widget.data['description'] = _descriptionController.text;
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    final characterCount = _descriptionController.text.length;

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
                    'وصف العقار',
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(24),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.height(8)),
                  Text(
                    'اكتب وصفاً جذاباً للعقار',
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(14),
                      color: Colors.grey.shade600,
                    ),
                  ),

                  SizedBox(height: ResponsiveHelper.height(24)),

                  // Description TextField
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(
                        ResponsiveHelper.radius(16),
                      ),
                      border: Border.all(
                        color: _focusNode.hasFocus
                            ? AppColors.primary
                            : Colors.grey.shade300,
                        width: _focusNode.hasFocus ? 2 : 1,
                      ),
                    ),
                    child: TextField(
                      controller: _descriptionController,
                      focusNode: _focusNode,
                      textDirection: TextDirection.rtl,
                      maxLines: 8,
                      maxLength: 500,
                      style: GoogleFonts.tajawal(
                        fontSize: ResponsiveHelper.fontSize(14),
                        height: 1.6,
                      ),
                      decoration: InputDecoration(
                        hintText:
                            'اكتب وصفاً تفصيلياً للعقار...\n\nمثال: شقة فاخرة بموقع استراتيجي في قلب المدينة، قريبة من جميع الخدمات والمواصلات. تشطيب عصري وإطلالة مميزة.',
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: GoogleFonts.tajawal(
                          color: Colors.grey.shade400,
                          fontSize: ResponsiveHelper.fontSize(13),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(
                          ResponsiveHelper.width(16),
                        ),
                      ),
                      onChanged: (value) => setState(() {}),
                    ),
                  ),

                  SizedBox(height: ResponsiveHelper.height(16)),

                  // Character Count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    textDirection: TextDirection.ltr,
                    children: [
                      Text(
                        '$characterCount / 500',
                        style: GoogleFonts.tajawal(
                          fontSize: ResponsiveHelper.fontSize(12),
                          color: characterCount > 450
                              ? Colors.orange
                              : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: ResponsiveHelper.height(24)),

                  // Quick Phrases
                  Text(
                    'عبارات سريعة',
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(14),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: ResponsiveHelper.height(12)),

                  Wrap(
                    spacing: ResponsiveHelper.width(8),
                    runSpacing: ResponsiveHelper.height(8),
                    textDirection: TextDirection.rtl,
                    children: _quickPhrases.map((phrase) {
                      return GestureDetector(
                        onTap: () => _addPhrase(phrase),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(14),
                            vertical: ResponsiveHelper.height(8),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              ResponsiveHelper.radius(20),
                            ),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            textDirection: TextDirection.rtl,
                            children: [
                              Icon(
                                Icons.add_circle_outline_rounded,
                                size: ResponsiveHelper.width(16),
                                color: AppColors.primary,
                              ),
                              SizedBox(width: ResponsiveHelper.width(4)),
                              Text(
                                phrase,
                                style: GoogleFonts.tajawal(
                                  fontSize: ResponsiveHelper.fontSize(12),
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                    isEnabled: _descriptionController.text.length >= 20,
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
