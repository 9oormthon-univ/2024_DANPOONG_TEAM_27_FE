import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../onboarding_state.dart';
import '../onboarding_view_model.dart';
import '../widgets/check_icon_widget.dart';
import '../widgets/onboarding_bottom_button.dart';
import '../widgets/onboarding_layout.dart';
import '../widgets/onboarding_top_widget.dart';
import 'onboarding_duration_view.dart';

class OnboardingBirthView extends ConsumerWidget {
  const OnboardingBirthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final OnboardingViewModel viewModel =
        ref.read(onboardingViewModelProvider.notifier);
    final OnboardingState state = ref.watch(onboardingViewModelProvider);

    return OnboardingLayout(
      backgroundColor: LuckitColors.white,
      onPressedBackButton: () => context.pop(),
      topWidget: const OnboardingTopWidget(
        showShadow: false,
        title: '정보를 입력해주세요',
        text: '입력 정보를 기반으로\n운세와 맞춤 목표를 추천드릴게요!',
        boldText: '',
      ),
      content: Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildGender(state, viewModel),
                _buildBirthDate(state, viewModel),
                _buildBirthTime(state, viewModel),
              ],
            ),
          ),
        ),
      ),
      bottomButton: Column(
        children: <Widget>[
          // TODO(dodo): 여기 예쁘게 만들기
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CheckIconWidget(
                    isChecked: state.agree,
                    onPressed: viewModel.onPressedAgree,
                    size: 24.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    '(필수) 운세정보 수집/이용 동의',
                    style: LuckitTypos.suitR14.copyWith(
                      color: LuckitColors.gray60,
                    ),
                  ),
                ],
              ),
              // 아 너무 힘드러요
              const Text('약관보기'),
            ],
          ),
          const SizedBox(height: 12.0),
          OnboardingBottomButton(
            onPressed: () => context.goNamed('/home'),
            activated: viewModel.activateNextButtonInBirth,
            label: '입력완료',
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
            padding: EdgeInsets.only(left: 4.0, top: 28, bottom: 10),
            child: Text(
              '태어난 시간',
              style: LuckitTypos.suitR16,
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
                        CheckIconWidget(
                          isChecked: state.dontKnow,
                          onPressed: () => viewModel.onPressedDontKnow(),
                          size: 24.0,
                        ),
                        const SizedBox(width: 2.0),
                        Text(
                          '태어난 시간을 알지 못합니다',
                          style: LuckitTypos.suitR10
                              .copyWith(color: LuckitColors.gray80),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0)
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topCenter,
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
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: BirthTimeInputField(
                              enabled: !state.dontKnow,
                              hintText: 'HH',
                              onChanged: (String value) =>
                                  viewModel.onChangedBirthHour(
                                value: value,
                              ),
                            ),
                          ),
                          Text(
                            ':',
                            style: LuckitTypos.suitR20.copyWith(
                              color: LuckitColors.gray80,
                            ),
                          ),
                          Expanded(
                            child: BirthTimeInputField(
                              enabled: !state.dontKnow,
                              hintText: 'MM',
                              onChanged: (String value) =>
                                  viewModel.onChangedBirthMinute(
                                value: value,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ErrorTextWidget(errorTexts: <String?, TextAlign>{
                        viewModel.birthHourErrorText: TextAlign.start,
                        viewModel.birthMinuteErrorText: TextAlign.end,
                      }),
                    ),
                  ],
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
          const Padding(
            padding: EdgeInsets.only(left: 4.0, top: 48, bottom: 10),
            child: Text(
              '생년월일',
              style: LuckitTypos.suitR16,
            ),
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
          OnboardingDurationInputWidget(
            onChangedYear: (String value) => viewModel.onChangedBirthYear(
              value: value,
            ),
            onChangedMonth: (String value) => viewModel.onChangedBirthMonth(
              value: value,
            ),
            onChangedDay: (String value) => viewModel.onChangedBirthDay(
              value: value,
            ),
            yearErrorText: viewModel.birthYearErrorText,
            monthErrorText: viewModel.birthMonthErrorText,
            dayErrorText: viewModel.birthDayErrorText,
          ),
        ],
      );

  Column _buildGender(OnboardingState state, OnboardingViewModel viewModel) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 4.0, top: 38, bottom: 10),
            child: Text(
              '성별',
              style: LuckitTypos.suitR16,
            ),
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

class BirthTimeInputField extends StatelessWidget {
  final bool enabled;
  final String hintText;
  final Function(String) onChanged;

  const BirthTimeInputField({
    required this.enabled,
    required this.hintText,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        child: TextField(
          enabled: enabled,
          onChanged: onChanged,
          style: LuckitTypos.suitR20.copyWith(
            height: 0.0,
            color: LuckitColors.gray80,
          ),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            fillColor: LuckitColors.white,
            filled: true,
            hintStyle: LuckitTypos.suitR20.copyWith(
              height: 0.0,
              color: LuckitColors.gray20,
            ),
          ),
          cursorColor: LuckitColors.gray80,
          cursorWidth: 1.0,
        ),
      );
}

class ErrorTextWidget extends StatelessWidget {
  final Map<String?, TextAlign> errorTexts;

  const ErrorTextWidget({
    required this.errorTexts,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 20.0,
        child: _showErrorText(),
      );

  Widget _showErrorText() {
    final TextStyle errorTextStyle = LuckitTypos.suitR10.copyWith(
      color: LuckitColors.error,
    );

    for (final MapEntry<String?, TextAlign> entry in errorTexts.entries) {
      if (entry.key != null) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Text(
            entry.key!,
            style: errorTextStyle,
            textAlign: entry.value,
          ),
        );
      }
    }
    return const SizedBox.shrink();
  }
}

class RoundedTextButtonWidget extends StatelessWidget {
  final bool isSelected;
  final bool isActivated;
  final String label;
  final VoidCallback onPressed;
  final double height;

  const RoundedTextButtonWidget({
    required this.isSelected,
    required this.label,
    required this.onPressed,
    this.isActivated = true,
    this.height = 40.0,
    super.key,
  });

  Color get backgroundColor =>
  !isActivated?LuckitColors.gray10:
      (isSelected ? LuckitColors.main : LuckitColors.gray10);

  Color get foregroundColor => !isActivated?LuckitColors.gray40:
  (isSelected ? LuckitColors.white : LuckitColors.gray60);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            alignment: Alignment.center,
            padding: EdgeInsets.zero,
            backgroundColor: backgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: LuckitTypos.suitR20.copyWith(
              height: 0.0,
              color: foregroundColor,
            ),
          ),
        ),
      );
}
