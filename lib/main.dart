import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tag_management/firebase_options.dart';
import 'package:tag_management/view/login.dart';
import 'package:tag_management/view/main_page.dart';
import 'package:tag_management/view/management.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 에뮬레이터 사용을 위한 코드 삽입
  if (kDebugMode) {
    try{
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } catch (e){
      print(e);
    }
  }
  
  runApp(App());
}

/// 앱 이름에 해당되는 상수
const String appName = '태그 관리 앱';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final GoRouter _routes = GoRouter(routes: [
    // 앱 실행 시 가장 먼저 출력되는 페이지

    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),

    GoRoute(
        // 테스트를 위한 임시 비활성화
        redirect: (context, state) async {
          if (FirebaseAuth.instance.currentUser == null) {
            return '/login';
            // 로그인이 안되어있으면 출결 페이지 안띄움
          } else {
            return null;
          }
        },
        path: '/',
        builder: (context, state) => const MainPage(
              appName: appName,
            ),
        routes: [
          GoRoute(
            path: 'management',
            builder: (context, state) => const ManagementPage(),
          ),
        ]),
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