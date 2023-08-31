import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SettingsViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('환영합니다.', style: TextStyle(fontSize: 20)),
          Text('${_viewModel.userName} (${_viewModel.userEmail}) 님',
              style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 5),
          const Text('정보수정', style: TextStyle(fontSize: 20)),
          ListTile(
            title: const Text('비밀번호 변경'),
            onTap: () {
              /// 비밀번호 변경 로직 구현 필요
            },
          ),
          ListTile(
            title: const Text('로그아웃'),
            onTap: () {
              _viewModel.logout(context);
            },
          ),
        ],
      ),
    );
  }
}

class SettingsViewModel {
  SettingsViewModel._privateConstructor();

  static final SettingsViewModel _instance =
      SettingsViewModel._privateConstructor();

  factory SettingsViewModel() => _instance;

  late final String _userName = "한동민";

  /// 실제 사용자 이름으로 변경
  late final String _userEmail = "h990309@naver.com";

  ///실제 이메일로 변경

  String get userName => _userName;

  String get userEmail => _userEmail;

  void logout(BuildContext context) {
    /// 로그아웃 로직을 여기에 구현
    /// 예를 들어, 사용자 데이터 초기화 및 로그인 페이지로 이동
    Navigator.pushReplacementNamed(context, '/login'); // 로그인 페이지 경로로 변경
  }
}
