import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/routes.dart';
import '../../../theme/luckit_colors.dart';
import '../onboarding_state.dart';
import '../onboarding_view_model.dart';
import '../widgets/onboarding_app_bar.dart';
import '../widgets/onboarding_bottom_button.dart';
import '../widgets/onboarding_date_input_row_widget.dart';
import '../widgets/onboarding_description_text_widget.dart';
import '../widgets/onboarding_duration_notice_widget.dart';
import '../widgets/onboarding_top_widget.dart';
import '../widgets/selected_goal_widget.dart';

class OnboardingDurationView extends ConsumerWidget {
  const OnboardingDurationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final OnboardingViewModel viewModel =
        ref.read(onboardingViewModelProvider.notifier);
    final OnboardingState state = ref.watch(onboardingViewModelProvider);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const OnboardingTopWidget(
                    title: '목표에 도전할\n기간을 정해주세요',
                    text: '과 목표 달성을 위해 함께\n달려갈 시간을 입력해주세요!',
                    boldText: 'LUCKIT',
                    message: OnboardingDurationNoticeWidget(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        OnboardingDescriptionTextWidget(
                          text: '${state.userName}님이 도전할 목표예요',
                          topPadding: 16.0,
                        ),
                        SelectedGoalWidget(
                          goal: state.goal,
                          duration: state.suggestedDuration,
                        ),
                        const OnboardingDescriptionTextWidget(
                          text: '목표를 시작할 날짜를 입력해주세요',
                          topPadding: 48.0,
                        ),
                        OnboardingDateInputRowWidget(
                          onChangedYear: (String value) =>
                              viewModel.onChangedStartYear(value: value),
                          onChangedMonth: (String value) =>
                              viewModel.onChangedStartMonth(value: value),
                          onChangedDay: (String value) =>
                              viewModel.onChangedStartDay(value: value),
                          yearErrorText: viewModel.startYearErrorText,
                          monthErrorText: viewModel.startMonthErrorText,
                          dayErrorText: viewModel.startDayErrorText,
                        ),
                        const OnboardingDescriptionTextWidget(
                          text: '목표를 종료할 날짜를 입력해주세요',
                          topPadding: 32.0,
                        ),
                        OnboardingDateInputRowWidget(
                          onChangedYear: (String value) =>
                              viewModel.onChangedEndYear(value: value),
                          onChangedMonth: (String value) =>
                              viewModel.onChangedEndMonth(value: value),
                          onChangedDay: (String value) =>
                              viewModel.onChangedEndDay(value: value),
                          yearErrorText: viewModel.endYearErrorText,
                          monthErrorText: viewModel.endMonthErrorText,
                          dayErrorText: viewModel.endDayErrorText,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: OnboardingBottomButton(
              onPressed: () => context.pushNamed(Routes.tutorial.name),
              activated: viewModel.activateNextButtonInDuration,
              label: '기간 설정 완료',
            ),
          ),
        ],
      ),
    );
  }
}
