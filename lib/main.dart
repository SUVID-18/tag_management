import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tag_management/view/login.dart';
import 'package:tag_management/view/main_page.dart';
import 'package:tag_management/view/management.dart';
import 'package:tag_management/view/upload.dart';

void main() => runApp(App());

/// 앱 이름에 해당되는 상수
const String appName = '태그 관리 앱';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final GoRouter _routes = GoRouter(routes: [
    // 앱 실행 시 가장 먼저 출력되는 페이지
    GoRoute(
      path: '/',
      builder: (context, state) => MainPage(
        appName: appName,
      ),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/upload',
      builder: (context, state) => UploadPage(),
    ),
    GoRoute(
      path: '/management',
      builder: (context, state) => ManagementPage(),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appName,
      routerConfig: _routes,
      theme: ThemeData(
          // Material3 테마를 사용할지에 대한 여부
          useMaterial3: true),
    );
  }
}
