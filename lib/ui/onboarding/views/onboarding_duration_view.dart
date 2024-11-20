import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/consts/assets.dart';
import '../../common/widgets/custom_text_field.dart';
import '../onboarding_state.dart';
import '../onboarding_view_model.dart';
import '../widgets/error_text_widget.dart';
import '../widgets/onboarding_bottom_button.dart';
import '../widgets/onboarding_date_input_field_widget.dart';
import '../widgets/onboarding_layout.dart';
import '../widgets/onboarding_top_widget.dart';
import '../widgets/suggested_duration_widget.dart';
import 'onboarding_birth_view.dart';
import 'onboarding_goal_view.dart';

class OnboardingDurationView extends ConsumerWidget {
  const OnboardingDurationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final OnboardingViewModel viewModel =
        ref.read(onboardingViewModelProvider.notifier);
    final OnboardingState state = ref.watch(onboardingViewModelProvider);

    return OnboardingLayout(
      onPressedBackButton: () => context.pop(),
      topWidget: OnboardingTopWidget(
        title: '목표에 도전할\n기간을 정해주세요',
        text: '과 목표 달성을 위해 함께\n달려갈 시간을 입력해주세요!',
        boldText: 'LUCKIT',
        message: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
          child: Row(
            children: <Widget>[
              SvgPicture.asset(Assets.warning),
              const SizedBox(width: 4.0),
              Text(
                '목표는 최소 14일 이상 설정해야 해요.',
                style: LuckitTypos.suitR12.copyWith(
                  color: LuckitColors.error,
                  height: 0.0,
                ),
              ),
            ],
          ),
        ),
      ),
      content: Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 3.0, bottom: 10.0, top: 16.0),
                  child: Text(
                    '${state.userName}님이 도전할 목표예요',
                    style: LuckitTypos.suitR16,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    color: LuckitColors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: shadowColor, blurRadius: 10.0)
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 12.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          state.goal,
                          style: LuckitTypos.suitR16.copyWith(
                            color: LuckitColors.main,
                          ),
                        ),
                      ),
                      if (state.suggestedDuration.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: SuggestedDurationWidget(
                            isChecked: true,
                            duration: state.suggestedDuration,
                          ),
                        ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 4.0, bottom: 10.0, top: 48.0),
                  child: Text(
                    '목표를 시작할 날짜를 입력해주세요',
                    style: LuckitTypos.suitR16,
                  ),
                ),
                OnboardingDurationInputWidget(
                  onChangedYear: (String value) => viewModel.onChangedStartYear(
                    value: value,
                  ),
                  onChangedMonth: (String value) =>
                      viewModel.onChangedStartMonth(
                    value: value,
                  ),
                  onChangedDay: (String value) => viewModel.onChangedStartDay(
                    value: value,
                  ),
                  yearErrorText: viewModel.startYearErrorText,
                  monthErrorText: viewModel.startMonthErrorText,
                  dayErrorText: viewModel.startDayErrorText,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 4.0, bottom: 10.0, top: 32.0),
                  child: Text(
                    '목표를 종료할 날짜를 입력해주세요',
                    style: LuckitTypos.suitR16,
                  ),
                ),
                OnboardingDurationInputWidget(
                  onChangedYear: (String value) => viewModel.onChangedEndYear(
                    value: value,
                  ),
                  onChangedMonth: (String value) => viewModel.onChangedEndMonth(
                    value: value,
                  ),
                  onChangedDay: (String value) => viewModel.onChangedEndDay(
                    value: value,
                  ),
                  yearErrorText: viewModel.endYearErrorText,
                  monthErrorText: viewModel.endMonthErrorText,
                  dayErrorText: viewModel.endDayErrorText,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomButton: OnboardingBottomButton(
        onPressed: () => context.pushNamed('/onboarding/birth'),
        activated: viewModel.activateNextButtonInDuration,
        label: viewModel.activateNextButtonInDuration ? '운세 정보 입력' : '설정완료',
      ),
    );
  }
}

class OnboardingDurationInputWidget extends StatelessWidget {
  final Function(String)? onChangedYear;
  final Function(String)? onChangedMonth;
  final Function(String)? onChangedDay;

  final String? yearErrorText;
  final String? monthErrorText;
  final String? dayErrorText;

  const OnboardingDurationInputWidget({
    super.key,
    this.onChangedYear,
    this.onChangedMonth,
    this.onChangedDay,
    this.yearErrorText,
    this.monthErrorText,
    this.dayErrorText,
  });

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                OnboardingDateInputField(
                  hintText: 'YYYY',
                  onChanged: onChangedYear,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ErrorTextWidget(
                    errorTexts: <String?, TextAlign>{
                      yearErrorText: TextAlign.start,
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: OnboardingDateInputField(
                        hintText: 'MM',
                        onChanged: onChangedMonth,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OnboardingDateInputField(
                        hintText: 'DD',
                        onChanged: onChangedDay,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ErrorTextWidget(
                    errorTexts: <String?, TextAlign>{
                      monthErrorText: TextAlign.start,
                      dayErrorText: TextAlign.end,
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      );
}
