import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'preview_image_card.dart';

class PreviewImagesList extends StatelessWidget {
  final List? images;
  static const String placeholderImageUrl =
      'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800&q=80';

  const PreviewImagesList({super.key, this.images});

  @override
  Widget build(BuildContext context) {
    if (images == null || images!.isEmpty) {
      return _buildPlaceholderImage();
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      reverse: false,
      itemCount: images!.length,
      itemBuilder: (context, index) {
        final imageUrl = images![index]?.toString() ?? '';
        return PreviewImageCard(
          imageUrl: imageUrl,
          isMain: index == 0,
          placeholderUrl: placeholderImageUrl,
        );
      },
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: ResponsiveHelper.width(280),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: ResponsiveHelper.width(60),
            color: Colors.grey.shade400,
          ),
          SizedBox(height: ResponsiveHelper.height(12)),
          Text(
            'لم يتم إضافة صور',
            style: TextStyle(
              fontSize: ResponsiveHelper.fontSize(14),
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: ResponsiveHelper.height(4)),
          Text(
            'ارجع للخطوة السابقة لإضافة صور',
            style: TextStyle(
              fontSize: ResponsiveHelper.fontSize(12),
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
