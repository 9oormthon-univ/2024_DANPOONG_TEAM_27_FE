import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/widgets/bottom_button_widget.dart';
import '../../common/widgets/mission_text_field.dart';

class AddMissionBottomSheet extends StatefulWidget {
  final String title;
  final String subtitle;
  final String buttonLabel;
  final String? initialText;

  const AddMissionBottomSheet({
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    this.initialText,
    super.key,
  });

  @override
  State<AddMissionBottomSheet> createState() => _AddMissionBottomSheetState();
}

class _AddMissionBottomSheetState extends State<AddMissionBottomSheet> {
  late final TextEditingController _controller;
  String _missionText = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    if (widget.initialText != null) {
      _controller.text = widget.initialText!;
      _missionText = widget.initialText!;
    }
  }

  void _handleTextChange(String value) {
    setState(() {
      _missionText = value;
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: LuckitTypos.suitSB16.copyWith(
                      color: LuckitColors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.subtitle,
                    style: LuckitTypos.suitR14.copyWith(
                      color: LuckitColors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  MissionTextField(
                    onChanged: _handleTextChange,
                    fieldWidth: MediaQuery.of(context).size.width - 40,
                    controller: _controller,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            BottomButtonWidget(
              onPressed: () {
                context.pop(_missionText);
              },
              label: widget.buttonLabel,
              activated: _missionText.isNotEmpty,
            ),
          ],
        ),
      );
}
