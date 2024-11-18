import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import '../service/app/app_service.dart';
// import '../service/app/app_state.dart';
// import 'routes.dart';

// redirect 여부 및 redirect location 를 결정하는 역할을 수행합니다.
class AppRouterInterceptor {
  // ignore: unused_field
  final Ref _ref;

  const AppRouterInterceptor({
    required Ref<Object?> ref,
  }) : _ref = ref;

  // 라우트의 이동마다 호출됩니다.
  // ignore: prefer_expression_function_bodies
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    // final bool isSignedIn = _ref
    //   .read(appServiceProvider.select((AppState value) => value.isSignedIn));

    // if (!isSignedIn) {
    //   // sign in 으로 가야만 하는 상태입니다.
    //   if (state.fullPath?.startsWith(Routes.auth.name) == false) {
    //     return Routes.signIn.name;
    //   }
    // } else {
    //   // 현재 위치가 아직도 auth 관련 페이지에 있다면
    //   // 즉시 가족 구성원 화면으로 리다이렉트 해줍니다.
    //   if (state.fullPath != null &&
    //       state.fullPath!.startsWith(Routes.auth.name)) {
    //     return Routes.home.name;
    //   }
    // }

    return null;
  }
}
