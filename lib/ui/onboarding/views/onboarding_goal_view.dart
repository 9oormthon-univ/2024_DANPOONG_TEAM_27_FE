import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/routes.dart';
import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/widgets/new_custom_text_field.dart';
import '../onboarding_state.dart';
import '../onboarding_view_model.dart';
import '../widgets/goal_suggestion_widget.dart';
import '../widgets/onboarding_app_bar.dart';
import '../widgets/onboarding_bottom_button.dart';
import '../widgets/onboarding_description_text_widget.dart';
import '../widgets/onboarding_top_widget.dart';

class OnboardingGoalView extends ConsumerStatefulWidget {
  const OnboardingGoalView({super.key});

  @override
  ConsumerState<OnboardingGoalView> createState() => _OnboardingGoalViewState();
}

class _OnboardingGoalViewState extends ConsumerState<OnboardingGoalView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onboardingViewModelProvider.notifier).getUserName();
      ref.read(onboardingViewModelProvider.notifier).getSuggestions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final OnboardingViewModel viewModel =
        ref.read(onboardingViewModelProvider.notifier);
    final OnboardingState state = ref.watch(onboardingViewModelProvider);

    return Scaffold(
      appBar: const OnboardingAppBar(),
      backgroundColor: LuckitColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          OnboardingTopWidget(
            title: '이루고 싶은 목표는\n무엇인가요?',
            text: '님이 목표에 한 발짝 더\n가까워질 수 있도록 도와드릴게요!',
            boldText: state.userName,
          ),
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const OnboardingDescriptionTextWidget(
                      text: '이루고 싶은 목표를 적어주세요',
                      topPadding: 16.0,
                    ),
                    NewCustomTextField(
                      height: 52.0,
                      hintText: '예) 매일 30분씩 어떤 공부든 하기',
                      enabled: viewModel.enableGoalInputField,
                      onChanged: (String text) =>
                          viewModel.onChangedGoalTextField(text: text),
                      textStyle: LuckitTypos.suitR16.copyWith(height: 0.0),
                      hintTextStyle: LuckitTypos.suitR16
                          .copyWith(color: LuckitColors.gray40, height: 0.0),
                    ),
                    const OnboardingDescriptionTextWidget(
                      text: '아직 고민 중이시라면, 이런 목표에 도전해보세요!',
                      topPadding: 44.0,
                    ),
                    ...state.suggestions
                        .asMap()
                        .entries
                        .map((MapEntry<int, GoalSuggestionModel> entry) {
                      final int index = entry.key;
                      final GoalSuggestionModel model = entry.value;
                      return GoalSuggestionWidget(
                        index: index,
                        model: model,
                        onPressedCheck: () =>
                            viewModel.onTapSuggestion(index: index),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: OnboardingBottomButton(
              onPressed: () => context.pushNamed(Routes.duration.name),
              activated: viewModel.activateNextButtonInGoal,
              label: '목표 입력 완료',
            ),
          ),
        ],
      ),
    );
  }
}
