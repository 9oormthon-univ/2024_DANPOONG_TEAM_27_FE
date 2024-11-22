import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../routes/routes.dart';
import '../../theme/luckit_colors.dart';
import '../common/widgets/rounded_text_button_widget.dart';
import '../onboarding/widgets/am_pm_select_widget.dart';
import '../onboarding/widgets/birth_input_widget.dart';
import '../onboarding/widgets/onboarding_bottom_button.dart';
import '../onboarding/widgets/onboarding_date_input_row_widget.dart';
import '../onboarding/widgets/onboarding_description_text_widget.dart';
import '../onboarding/widgets/onboarding_top_widget.dart';
import 'profile_state.dart';
import 'profile_view_model.dart';

class ProfileEditView extends ConsumerStatefulWidget {
  const ProfileEditView({super.key});

  @override
  ConsumerState<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends ConsumerState<ProfileEditView> {
  late TextEditingController yearController;
  late TextEditingController monthController;
  late TextEditingController dayController;
  late TextEditingController hourController;
  late TextEditingController minuteController;

  @override
  void initState() {
    super.initState();
    final ProfileState state = ref.read(profileViewModelProvider);
    yearController = TextEditingController(text: state.year);
    monthController = TextEditingController(text: state.month);
    dayController = TextEditingController(text: state.day);
    hourController = TextEditingController(text: state.hour);
    minuteController = TextEditingController(text: state.minute);
  }

  @override
  void dispose() {
    yearController.dispose();
    monthController.dispose();
    dayController.dispose();
    hourController.dispose();
    minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ProfileState state = ref.watch(profileViewModelProvider);
    final ProfileViewModel viewModel =
        ref.read(profileViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: LuckitColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 72.0),
                  const OnboardingTopWidget(
                    title: '내 정보 수정',
                    text: '수정할 정보를 입력해주세요.',
                    boldText: '',
                    showShadow: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const OnboardingDescriptionTextWidget(
                            text: '성별', topPadding: 0.0),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: RoundedTextButtonWidget(
                                isSelected: state.gender == '남성',
                                label: '남성',
                                onPressed: () =>
                                    viewModel.onTapGenderButton(label: '남성'),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: RoundedTextButtonWidget(
                                isSelected: state.gender == '여성',
                                label: '여성',
                                onPressed: () =>
                                    viewModel.onTapGenderButton(label: '여성'),
                              ),
                            ),
                          ],
                        ),
                        const OnboardingDescriptionTextWidget(
                          text: '생년월일',
                          topPadding: 48.0,
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: RoundedTextButtonWidget(
                                    isSelected: state.solarOrLunar == '양력',
                                    label: '양력',
                                    onPressed: () => viewModel
                                        .onTapSolarOrLunarButton(label: '양력'),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: RoundedTextButtonWidget(
                                    isSelected: state.solarOrLunar == '음력',
                                    label: '음력',
                                    onPressed: () => viewModel
                                        .onTapSolarOrLunarButton(label: '음력'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            OnboardingDateInputRowWidget(
                              yearController: yearController,
                              monthController: monthController,
                              dayController: dayController,
                              dayErrorText: viewModel.dayErrorText,
                              monthErrorText: viewModel.monthErrorText,
                              yearErrorText: viewModel.yearErrorText,
                              onChangedDay: (String value) =>
                                  viewModel.onChangedDay(value: value),
                              onChangedMonth: (String value) =>
                                  viewModel.onChangedMonth(value: value),
                              onChangedYear: (String value) =>
                                  viewModel.onChangedYear(value: value),
                            ),
                          ],
                        ),
                        const OnboardingDescriptionTextWidget(
                          text: '태어난 시간',
                          topPadding: 48.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: AmPmSelectWidget(
                                leftPadding: false,
                                isAm: state.isAm,
                                isPm: !state.isAm,
                                onPressedAm: () =>
                                    viewModel.toggleAm(current: state.isAm),
                                onPressedPm: () =>
                                    viewModel.toggleAm(current: state.isAm),
                                unknown: state.unknownTime,
                                onPressedUnknown: () =>
                                    viewModel.toggleUnknown(
                                        currentUnknown: state.unknownTime),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: BirthInputWidget(
                                hourController: hourController,
                                minuteController: minuteController,
                                padding: false,
                                enabled: !state.unknownTime,
                                onChangedHour: (String value) =>
                                    viewModel.onChangedHour(value: value),
                                onChangedMinute: (String value) =>
                                    viewModel.onChangedMinute(value: value),
                                hourErrMsg: viewModel.hourErrorText,
                                minuteErrMsg: viewModel.minuteErrorText,
                              ),
                            ),
                          ],
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
              onPressed: () => context.goNamed(Routes.profile.name),
              activated: viewModel.activateEditButton,
            ),
          ),
        ],
      ),
    );
  }
}
