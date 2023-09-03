import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final String username;
  final Function() onLogout;

  const SettingsPage({Key? key, required this.username, required this.onLogout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('환영합니다, $username 님.', style: TextStyle(fontSize: 20)),
          SizedBox(height: 5),
          Text('정보수정', style: TextStyle(fontSize: 20)),
          ListTile(
            title: Text('비밀번호 변경'),
            onTap: () {
              /// 비밀번호 변경 로직 구현필요
            },
          ),
          ListTile(
            title: Text('로그아웃'),
            onTap: onLogout,

            ///로그아웃시 변경 로직 구현 필요
          ),
        ],
      ),
    );
  }
}
