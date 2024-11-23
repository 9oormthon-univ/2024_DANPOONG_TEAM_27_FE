import 'route_info.dart';

class Routes {
  // auth
  static const RouteInfo auth = RouteInfo(
    name: '/auth',
    path: '/auth',
  );

  // 로그인 페이지
  static const RouteInfo login = RouteInfo(
    name: '/auth/login',
    path: 'login',
  );

  // 홈(메인)페이지
  static const RouteInfo home = RouteInfo(
    name: '/home',
    path: '/home',
  );

  // 운세 페이지
  static const RouteInfo fortune = RouteInfo(
    name: '/fortune',
    path: '/fortune',
  );

  // 프로필 페이지
  static const RouteInfo profile = RouteInfo(
    name: '/profile',
    path: '/profile',
  );

  static const RouteInfo edit = RouteInfo(
    name: '/edit',
    path: '/edit',
  );

  // 온보딩 시작
  static const RouteInfo start = RouteInfo(
    name: '/home/onboarding',
    path: 'onboarding',
  );

  // 온보딩
  static const RouteInfo goal = RouteInfo(
    name: '/home/onboarding/goal',
    path: 'goal',
  );

  static const RouteInfo duration = RouteInfo(
    name: '/home/onboarding/duration',
    path: 'duration',
  );

  static const RouteInfo birth = RouteInfo(
    name: '/home/onboarding/birth',
    path: 'birth',
  );

  // 튜토리얼
  static const RouteInfo tutorial = RouteInfo(
    name: '/home/onboarding/tutorial',
    path: 'tutorial',
  );

  // 목표 수정
  static const RouteInfo editGoal = RouteInfo(
    name: '/home/edit-goal',
    path: 'edit-goal',
  );

  static const RouteInfo editDuration = RouteInfo(
    name: '/home/edit-duration',
    path: 'edit-duration',
  );

  // 농장
  static const RouteInfo farm = RouteInfo(
    name: '/farm',
    path: '/farm',
  );

  // 목표 달성
  static const RouteInfo goalComplete = RouteInfo(
    name: '/home/goal-complete',
    path: 'goal-complete',
  );
}
