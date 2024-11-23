import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../domain/onboarding/model/suggestion_goal_model.dart';

import '../../../routes/routes.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/consts/assets.dart';
import '../../common/widgets/new_custom_text_field.dart';
import '../onboarding_state.dart';
import '../onboarding_view_model.dart';
import '../widgets/goal_suggestion_widget.dart';
import '../widgets/onboarding_app_bar.dart';
import '../widgets/onboarding_bottom_button.dart';
import '../widgets/onboarding_description_text_widget.dart';
import '../widgets/onboarding_top_widget.dart';

class OnboardingGoalView extends ConsumerStatefulWidget {
  final VoidCallback onNextPage;

  const OnboardingGoalView({required this.onNextPage, super.key});

  @override
  ConsumerState<OnboardingGoalView> createState() => _OnboardingGoalViewState();
}

class _OnboardingGoalViewState extends ConsumerState<OnboardingGoalView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onboardingViewModelProvider.notifier).getUserName();
      ref.read(onboardingViewModelProvider.notifier).getSuggestions();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OnboardingViewModel viewModel =
        ref.read(onboardingViewModelProvider.notifier);
    final OnboardingState state = ref.watch(onboardingViewModelProvider);

    if (state.suggestions.isNotEmpty) {
      _animationController.forward();
    }

    return Scaffold(
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
                    if (state.suggestions.isEmpty)
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        alignment: Alignment.center,
                        child: Transform.scale(
                          scale: 0.7,
                          child: Lottie.asset(
                            Assets.loading,
                            repeat: true,
                          ),
                        ),
                      ),
                    if (state.suggestions.isNotEmpty)
                      SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const OnboardingDescriptionTextWidget(
                              text: '아직 고민 중이시라면, 이런 목표에 도전해보세요!',
                              topPadding: 44.0,
                            ),
                            ...List.generate(state.suggestions.length, (index) {
                              final GoalModel model = state.suggestions[index];
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
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: OnboardingBottomButton(
              onPressed: widget.onNextPage,
              activated: viewModel.activateNextButtonInGoal,
              label: '목표 입력 완료',
            ),
          ),
        ],
      ),
    );
  }
}
