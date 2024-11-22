import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/routes.dart';
import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/widgets/rounded_text_button_widget.dart';
import '../onboarding_state.dart';
import '../onboarding_view_model.dart';
import '../widgets/birth_time_input_container_widget.dart';
import '../widgets/check_icon_widget.dart';
import '../widgets/error_text_widget.dart';
import '../widgets/onboarding_app_bar.dart';
import '../widgets/onboarding_bottom_button.dart';
import '../widgets/onboarding_date_input_row_widget.dart';
import '../widgets/onboarding_description_text_widget.dart';
import '../widgets/onboarding_top_widget.dart';

class OnboardingBirthView extends ConsumerWidget {
  const OnboardingBirthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final OnboardingViewModel viewModel =
        ref.read(onboardingViewModelProvider.notifier);
    final OnboardingState state = ref.watch(onboardingViewModelProvider);

    return Scaffold(
      appBar: const OnboardingAppBar(),
      backgroundColor: LuckitColors.background,
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const OnboardingTopWidget(
                    title: '정보를 입력해주세요',
                    text: '입력 정보를 기반으로\n운세와 맞춤 목표를 추천드릴게요!',
                    boldText: '',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: <Widget>[
                        _buildGender(state, viewModel),
                        _buildBirthDate(state, viewModel),
                      ],
                    ),
                  ),
                  _buildBirthTime(state, viewModel),
                ],
              ),
            ),
          ),
          AgreeRowWidget(
            isChecked: state.agree,
            onPressed: viewModel.onPressedAgree,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: OnboardingBottomButton(
              onPressed: () => context.pushNamed(Routes.goal.name),
              activated: viewModel.activateNextButtonInBirth,
              label: '입력 완료',
            ),
          ),
        ],
      ),
    );
  }

  Column _buildBirthTime(
    OnboardingState state,
    OnboardingViewModel viewModel,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: OnboardingDescriptionTextWidget(
              text: '태어난 시간',
              topPadding: 28.0,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 24.0),
                        Expanded(
                          child: RoundedTextButtonWidget(
                            isSelected: state.dayPeriod == DayPeriod.am,
                            label: 'AM',
                            onPressed: () => viewModel.onPressedDayPeriod(
                              dayPeriod: DayPeriod.am,
                            ),
                            isActivated: !state.dontKnow,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: RoundedTextButtonWidget(
                            isSelected: state.dayPeriod == DayPeriod.pm,
                            label: 'PM',
                            onPressed: () => viewModel.onPressedDayPeriod(
                              dayPeriod: DayPeriod.pm,
                            ),
                            isActivated: !state.dontKnow,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 12),
                        CheckIconWidget(
                          isChecked: state.dontKnow,
                          onPressed: viewModel.onPressedDontKnow,
                          size: 16.0,
                        ),
                        Text(
                          '태어난 시간을 알지 못합니다',
                          style: LuckitTypos.suitR10.copyWith(
                            color: LuckitColors.gray80,
                            height: 0.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: 40.0,
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: LuckitColors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: state.dontKnow
                                ? LuckitColors.gray10
                                : LuckitColors.gray20,
                          ),
                        ),
                        child: BirthTimeInputContainerWidget(
                          enabled: !state.dontKnow,
                          onChangedHour: (String value) =>
                              viewModel.onChangedBirthHour(value: value),
                          onChangedMinute: (String value) =>
                              viewModel.onChangedBirthMinute(value: value),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ErrorTextWidget(
                          errorTexts: <String?, TextAlign>{
                            viewModel.birthHourErrorText: TextAlign.start,
                            viewModel.birthMinuteErrorText: TextAlign.end,
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  Column _buildBirthDate(
    OnboardingState state,
    OnboardingViewModel viewModel,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const OnboardingDescriptionTextWidget(
            text: '생년월일',
            topPadding: 48.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RoundedTextButtonWidget(
                  isSelected: state.birthType == BirthType.solar,
                  label: '양력',
                  onPressed: () => viewModel.onPressedBirthType(
                    birthType: BirthType.solar,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: RoundedTextButtonWidget(
                  isSelected: state.birthType == BirthType.lunar,
                  label: '음력',
                  onPressed: () => viewModel.onPressedBirthType(
                    birthType: BirthType.lunar,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          OnboardingDateInputRowWidget(
            onChangedYear: (String value) =>
                viewModel.onChangedBirthYear(value: value),
            onChangedMonth: (String value) =>
                viewModel.onChangedBirthMonth(value: value),
            onChangedDay: (String value) =>
                viewModel.onChangedBirthDay(value: value),
            yearErrorText: viewModel.birthYearErrorText,
            monthErrorText: viewModel.birthMonthErrorText,
            dayErrorText: viewModel.birthDayErrorText,
          ),
        ],
      );

  Column _buildGender(
    OnboardingState state,
    OnboardingViewModel viewModel,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const OnboardingDescriptionTextWidget(
            text: '성별',
            topPadding: 38.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RoundedTextButtonWidget(
                  isSelected: state.gender == Gender.man,
                  label: '남성',
                  onPressed: () => viewModel.onPressedGender(
                    gender: Gender.man,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: RoundedTextButtonWidget(
                  isSelected: state.gender == Gender.woman,
                  label: '여성',
                  onPressed: () => viewModel.onPressedGender(
                    gender: Gender.woman,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}

class AgreeRowWidget extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onPressed;

  const AgreeRowWidget({
    required this.isChecked,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CheckIconWidget(
                  isChecked: isChecked,
                  onPressed: onPressed,
                  size: 24.0,
                ),
                Text(
                  '(필수) 운세정보 수집/이용 동의',
                  style: LuckitTypos.suitR14.copyWith(
                    color: LuckitColors.gray60,
                    height: 0.0,
                  ),
                ),
              ],
            ),
            Container(
              //width: 44,
              height: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(color: LuckitColors.gray10),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 2.0,
              ),
              child: Text(
                '약관보기',
                style: LuckitTypos.suitR10.copyWith(
                  color: LuckitColors.gray80,
                  height: 0.0,
                ),
              ),
            ),
          ],
        ),
      );
}
