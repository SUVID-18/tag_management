import 'package:flutter/material.dart';
import 'package:tag_management/model/supervisor.dart';
import 'package:tag_management/viewmodel/settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsViewModel viewModel = SettingsViewModel(context: context);

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
          FutureBuilder<Supervisor?>(
              future: viewModel.getSupervisorInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.data == null) {
                  return Text('Unknown user 님');
                } else {
                  return Text('${snapshot.data!.name} 님',
                      style: const TextStyle(fontSize: 20));
                }
              }),
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
            onTap: () => viewModel.logout(context),
          ),
        ],
      ),
    );
  }
}
