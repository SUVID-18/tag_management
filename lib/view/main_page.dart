import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'management.dart';

/// 홈 화면을 나타내는 페이지 입니다.
class MainPage extends StatelessWidget {
  /// 앱의 이름에 해당되는 변수입니다.
  final String appName;

  const MainPage({required this.appName, Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: '수원대학교 출결관리 메인페이지',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(title: const Text("수원대학교 출결 시스템")),
          body: const Text("메인화면 해야할것 1.로딩화면 구현, 2.이미지 가져오기")
      ),
    );
  }

}
