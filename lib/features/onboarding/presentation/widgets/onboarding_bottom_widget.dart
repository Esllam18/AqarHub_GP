import 'package:aqar_hub_gp/core/consts/app_strings.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/features/onboarding/data/datasources/onboarding_data.dart';
import 'package:flutter/material.dart';
import 'onboarding_button_widget.dart';
import 'page_indicator_widget.dart';

class OnboardingBottomWidget extends StatelessWidget {
  final int currentPage;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingBottomWidget({
    super.key,
    required this.currentPage,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final pages = OnboardingData.getOnboardingPages();
    final isLastPage = currentPage == pages.length - 1;

    return Padding(
      padding: EdgeInsets.all(ResponsiveHelper.width(24)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Page Indicator
          PageIndicatorWidget(
            currentPage: currentPage,
            pageCount: pages.length,
          ),

          SizedBox(height: ResponsiveHelper.height(40)),

          // Buttons
          if (isLastPage)
            OnboardingButtonWidget(
              text: OnboardingStrings.buttonStart,
              onPressed: onNext,
            )
          else
            Row(
              children: [
                Expanded(
                  child: OnboardingButtonWidget(
                    text: OnboardingStrings.buttonSkip,
                    onPressed: onSkip,
                    isOutlined: true,
                  ),
                ),
                SizedBox(width: ResponsiveHelper.width(16)),
                Expanded(
                  child: OnboardingButtonWidget(
                    text: OnboardingStrings.buttonNext,
                    onPressed: onNext,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
