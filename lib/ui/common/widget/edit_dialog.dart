import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class EditDialog extends StatefulWidget {
  final String buttonText;
  final String title;
  final String? content;

  const EditDialog(
      {required this.buttonText, required this.title, super.key, this.content});

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.content ?? '');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: LuckitTypos.suitSB16
                          .copyWith(color: LuckitColors.gray80),
                    ),
                    const SizedBox(height: 17),
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: '할 일을 적어주세요',
                        hintStyle: LuckitTypos.suitR12
                            .copyWith(color: LuckitColors.gray40),
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        '취소',
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
                      onPressed: () {
                        final String text = controller.text;
                        if (text.isNotEmpty) {
                          Navigator.pop(context, text);
                        }
                      },
                      child: Text(widget.buttonText,
                          style: LuckitTypos.suitR16
                              .copyWith(color: LuckitColors.main)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
