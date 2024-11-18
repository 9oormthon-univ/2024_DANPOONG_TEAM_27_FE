// import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'fortune_state.dart';
import 'fortune_view_model.dart';

class FortuneView extends ConsumerStatefulWidget {
  const FortuneView({super.key});

  @override
  ConsumerState<FortuneView> createState() => _FortuneViewState();
}

class _FortuneViewState extends ConsumerState<FortuneView> {
  @override
  Widget build(BuildContext context) {
    final FortuneState state = ref.watch(fortuneViewModelProvider);
    final FortuneViewModel viewModel =
        ref.read(fortuneViewModelProvider.notifier);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Text(state.example),
          TextButton(
            onPressed: viewModel.onToggleExample,
            child: const Text('toggleExample'),
          ),
        ],
      ),
    );
  }
}
