import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../../widgets/custom_step_button.dart';

class MediaUploadStep extends StatefulWidget {
  final Map<String, dynamic> data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const MediaUploadStep({
    super.key,
    required this.data,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<MediaUploadStep> createState() => _MediaUploadStepState();
}

class _MediaUploadStepState extends State<MediaUploadStep> {
  final List<String> _images = [];
  final List<String> _videos = [];

  @override
  void initState() {
    super.initState();
    final images = widget.data['images'] as List<dynamic>?;
    final videos = widget.data['videos'] as List<dynamic>?;

    if (images != null) {
      _images.addAll(images.cast<String>());
    }
    if (videos != null) {
      _videos.addAll(videos.cast<String>());
    }
  }

  void _addImage() {
    // TODO: Implement image picker
    setState(() {
      // Use a color placeholder instead of network image
      _images.add('asset_placeholder_${_images.length + 1}');
    });
  }

  void _addVideo() {
    // TODO: Implement video picker
    setState(() {
      _videos.add('video_${_videos.length + 1}.mp4');
    });
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _removeVideo(int index) {
    setState(() {
      _videos.removeAt(index);
    });
  }

  void _saveAndNext() {
    widget.data['images'] = _images;
    widget.data['videos'] = _videos;
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
                    'الصور والفيديوهات',
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(24),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.height(8)),
                  Text(
                    'أضف صوراً وفيديوهات للعقار (3 صور على الأقل)',
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(14),
                      color: Colors.grey.shade600,
                    ),
                  ),

                  SizedBox(height: ResponsiveHelper.height(24)),

                  // Images Section
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'الصور (${_images.length})',
                        style: GoogleFonts.cairo(
                          fontSize: ResponsiveHelper.fontSize(16),
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      if (_images.length < 10)
                        TextButton.icon(
                          onPressed: _addImage,
                          icon: Icon(
                            Icons.add_photo_alternate_rounded,
                            size: ResponsiveHelper.width(18),
                          ),
                          label: Text(
                            'إضافة صورة',
                            style: GoogleFonts.tajawal(
                              fontSize: ResponsiveHelper.fontSize(13),
                            ),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: ResponsiveHelper.height(12)),

                  // Images Grid
                  if (_images.isEmpty)
                    _buildEmptyState(
                      icon: Icons.add_photo_alternate_rounded,
                      title: 'لا توجد صور',
                      subtitle: 'انقر على "إضافة صورة" لرفع الصور',
                      onTap: _addImage,
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: ResponsiveHelper.width(10),
                        mainAxisSpacing: ResponsiveHelper.height(10),
                        childAspectRatio: 1,
                      ),
                      itemCount: _images.length,
                      itemBuilder: (context, index) {
                        return _buildImageCard(_images[index], index);
                      },
                    ),

                  SizedBox(height: ResponsiveHelper.height(24)),

                  // Videos Section
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'الفيديوهات (${_videos.length})',
                        style: GoogleFonts.cairo(
                          fontSize: ResponsiveHelper.fontSize(16),
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      if (_videos.length < 3)
                        TextButton.icon(
                          onPressed: _addVideo,
                          icon: Icon(
                            Icons.video_library_rounded,
                            size: ResponsiveHelper.width(18),
                          ),
                          label: Text(
                            'إضافة فيديو',
                            style: GoogleFonts.tajawal(
                              fontSize: ResponsiveHelper.fontSize(13),
                            ),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.secondary,
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: ResponsiveHelper.height(12)),

                  // Videos List
                  if (_videos.isEmpty)
                    _buildEmptyState(
                      icon: Icons.video_library_rounded,
                      title: 'لا توجد فيديوهات',
                      subtitle:
                          'انقر على "إضافة فيديو" لرفع الفيديوهات (اختياري)',
                      onTap: _addVideo,
                      color: AppColors.secondary,
                    )
                  else
                    Column(
                      children: _videos.asMap().entries.map((entry) {
                        return _buildVideoCard(entry.value, entry.key);
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
                    isEnabled: _images.length >= 3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(ResponsiveHelper.width(24)),
        decoration: BoxDecoration(
          color: (color ?? AppColors.primary).withOpacity(0.05),
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
          border: Border.all(
            color: (color ?? AppColors.primary).withOpacity(0.2),
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: ResponsiveHelper.width(48),
              color: (color ?? AppColors.primary).withOpacity(0.5),
            ),
            SizedBox(height: ResponsiveHelper.height(12)),
            Text(
              title,
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(16),
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: ResponsiveHelper.height(4)),
            Text(
              subtitle,
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(12),
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(String imageUrl, int index) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withOpacity(0.2),
                AppColors.secondary.withOpacity(0.2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_rounded,
                  size: ResponsiveHelper.width(36),
                  color: AppColors.primary,
                ),
                SizedBox(height: ResponsiveHelper.height(8)),
                Text(
                  'صورة ${index + 1}',
                  style: GoogleFonts.tajawal(
                    fontSize: ResponsiveHelper.fontSize(13),
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
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
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        Positioned(
          top: ResponsiveHelper.height(8),
          left: ResponsiveHelper.width(8),
          child: GestureDetector(
            onTap: () => _removeImage(index),
            child: Container(
              padding: EdgeInsets.all(ResponsiveHelper.width(4)),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close_rounded,
                color: AppColors.white,
                size: ResponsiveHelper.width(16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoCard(String videoName, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: ResponsiveHelper.height(10)),
      padding: EdgeInsets.all(ResponsiveHelper.width(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            padding: EdgeInsets.all(ResponsiveHelper.width(12)),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
            ),
            child: Icon(
              Icons.videocam_rounded,
              color: AppColors.secondary,
              size: ResponsiveHelper.width(24),
            ),
          ),
          SizedBox(width: ResponsiveHelper.width(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  videoName,
                  style: GoogleFonts.tajawal(
                    fontSize: ResponsiveHelper.fontSize(14),
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: ResponsiveHelper.height(4)),
                Text(
                  'فيديو ${index + 1}',
                  style: GoogleFonts.tajawal(
                    fontSize: ResponsiveHelper.fontSize(12),
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _removeVideo(index),
            icon: Icon(
              Icons.delete_outline_rounded,
              color: Colors.red,
              size: ResponsiveHelper.width(20),
            ),
          ),
        ],
      ),
    );
  }
}
