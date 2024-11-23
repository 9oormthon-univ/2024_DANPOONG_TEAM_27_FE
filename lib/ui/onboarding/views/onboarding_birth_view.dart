import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/routes.dart';
import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/widgets/rounded_text_button_widget.dart';
import '../onboarding_state.dart';
import '../onboarding_view_model.dart';
import '../widgets/am_pm_select_widget.dart';
import '../widgets/birth_input_widget.dart';
import '../widgets/check_icon_widget.dart';
import '../widgets/onboarding_app_bar.dart';
import '../widgets/onboarding_bottom_button.dart';
import '../widgets/onboarding_date_input_row_widget.dart';
import '../widgets/onboarding_description_text_widget.dart';
import '../widgets/onboarding_top_widget.dart';
import '../widgets/unknown_time_widget.dart';

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
      body: Stack(
        children: [
          Column(
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
          Positioned(
            left: 0.0,
            top: 560.0,
            child: UnknownTimeWidget(
              leftPadding: true,
              isChecked: state.dontKnow,
              onPressed: viewModel.onPressedDontKnow,
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
                child: AmPmSelectWidget(
                  isAm: state.dayPeriod == DayPeriod.am,
                  isPm: state.dayPeriod == DayPeriod.pm,
                  onPressedAm: () => viewModel.onPressedDayPeriod(
                    dayPeriod: DayPeriod.am,
                  ),
                  onPressedPm: () => viewModel.onPressedDayPeriod(
                    dayPeriod: DayPeriod.pm,
                  ),
                  unknown: state.dontKnow,
                  onPressedUnknown: () => viewModel.onPressedDontKnow(),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: BirthInputWidget(
                    hourErrMsg: viewModel.birthHourErrorText,
                    minuteErrMsg: viewModel.birthMinuteErrorText,
                    enabled: !state.dontKnow,
                    onChangedHour: (String value) =>
                        viewModel.onChangedBirthHour(value: value),
                    onChangedMinute: (String value) =>
                        viewModel.onChangedBirthMinute(value: value),
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
                  isSelected: state.gender == GenderType.male,
                  label: '남성',
                  onPressed: () => viewModel.onPressedGender(
                    gender: GenderType.male,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: RoundedTextButtonWidget(
                  isSelected: state.gender == GenderType.female,
                  label: '여성',
                  onPressed: () => viewModel.onPressedGender(
                    gender: GenderType.female,
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
                style: LuckitTypos.suitR14.copyWith(
                  color: LuckitColors.gray60,
                  height: 0.0,
                ),
              ),
            ),
          ],
        ),
      );
}
