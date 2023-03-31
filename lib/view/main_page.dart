import 'package:flutter/material.dart';

/// 홈 화면을 나타내는 페이지 입니다.
class MainPage extends StatelessWidget {
  /// 앱의 이름에 해당되는 변수입니다.
  final String appName;
  const MainPage({required this.appName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
      ),
      body: Placeholder(),
    );
  }
}

