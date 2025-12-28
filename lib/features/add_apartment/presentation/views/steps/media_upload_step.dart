import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../../widgets/custom_step_button.dart';
import '../../widgets/media_upload/media_empty_state.dart';
import '../../widgets/media_upload/media_image_card.dart';
import '../../widgets/media_upload/media_video_card.dart';

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
    _loadExistingMedia();
  }

  void _loadExistingMedia() {
    final images = widget.data['images'] as List?;
    final videos = widget.data['videos'] as List?;

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
                  _buildHeader(),
                  SizedBox(height: ResponsiveHelper.height(24)),
                  _buildImagesSection(),
                  SizedBox(height: ResponsiveHelper.height(24)),
                  _buildVideosSection(),
                  SizedBox(height: ResponsiveHelper.height(20)),
                ],
              ),
            ),
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }

  Widget _buildImagesSection() {
    return Column(
      children: [
        _buildSectionHeader(
          title: 'الصور (${_images.length})',
          buttonText: 'إضافة صورة',
          icon: Icons.add_photo_alternate_rounded,
          onPressed: _addImage,
          showButton: _images.length < 10,
        ),
        SizedBox(height: ResponsiveHelper.height(12)),
        _images.isEmpty
            ? MediaEmptyState(
                icon: Icons.add_photo_alternate_rounded,
                title: 'لا توجد صور',
                subtitle: 'انقر على "إضافة صورة" لرفع الصور',
                onTap: _addImage,
              )
            : _buildImagesGrid(),
      ],
    );
  }

  Widget _buildVideosSection() {
    return Column(
      children: [
        _buildSectionHeader(
          title: 'الفيديوهات (${_videos.length})',
          buttonText: 'إضافة فيديو',
          icon: Icons.video_library_rounded,
          onPressed: _addVideo,
          showButton: _videos.length < 3,
          color: AppColors.secondary,
        ),
        SizedBox(height: ResponsiveHelper.height(12)),
        _videos.isEmpty
            ? MediaEmptyState(
                icon: Icons.video_library_rounded,
                title: 'لا توجد فيديوهات',
                subtitle: 'انقر على "إضافة فيديو" لرفع الفيديوهات (اختياري)',
                onTap: _addVideo,
                color: AppColors.secondary,
              )
            : _buildVideosList(),
      ],
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String buttonText,
    required IconData icon,
    required VoidCallback onPressed,
    required bool showButton,
    Color? color,
  }) {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(16),
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        if (showButton)
          TextButton.icon(
            onPressed: onPressed,
            icon: Icon(icon, size: ResponsiveHelper.width(18)),
            label: Text(
              buttonText,
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(13),
              ),
            ),
            style: TextButton.styleFrom(
              foregroundColor: color ?? AppColors.primary,
            ),
          ),
      ],
    );
  }

  Widget _buildImagesGrid() {
    return GridView.builder(
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
        return MediaImageCard(
          imageUrl: _images[index],
          index: index,
          isMain: index == 0,
          onRemove: () => _removeImage(index),
        );
      },
    );
  }

  Widget _buildVideosList() {
    return Column(
      children: _videos.asMap().entries.map((entry) {
        return MediaVideoCard(
          videoName: entry.value,
          index: entry.key,
          onRemove: () => _removeVideo(entry.key),
        );
      }).toList(),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
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
    );
  }
}
