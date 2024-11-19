import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class DeleteDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelText;
  final String confirmText;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;

  const DeleteDialog({
    Key? key,
    required this.title,
    required this.content,
    this.cancelText = '취소',
    this.confirmText = '삭제하기',
    this.onCancel,
    this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.only(top: 44),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Column(
                children: [
                  Text(
                    title,
                    style: LuckitTypos.suitSB16,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    content,
                    style: LuckitTypos.suitR16
                      .copyWith(color: LuckitColors.gray80),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: onCancel ?? () => Navigator.pop(context),
                    child: Text(
                      cancelText,
                      style: LuckitTypos.suitR16
                        .copyWith(color: LuckitColors.gray80),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.black12,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: onConfirm ?? () => Navigator.pop(context),
                    child: Text(
                      confirmText,
                      style: LuckitTypos.suitR16
                        .copyWith(color: LuckitColors.error),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
