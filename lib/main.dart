import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'routes/app_router.dart';
import 'service/app/app_service.dart';
import 'service/my_info/my_info_service.dart';
import 'theme/luckit_colors.dart';

void main() async {
  await dotenv.load();
  KakaoSdk.init(
    nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY'],
  );
  WidgetsFlutterBinding.ensureInitialized();
  // 앱 전체를 세로 모드로 고정
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();
    ref.read(appServiceProvider.notifier).init().then((_) async {
      if (ref.read(appServiceProvider).isSignedIn) {
        await ref.read(myInfoServiceProvider.notifier).getUserInfo();
      }
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: ref.watch(appRouterProvider).router,
        title: 'lukit',
        theme: ThemeData(
          fontFamily: 'SUIT',
          scaffoldBackgroundColor: LuckitColors.background,
        ),
    debugShowCheckedModeBanner: false,
      );
}
