import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'routes/app_router.dart';
import 'theme/luckit_colors.dart';

void main() async {
  await dotenv.load();
  KakaoSdk.init(
    nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY'],
  );
  WidgetsFlutterBinding.ensureInitialized();
  // 앱 전체를 세로 모드로 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const ProviderScope(child: MainApp()));
  });
  // runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
        routerConfig: ref.watch(appRouterProvider).router,
        title: 'boiler plate',
        theme: ThemeData(
          fontFamily: 'SUIT',
          scaffoldBackgroundColor: LuckitColors.background,
        ),
      );
}
