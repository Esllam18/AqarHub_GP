import 'package:aqar_hub_gp/core/consts/app_assets.dart';
import 'package:aqar_hub_gp/core/strings/onboarding_strings.dart';

import '../models/onboarding_model.dart';

class OnboardingData {
  static List<OnboardingModel> getOnboardingPages() {
    return [
      OnboardingModel(
        title: OnboardingStrings.page1Title,
        description: OnboardingStrings.page1Description,
        image: AppImages.onboarding_1,
      ),
      OnboardingModel(
        title: OnboardingStrings.page2Title,
        description: OnboardingStrings.page2Description,
        image: AppImages.onboarding_2,
      ),
      OnboardingModel(
        title: OnboardingStrings.page3Title,
        description: OnboardingStrings.page3Description,
        image: AppImages.onboarding_3,
      ),
    ];
  }
}
