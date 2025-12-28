import 'package:aqar_hub_gp/features/add_apartment/presentation/widgets/custom_step_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ImagesStep extends StatefulWidget {
  final Map<String, dynamic> data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const ImagesStep({
    super.key,
    required this.data,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<ImagesStep> createState() => _ImagesStepState();
}

class _ImagesStepState extends State<ImagesStep> {
  List<String> _images = [];

  // Placeholder images for demo
  final List<String> _placeholderImages = [
    'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800&q=80',
    'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&q=80',
    'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800&q=80',
  ];

  @override
  void initState() {
    super.initState();
    _images = List<String>.from(widget.data['images'] ?? []);
  }

  void _addDemoImages() {
    setState(() {
      _images = List.from(_placeholderImages);
    });
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _saveAndNext() {
    widget.data['images'] = _images;
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
                    'صور العقار',
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(24),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.height(8)),
                  Text(
                    'أضف صوراً واضحة للعقار (يمكنك إضافة حتى 10 صور)',
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(14),
                      color: Colors.grey.shade600,
                    ),
                  ),

                  SizedBox(height: ResponsiveHelper.height(24)),

                  // Upload Button (Demo - adds placeholder images)
                  InkWell(
                    onTap: _addDemoImages,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: ResponsiveHelper.height(60),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(16),
                        ),
                        border: Border.all(
                          color: AppColors.primary,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_rounded,
                            size: ResponsiveHelper.width(60),
                            color: AppColors.primary,
                          ),
                          SizedBox(height: ResponsiveHelper.height(12)),
                          Text(
                            'اضغط لإضافة صور',
                            style: GoogleFonts.cairo(
                              fontSize: ResponsiveHelper.fontSize(16),
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(height: ResponsiveHelper.height(4)),
                          Text(
                            '(تجريبي - سيتم إضافة صور توضيحية)',
                            style: GoogleFonts.tajawal(
                              fontSize: ResponsiveHelper.fontSize(12),
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: ResponsiveHelper.height(24)),

                  // Images Grid
                  if (_images.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الصور المضافة (${_images.length})',
                          style: GoogleFonts.cairo(
                            fontSize: ResponsiveHelper.fontSize(16),
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(12),
                            vertical: ResponsiveHelper.height(6),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              ResponsiveHelper.radius(8),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle_rounded,
                                size: ResponsiveHelper.width(16),
                                color: AppColors.success,
                              ),
                              SizedBox(width: ResponsiveHelper.width(4)),
                              Text(
                                'جاهز',
                                style: GoogleFonts.tajawal(
                                  fontSize: ResponsiveHelper.fontSize(12),
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.success,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ResponsiveHelper.height(16)),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: ResponsiveHelper.width(12),
                        mainAxisSpacing: ResponsiveHelper.height(12),
                        childAspectRatio: 1,
                      ),
                      itemCount: _images.length,
                      itemBuilder: (context, index) {
                        return _buildImageCard(_images[index], index);
                      },
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
                    isEnabled: _images.isNotEmpty,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(String imageUrl, int index) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
            border: Border.all(color: Colors.grey.shade300),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Main badge
        if (index == 0)
          Positioned(
            top: ResponsiveHelper.height(8),
            right: ResponsiveHelper.width(8),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(8),
                vertical: ResponsiveHelper.height(4),
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(ResponsiveHelper.radius(6)),
              ),
              child: Text(
                'رئيسية',
                style: GoogleFonts.tajawal(
                  fontSize: ResponsiveHelper.fontSize(10),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        // Delete button
        Positioned(
          top: ResponsiveHelper.height(8),
          left: ResponsiveHelper.width(8),
          child: InkWell(
            onTap: () => _removeImage(index),
            child: Container(
              padding: EdgeInsets.all(ResponsiveHelper.width(6)),
              decoration: BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: ResponsiveHelper.width(16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
