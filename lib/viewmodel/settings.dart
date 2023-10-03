import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tag_management/model/supervisor.dart';

/// 설정 페이지의 백엔드 동작을 담고 있는 뷰모델 클래스.
class SettingsViewModel {
  // 싱글톤 패턴 선언부

  // TODO: 주석 변경
  // context 추가
  BuildContext context;

  SettingsViewModel._privateConstructor({required this.context});

  /// SettingsViewModel의 생성자이다.
  ///
  /// ```dart
  /// late viewmodel = SettingsViewModel();
  /// ```
  factory SettingsViewModel({required BuildContext context}) =>
      SettingsViewModel._privateConstructor(context: context);

  // 설정 페이지에 띄워야 할 정보는 관리자의 아이디, 이름, 로그인 된 상태이다.
  // 추가적-*인 설정은 필요하면 추가할 예정이므로 그대로 둔다.
  late final String _userName;
  late final String _userEmail;

  @Deprecated('해당 필드는 더 이상 사용할 수 없습니다. 대신 getSupervisor메서드를 사용하세요')
  String get userName => _userName;

  @Deprecated('해당 필드는 더 이상 사용할 수 없습니다. 대신 getSupervisor메서드를 사용하세요')
  String get userEmail => _userEmail;

  /// 앱에서 로그아웃을 하는 메서드.
  ///
  /// 로그아웃 버튼을 누르면 로그아웃을 실행해야 함.
  /// 로그아웃 메세지 띄우기
  /// 로그아웃 진행/*
  /// 페이지 이동
  ///
  /// 프론트 입장에선 따로 뺑글이가 안돌아가면 좋을 것.
  void logout(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그아웃 중입니다.. 로그아웃 후 메인 페이지로 이동합니다.')));
    // 로그인된 사용자의 정보를 표시하는 위젯을 변경한다.
    FirebaseAuth.instance.signOut().then((_) {
      context.go('/login');
    });
  }

  // 관리자의 정보를 좀 생각해 봐야 할 듯. 이름만 넣는 것을 우선으로 생각.
  Future<Supervisor?> getSupervisorInfo() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var supervisor = await FirebaseFirestore.instance
          .collection('supervisor')
          .doc(user.uid)
          .get();
      var data = supervisor.data();
      if (data != null) {
        return Supervisor.fromJson(data);
      }
    }
    return null;
  }
}
