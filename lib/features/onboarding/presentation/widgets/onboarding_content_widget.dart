import 'package:aqar_hub_gp/features/onboarding/data/datasources/onboarding_data.dart';
import 'package:flutter/material.dart';
import 'onboarding_page_widget.dart';

class OnboardingContentWidget extends StatelessWidget {
  final PageController pageController;
  final Function(int) onPageChanged;

  const OnboardingContentWidget({
    super.key,
    required this.pageController,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final pages = OnboardingData.getOnboardingPages();

    return PageView.builder(
      controller: pageController,
      onPageChanged: onPageChanged,
      itemCount: pages.length,
      itemBuilder: (context, index) {
        return OnboardingPageWidget(page: pages[index]);
      },
    );
  }
}
