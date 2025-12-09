import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingInitial());

  void onPageChanged(int index) {
    emit(OnboardingPageChanged(index));
  }

  void completeOnboarding() {
    emit(OnboardingCompleted());
  }

  int getCurrentPage() {
    final state = this.state;
    if (state is OnboardingPageChanged) {
      return state.currentPage;
    } else if (state is OnboardingInitial) {
      return state.currentPage;
    }
    return 0;
  }
}
