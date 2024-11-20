import 'route_info.dart';

class Routes {
  // auth
  // static const RouteInfo auth = RouteInfo(
  //   name: '/auth',
  //   path: '/auth',
  // );

  // static const RouteInfo signIn = RouteInfo(
  //   name: '/auth/sign-in',
  //   path: 'sign-in',
  // );

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

  // 온보딩
  static const RouteInfo goal = RouteInfo(
    name: '/onboarding/goal',
    path: '/onboarding/goal',
  );

  // 농장
  static const RouteInfo farm = RouteInfo(
    name: '/farm',
    path: '/farm',
  );

  // 목표 달성
  static const RouteInfo goalComplete = RouteInfo(
    name: '/goal-complete',
    path: '/goal-complete',
  );
}
