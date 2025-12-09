import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/features/onboarding/data/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'onboarding_description_widget.dart';
import 'onboarding_image_widget.dart';
import 'onboarding_title_widget.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingModel page;

  const OnboardingPageWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(24)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),

          // Image
          OnboardingImageWidget(image: page.image),

          SizedBox(height: ResponsiveHelper.height(40)),

          // Title
          OnboardingTitleWidget(title: page.title),

          SizedBox(height: ResponsiveHelper.height(16)),

          // Description
          OnboardingDescriptionWidget(description: page.description),

          const Spacer(),
        ],
      ),
    );
  }
}
