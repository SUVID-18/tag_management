import 'package:flutter/material.dart';
import 'package:tag_management/model/supervisor.dart';
import 'package:tag_management/viewmodel/settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsViewModel viewModel = SettingsViewModel(context: context);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: FutureBuilder<Supervisor?>(
          future: viewModel.getSupervisorInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('환영합니다.', style: TextStyle(fontSize: 20)),
                  Text('${snapshot.data?.name ?? '(알 수 없음)'} 님',
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 5),
                  ListTile(
                    title: const Text(
                      '로그아웃',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    onTap: () => viewModel.logout(context),
                  ),
                ],
              );
            }
          }),
    );
  }
}
