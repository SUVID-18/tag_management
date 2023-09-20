import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tag_management/viewmodel/settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsViewModel viewModel = SettingsViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('환영합니다.', style: TextStyle(fontSize: 20)),
          Text('${viewModel.userName} (${viewModel.userEmail}) 님',
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
            title: const Text('계정생성'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                  title: Row(
                    children: [
                      CircularProgressIndicator(),
                      Text('계정 생성 중....')
                    ],
                  ),
                ),
              );
              viewModel.signUp('test_dev@suvid.com', 'admin!').then((value) {
                context.pop();
                print('user info: $value');
              });
            },
          ),
          ListTile(
            title: const Text('로그아웃'),
            onTap: () => viewModel.logout(context),
          ),
        ],
      ),
    );
  }
}
