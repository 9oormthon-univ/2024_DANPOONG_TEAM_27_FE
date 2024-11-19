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

  // static const RouteInfo signUp = RouteInfo(
  //   name: '/auth/sign-up',
  //   path: 'sign-up',
  // );

  // 홈(메인)페이지
  static const RouteInfo home = RouteInfo(
    name: '/home',
    path: '/home',
  );

  // 온보딩
  static const RouteInfo goal = RouteInfo(
    name: '/onboarding/goal',
    path: '/onboarding/goal',
  );

  static const RouteInfo duration = RouteInfo(
    name: '/onboarding/duration',
    path: '/onboarding/duration',
  );

  static const RouteInfo birth = RouteInfo(
    name: '/onboarding/birth',
    path: '/onboarding/birth',
  );
}
