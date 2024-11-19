import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/widgets/custom_text_field.dart';
import '../onboarding_state.dart';
import '../onboarding_view_model.dart';
import '../widgets/check_icon_widget.dart';
import '../widgets/onboarding_bottom_button.dart';
import '../widgets/onboarding_layout.dart';
import '../widgets/onboarding_top_widget.dart';
import '../widgets/suggested_duration_widget.dart';

Color shadowColor = const Color(0xffA6C1EE).withOpacity(0.15);

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

    return OnboardingLayout(
      onPressedBackButton: () => context.go('/home'),
      topWidget: OnboardingTopWidget(
        title: '이루고 싶은 목표는\n무엇인가요?',
        text: '님이 목표에 한 발짝 더\n가까워질 수 있도록 도와드릴게요!',
        boldText: state.userName,
      ),
      content: Expanded(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 3.0, bottom: 10.0, top: 16.0),
                    child: Text(
                      '이루고 싶은 목표를 적어주세요',
                      style: LuckitTypos.suitR16,
                    ),
                  ),
                  CustomTextField(
                    fieldHeight: 52.0,
                    hintText: '예) 매일 30분씩 어떤 공부든 하기',
                    enabled: viewModel.enableGoalInputField,
                    onChanged: (String text) =>
                        viewModel.onChangedGoalTextField(text: text),
                    fillColor: LuckitColors.white,
                    enabledBorderColor: LuckitColors.gray40,
                    focusedBorderColor: LuckitColors.main,
                    textInputType: TextInputType.text,
                    textStyle: LuckitTypos.suitR16.copyWith(
                      height: 0.0
                    ),
                    hintTextStyle: LuckitTypos.suitR16.copyWith(
                      color: LuckitColors.gray40,
                      height: 0.0
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 3.0, bottom: 10.0, top: 44.0),
                    child: Text(
                      '아직 고민 중이시라면, 이런 목표에 도전해보세요!',
                      style: LuckitTypos.suitR16,
                    ),
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
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomButton: OnboardingBottomButton(
        onPressed: () => context.pushNamed('/onboarding/duration'),
        activated: viewModel.activateNextButtonInGoal,
      ),
    );
  }
}

class GoalSuggestionWidget extends ConsumerWidget {
  final int index;
  final GoalSuggestionModel model;
  final VoidCallback onPressedCheck;

  const GoalSuggestionWidget({
    required this.index,
    required this.model,
    required this.onPressedCheck,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final OnboardingState state = ref.watch(onboardingViewModelProvider);
    final bool isChecked = state.selectedSuggestion == index;

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.only(
          left: 12.0, right: 12.0, top: 14.0, bottom: 8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        color: LuckitColors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 10.0,
            color: shadowColor,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.suggestedGoal,
                style: LuckitTypos.suitSB16.copyWith(
                  color: isChecked ? LuckitColors.main : LuckitColors.gray40,
                ),
              ),
              const SizedBox(height: 8.0),
              SuggestedDurationWidget(
                isChecked: isChecked,
                duration: model.suggestedDuration,
              ),
            ],
          ),
          CheckIconWidget(
            isChecked: index == state.selectedSuggestion,
            onPressed: onPressedCheck,
          ),
        ],
      ),
    );
  }
}
