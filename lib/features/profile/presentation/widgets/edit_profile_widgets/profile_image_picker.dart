import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ProfileImagePicker extends StatelessWidget {
  final String imageUrl;

  const ProfileImagePicker({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(child: Stack(children: [_buildAvatar(), _buildEditButton()]));
  }

  Widget _buildAvatar() {
    return Container(
      width: ResponsiveHelper.width(120),
      height: ResponsiveHelper.width(120),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: GestureDetector(
        onTap: () {
          // TODO: Implement image picker
        },
        child: Container(
          padding: EdgeInsets.all(ResponsiveHelper.width(8)),
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.camera_alt_rounded,
            color: Colors.white,
            size: ResponsiveHelper.width(20),
          ),
        ),
      ),
    );
  }
}
