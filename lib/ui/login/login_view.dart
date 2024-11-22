import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/loading_status.dart';
import '../../theme/luckit_colors.dart';
import '../common/consts/assets.dart';
import 'login_state.dart';
import 'login_view_model.dart';
import '../../routes/routes.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoginState state = ref.watch(loginViewModelProvider);
    final LoginViewModel viewModel = ref.read(loginViewModelProvider.notifier);

    // 로그인 상태 변경 감지
    ref.listen(loginViewModelProvider,
        (LoginState? previous, LoginState current) {
      if (current.kakaoOauthLoadingStatus == LoadingStatus.success &&
          current.isAuthenticated) {
        // TODO: 온보딩이 필요한 경우 (새로운 사용자)
        context.goNamed(Routes.start.name);
        // if (current.needsOnboarding) {
        //   context.goNamed(Routes.onboarding.name);
        // } else {
        // 기존 사용자는 홈으로
        // }
      }
    });

    return Scaffold(
      backgroundColor: LuckitColors.background,
      body: Stack(
        children: <Widget>[
          DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.loginBackground), fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SvgPicture.asset(Assets.loginLogo),
                const SizedBox(
                  height: 168,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: InkWell(
                    onTap: viewModel.signInWithKakao,
                    child: Image.asset(Assets.kakaoLogin),
                  ),
                ),
              ],
            ),
          ),
          if (state.kakaoOauthLoadingStatus == LoadingStatus.loading)
            const ColoredBox(
              color: Colors.black38,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
