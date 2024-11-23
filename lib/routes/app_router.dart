import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../ui/farm/farm_view.dart';
import '../ui/fortune/fortune_view.dart';
import '../ui/goal_complete/goal_complete_view.dart';
import '../ui/home/home_view.dart';
import '../ui/login/login_view.dart';
import '../ui/edit/views/editing_goal_view.dart';
import '../ui/edit/views/editing_duration_view.dart';
import '../ui/onboarding/onboarding_view.dart';
import '../ui/onboarding/views/onboarding_birth_view.dart';
import '../ui/onboarding/views/onboarding_duration_view.dart';
import '../ui/onboarding/views/onboarding_goal_view.dart';
import '../ui/profile/profile_edit_view.dart';
import '../ui/profile/profile_view.dart';
import '../ui/tutorial/start_view.dart';
import '../ui/tutorial/tutorial_view.dart';
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
        path: Routes.onboardingg.path,
        name: Routes.onboardingg.name,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage<dynamic>(
          child: OnboardingView(),
        ),
      ),
      // Auth
      GoRoute(
        path: Routes.auth.path,
        name: Routes.auth.name,
        redirect: (BuildContext context, GoRouterState state) {
          if (state.fullPath == null || state.fullPath == Routes.auth.path) {
            return Routes.login.name;
          }
          return null;
        },
        routes: <RouteBase>[
          GoRoute(
            name: Routes.login.name,
            path: Routes.login.path,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const NoTransitionPage<dynamic>(
              child: LoginView(),
            ),
          ),
        ],
      ),

      GoRoute(
          path: Routes.home.path,
          name: Routes.home.name,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<dynamic>(
                child: HomeView(),
              ),
          routes: <RouteBase>[
            GoRoute(
              name: Routes.editDuration.name,
              path: Routes.editDuration.path,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  const NoTransitionPage<dynamic>(
                child: EditDurationView(),
              ),
            ),
            GoRoute(
              name: Routes.editGoal.name,
              path: Routes.editGoal.path,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  const NoTransitionPage<dynamic>(
                child: EditingGoalView(),
              ),
            ),
            GoRoute(
              path: Routes.start.path,
              name: Routes.start.name,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                   NoTransitionPage<dynamic>(
                child: StartView(onNextPage: () {

                },),
              ),
              routes: <RouteBase>[
                GoRoute(
                  name: Routes.goal.name,
                  path: Routes.goal.path,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                       NoTransitionPage<dynamic>(
                    child: OnboardingGoalView(onNextPage: (){},),
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
                       NoTransitionPage<dynamic>(
                    child: OnboardingBirthView(onNextPage: (){},),
                  ),
                ),
                GoRoute(
                  name: Routes.tutorial.name,
                  path: Routes.tutorial.path,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      const NoTransitionPage<dynamic>(
                    child: TutorialView(),
                  ),
                ),
              ],
            ),
          ]),
      GoRoute(
        name: Routes.fortune.name,
        path: Routes.fortune.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage<dynamic>(
          child: FortuneView(),
        ),
      ),
      GoRoute(
        path: Routes.profile.path,
        name: Routes.profile.name,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage<dynamic>(
          child: ProfileView(),
        ),
      ),
      GoRoute(
        path: Routes.edit.path,
        name: Routes.edit.name,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage<dynamic>(
          child: ProfileEditView(),
        ),
      ),

      GoRoute(
        name: Routes.farm.name,
        path: Routes.farm.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage<dynamic>(
          child: FarmView(),
        ),
      ),
      GoRoute(
        name: Routes.goalComplete.name,
        path: Routes.goalComplete.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage<dynamic>(
          child: GoalCompleteView(),
        ),
      ),
    ],
  );

  GoRouter get router => _router;
}
