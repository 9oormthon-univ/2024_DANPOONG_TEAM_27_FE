import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          height: state.isGoalEditing ? 128 : 65,
          child: state.isGoalEditing
              ? IsGoalEditing()
              : const DefaultGoalStatusBar(),
        ),
      ),
    );
  }
}

class IsGoalEditing extends ConsumerWidget {
  IsGoalEditing({
    super.key,
  });

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  void _formatDate({
    required String input,
    required TextEditingController controller,
  }) {
    // 숫자만 남기기
    final String cleanedInput = input.replaceAll(RegExp('[^0-9]'), '');
    String formatted = cleanedInput;

    // 입력 길이에 따라 포맷 추가
    if (cleanedInput.length >= 6) {
      formatted =
          '''${cleanedInput.substring(0, 4)}.${cleanedInput.substring(4, 6)}''';
    } else if (cleanedInput.length >= 5) {
      formatted =
          '''${cleanedInput.substring(0, 4)}.${cleanedInput.substring(4, cleanedInput.length)}''';
    }
    if (cleanedInput.length >= 7) {
      formatted += '.${cleanedInput.substring(6, cleanedInput.length)}';
    }

    controller.value = TextEditingValue(
      text: formatted,
      selection:
          TextSelection.collapsed(offset: formatted.length), // 커서를 맨 뒤로 이동
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);
    final InputDecoration dateInputDecoration = InputDecoration(
      hintText: 'YYYY MM DD',
      hintStyle: LuckitTypos.suitR10.copyWith(color: LuckitColors.gray40),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      counterText: '',
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
                      onTapOutside: (_) {
                        FocusScope.of(context).unfocus();
                      },
                      cursorColor: LuckitColors.transparent,
                      style: LuckitTypos.suitR10
                          .copyWith(color: LuckitColors.white),
                      decoration: dateInputDecoration,
                      controller: _startDateController,
                      onChanged: (String input) {
                        _formatDate(
                          input: input,
                          controller: _startDateController,
                        );
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      maxLength: 8,
                      keyboardType: TextInputType.number,
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
                      onTapOutside: (_) {
                        FocusScope.of(context).unfocus();
                      },
                      cursorColor: LuckitColors.transparent,
                      style: LuckitTypos.suitR10
                          .copyWith(color: LuckitColors.white),
                      controller: _endDateController,
                      onChanged: (String input) {
                        _formatDate(
                          input: input,
                          controller: _endDateController,
                        );
                      },
                      maxLength: 8,
                      decoration: dateInputDecoration,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
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
                    viewModel.toggleGoalEdit(isCurrentEditing: true);
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
            Text(
              '2024.11.15 - 2024.12.15',
              style: LuckitTypos.suitR12.copyWith(
                color: LuckitColors.gray20,
              ),
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
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '한 달 안에 긍정적인 사람 되어보기',
              style: LuckitTypos.suitSB12.copyWith(
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
