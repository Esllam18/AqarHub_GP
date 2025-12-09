import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'package:aqar_hub_gp/core/services/navigation_service.dart';
import 'package:aqar_hub_gp/features/onboarding/data/datasources/onboarding_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';
import '../widgets/onboarding_bottom_widget.dart';
import '../widgets/onboarding_content_widget.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    final currentPage = context.read<OnboardingCubit>().getCurrentPage();
    final pages = OnboardingData.getOnboardingPages();

    if (currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _onSkip() {
    _completeOnboarding();
  }

  void _completeOnboarding() {
    context.read<OnboardingCubit>().completeOnboarding();

    // NavigationService.navigateToAndReplace(context, RouteNames.home);
    // OR
    NavigationService.navigateToAndReplace(context, RouteNames.welcome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            final currentPage = context
                .read<OnboardingCubit>()
                .getCurrentPage();

            return Column(
              children: [
                // Content
                Expanded(
                  child: OnboardingContentWidget(
                    pageController: _pageController,
                    onPageChanged: (index) {
                      context.read<OnboardingCubit>().onPageChanged(index);
                    },
                  ),
                ),

                // Bottom Section
                OnboardingBottomWidget(
                  currentPage: currentPage,
                  onNext: _onNext,
                  onSkip: _onSkip,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
