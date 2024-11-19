import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../ui/home/home_view.dart';
import '../ui/onboarding/views/onboarding_birth_view.dart';
import '../ui/onboarding/views/onboarding_duration_view.dart';
import '../ui/onboarding/views/onboarding_goal_view.dart';
import 'app_router_interceptor.dart';
import 'redirect_notifier.dart';
import 'routes.dart';

final Provider<AppRouter> appRouterProvider =
    Provider<AppRouter>((ProviderRef<AppRouter> ref) => AppRouter(
          appRouterInterceptor: AppRouterInterceptor(ref: ref),
          refreshListenable: ref.read(redirectNotifierProvider),
        ));

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  AppRouter({
    required Listenable refreshListenable,
    required AppRouterInterceptor appRouterInterceptor,
  })  : _appRouterInterceptor = appRouterInterceptor,
        _refreshListenable = refreshListenable;

  final AppRouterInterceptor _appRouterInterceptor;
  final Listenable _refreshListenable;

  // 라우트의 이동마다 호출됩니다.
  FutureOr<String?> _redirect(BuildContext context, GoRouterState state) =>
      _appRouterInterceptor.redirect(context, state);

  late final GoRouter _router = GoRouter(
    initialLocation: Routes.home.name,
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    refreshListenable: _refreshListenable,
    errorBuilder: (BuildContext context, GoRouterState state) => const Scaffold(
      body: Center(
        child: Text('Internal Error'),
      ),
    ),
    redirect: _redirect,
    routes: <RouteBase>[
      GoRoute(
        name: Routes.home.name,
        path: Routes.home.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage<dynamic>(
          child: HomeView(),
        ),
      ),
      GoRoute(
        name: Routes.goal.name,
        path: Routes.goal.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage<dynamic>(
          child: OnboardingGoalView(),
        ),
      ),
      GoRoute(
        name: Routes.duration.name,
        path: Routes.duration.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
        const NoTransitionPage<dynamic>(
          child: OnboardingDurationView(),
        ),
      ),
      GoRoute(
        name: Routes.birth.name,
        path: Routes.birth.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
        const NoTransitionPage<dynamic>(
          child: OnboardingBirthView(),
        ),
      ),
      // Auth
      // GoRoute(
      //   path: Routes.auth.path,
      //   name: Routes.auth.name,
      //   redirect: (BuildContext context, GoRouterState state) {
      //     if (state.fullPath == null || state.fullPath == Routes.auth.path) {
      //       return Routes.signIn.name;
      //     }
      //     return null;
      //   },
      //   routes: <RouteBase>[
      //     GoRoute(
      //         name: Routes.signIn.name,
      //         path: Routes.signIn.path,
      //         pageBuilder: (BuildContext context, GoRouterState state) =>
      //             const NoTransitionPage<dynamic>(
      //               child: SignInView(),
      //             ),
      //         routes: <RouteBase>[
      //           GoRoute(
      //             name: Routes.signUp.name,
      //             path: Routes.signUp.path,
      //             pageBuilder: (BuildContext context, GoRouterState state) =>
      //                 const NoTransitionPage<dynamic>(
      //               child: SignUpView(),
      //             ),
      //           ),
      //         ]),
      //   ],
      // ),
    ],
  );

  GoRouter get router => _router;
}
