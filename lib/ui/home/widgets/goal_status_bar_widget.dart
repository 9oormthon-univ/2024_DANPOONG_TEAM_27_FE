import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/loading_status.dart';
import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/consts/assets.dart';
import '../home_state.dart';
import '../home_view_model.dart';

class GoalStatusBarWidget extends ConsumerWidget {
  const GoalStatusBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeState state = ref.watch(homeViewModelProvider);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: state.isGoalEditing
              ? const EdgeInsets.fromLTRB(24, 16, 16, 24)
              : const EdgeInsets.fromLTRB(23, 8, 16, 10),
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 15,
                color: const Color(0xFF2F56A5).withOpacity(0.15),
              )
            ],
            borderRadius: BorderRadius.circular(16),
            color: LuckitColors.white.withOpacity(0.1),
          ),
          height: state.isGoalEditing ? 128 : 82,
          child: state.isGoalEditing
              ? const IsGoalEditing()
              : const DefaultGoalStatusBar(),
        ),
      ),
    );
  }
}

class IsGoalEditing extends ConsumerStatefulWidget {
  const IsGoalEditing({
    super.key,
  });

  @override
  ConsumerState<IsGoalEditing> createState() => _IsGoalEditingState();
}

class _IsGoalEditingState extends ConsumerState<IsGoalEditing> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();

  @override
  void initState() {
    final HomeState state = ref.read(homeViewModelProvider);
    _startDateController.text = state.editingStartDate;
    _endDateController.text = state.editingEndDate;
    _goalController.text = state.editingGoal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeState state = ref.read(homeViewModelProvider);
    final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);

    ref.listen(
      homeViewModelProvider
          .select((HomeState value) => value.editCurrentGoalLoadingstatus),
      (LoadingStatus? prev, LoadingStatus cur) {
        if (cur == LoadingStatus.success) {
          viewModel.toggleGoalEdit(isCurrentEditing: true);
        }
      },
    );

    final InputDecoration dateInputDecoration = InputDecoration(
      hintText: 'YYYY MM DD',
      hintStyle: LuckitTypos.suitR10.copyWith(color: LuckitColors.gray40),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      filled: true,
      fillColor: LuckitColors.main.withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: LuckitColors.inputBorder,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: LuckitColors.main,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: LuckitColors.inputBorder,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: LuckitColors.error,
        ),
      ),
    );
    final InputDecoration goalInputDecoration = InputDecoration(
      hintText: '수정할 목표를 입력해주세요',
      hintStyle: LuckitTypos.suitR10.copyWith(color: LuckitColors.gray40),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      filled: true,
      fillColor: LuckitColors.main.withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: LuckitColors.inputBorder,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: LuckitColors.main,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: LuckitColors.inputBorder,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: LuckitColors.error,
        ),
      ),
    );
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 82,
                    height: 28,
                    child: TextField(
                      controller: _startDateController,
                      onTapOutside: (_) {
                        FocusScope.of(context).unfocus();
                      },
                      cursorColor: LuckitColors.transparent,
                      style: LuckitTypos.suitR10
                          .copyWith(color: LuckitColors.white),
                      decoration: dateInputDecoration,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '-',
                      style: LuckitTypos.suitR12
                          .copyWith(color: LuckitColors.white),
                    ),
                  ),
                  SizedBox(
                    width: 82,
                    height: 28,
                    child: TextField(
                      controller: _endDateController,
                      onTapOutside: (_) {
                        FocusScope.of(context).unfocus();
                      },
                      cursorColor: LuckitColors.transparent,
                      style: LuckitTypos.suitR10
                          .copyWith(color: LuckitColors.white),
                      decoration: dateInputDecoration,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    viewModel.toggleGoalEdit(isCurrentEditing: true);
                  },
                  child: SizedBox(
                    height: 28,
                    width: 41,
                    child: Text(
                      '취소',
                      style: LuckitTypos.suitR12.copyWith(
                        color: LuckitColors.gray20,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    viewModel.editCurrentGoal(
                      startDateString: _startDateController.text,
                      endDateString: _endDateController.text,
                      editingGoal: _goalController.text,
                    );
                  },
                  child: SizedBox(
                    height: 28,
                    width: 41,
                    child: Text(
                      '완료',
                      style: LuckitTypos.suitR12.copyWith(
                        color: LuckitColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, right: 8),
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: _goalController,
              onTapOutside: (_) {
                FocusScope.of(context).unfocus();
              },
              cursorColor: LuckitColors.white,
              cursorWidth: 1,
              cursorHeight: 18,
              style: LuckitTypos.suitR12.copyWith(color: LuckitColors.white),
              decoration: goalInputDecoration,
            ),
          ),
        ),
      ],
    );
  }
}

class DefaultGoalStatusBar extends ConsumerWidget {
  const DefaultGoalStatusBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeState state = ref.watch(homeViewModelProvider);
    final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '수정님의 목표',
                  style: LuckitTypos.suitSB16.copyWith(
                    color: LuckitColors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '${state.formattedStartDate} - ${state.formattedEndDate}',
                  style: LuckitTypos.suitR12.copyWith(
                    color: LuckitColors.gray20,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                viewModel.toggleGoalButtons(
                    isCurrentOpen: state.isGoalButtonOpen);
              },
              child: SvgPicture.asset(
                width: 20,
                height: 20,
                Assets.verticalDots,
              ),
            ),
          ],
        ),
        const SizedBox(height: 11),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              state.currentGoal.name,
              style: LuckitTypos.suitSB16.copyWith(
                color: LuckitColors.gray20,
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  '완료한 미션 수',
                  style: LuckitTypos.suitR12.copyWith(
                    color: LuckitColors.gray20,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '1개',
                  style: LuckitTypos.suitSB12.copyWith(
                    color: LuckitColors.gray20,
                  ),
                ),
                const SizedBox(width: 7),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
