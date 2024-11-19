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
                    hintTextStyle: LuckitTypos.suitR12.copyWith(
                      color: LuckitColors.gray40,
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
                    return GoalSuggestion(
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
        onPressed: () => viewModel.onTapNextButtonInGoal,
        activated: viewModel.activateNextButtonInGoal,
      ),
    );
  }
}

class OnboardingLayout extends StatelessWidget {
  final VoidCallback onPressedBackButton;
  final Widget topWidget;
  final Widget content;
  final Widget bottomButton;

  const OnboardingLayout({
    required this.onPressedBackButton,
    required this.topWidget,
    required this.content,
    required this.bottomButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: LuckitColors.background,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: LuckitColors.white,
        leading: IconButton(
          onPressed: onPressedBackButton,
          icon: SvgPicture.asset(
            Assets.arrowLeft,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[topWidget, content, bottomButton],
      ),
    );
}

class OnboardingBottomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool activated;

  const OnboardingBottomButton({
    required this.onPressed,
    required this.activated,
    super.key,
  });

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: activated ? onPressed : null,
        style: TextButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width, 64.0),
          backgroundColor: activated ? LuckitColors.main : LuckitColors.gray20,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
        child: Text(
          '기간 설정하기',
          style: LuckitTypos.suitR20.copyWith(
            color: activated ? LuckitColors.white : LuckitColors.gray80,
          ),
        ),
      );
}

class CheckIcon extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onPressed;

  const CheckIcon(
      {required this.isChecked, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        icon: Container(
          // margin: const EdgeInsets.all(2.67),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isChecked ? LuckitColors.main : LuckitColors.gray20,
          ),
          child: Center(
            child: SvgPicture.asset(
              Assets.done,
              width: 32,
              height: 32,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      );
}

class OnboardingTopWidget extends StatelessWidget {
  final String title;
  final String text;
  final String boldText;
  final bool showShadow;

  const OnboardingTopWidget({
    required this.title,
    required this.text,
    required this.boldText,
    this.showShadow = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: LuckitColors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
          boxShadow: showShadow
              ? <BoxShadow>[
                  BoxShadow(
                    blurRadius: 10.0,
                    color: shadowColor,
                  )
                ]
              : null,
        ),
        width: double.infinity,
        padding: const EdgeInsets.only(
            left: 24.0, right: 24.0, top: 12.0, bottom: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: LuckitTypos.suitEB32.copyWith(
                color: LuckitColors.main,
              ),
            ),
            const SizedBox(height: 8.0),
            Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: boldText,
                    style: LuckitTypos.suitSB16,
                  ),
                  TextSpan(
                    text: text,
                    style: LuckitTypos.suitR16,
                  ),
                ],
              ),
            )
          ],
        ),
      );
}

class GoalSuggestion extends ConsumerWidget {
  final int index;
  final GoalSuggestionModel model;
  final VoidCallback onPressedCheck;

  const GoalSuggestion({
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
              Container(
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: LuckitColors.gray10,
                ),
                child: Text(
                  '추천 기간 ${model.suggestedDuration}',
                  style: LuckitTypos.suitR10.copyWith(
                    color:
                        isChecked ? LuckitColors.gray60 : LuckitColors.gray40,
                  ),
                ),
              ),
            ],
          ),
          CheckIcon(
            isChecked: index == state.selectedSuggestion,
            onPressed: onPressedCheck,
          ),
        ],
      ),
    );
  }
}
