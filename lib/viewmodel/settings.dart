import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tag_management/model/supervisor.dart';

/// 설정 페이지의 백엔드 동작을 담고 있는 뷰모델 클래스.
class SettingsViewModel {

  /// 위젯을 띄우기 위한 context. 뷰모델 호출 시 매개변수로 context를 받아온다.
  BuildContext context;

  // 싱글톤 패턴 선언부

  SettingsViewModel._privateConstructor({required this.context});

  /// SettingsViewModel의 생성자이다.
  ///
  /// 뷰모델의 [getSupervisorInfo] 메서드를 사용하기 위해서 FutureBuilder를 사용해야 한다.
  /// ```dart
  /// late var viewmodel = SettingsViewModel(context);
  /// ```
  factory SettingsViewModel({required BuildContext context}) =>
      SettingsViewModel._privateConstructor(context: context);

  // 관리자의 이름과 이메일을 받는 String 변수이다. Supervisor 모델을 사용하면 되며, 현재는 Deprecated 처리되었다.
  late final String _userName;
  late final String _userEmail;

  @Deprecated('해당 필드는 더 이상 사용할 수 없습니다. 대신 getSupervisor메서드를 사용하세요')
  String get userName => _userName;

  @Deprecated('해당 필드는 더 이상 사용할 수 없습니다. 대신 getSupervisor메서드를 사용하세요')
  String get userEmail => _userEmail;

  /// 앱에서 로그아웃을 하는 메서드.
  ///
  /// 설정 페이지에서 로그아웃 버튼의 [onPressed]에 할당한다.
  ///
  /// ```dart
  ///
  /// late var viewModel = SettingsViewModel(context);
  /// ...(생략)
  ///   onPressed : () {
  ///     viewModel.logout();
  ///   }
  /// ```
  void logout(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그아웃 중입니다.. 로그아웃 후 메인 페이지로 이동합니다.')));
    // 로그인된 사용자의 정보를 표시하는 위젯을 변경한다.
    FirebaseAuth.instance.signOut().then((_) {
      context.go('/login');
    });
  }

  /// 로그인 완료 후 설정 페이지에서 관리자의 정보를 출력하기 위해 정보를 가져오는 메서드.
  ///
  /// 해당 기능을 사용하기 위해서 [Supervisor] 모델을 import 해야 한다.
  /// [Supervisor] 객체를 생성하여 정보를 받거나, [FutureBuilder]를 이용해 [Snapshot]에 해당 메서드를 이용해도 된다.
  ///
  ///
  /// ```dart
  /// late var viewModel = SettingsViewModel(context);
  ///
  /// ...(생략)
  /// FutureBuilder<Supervisor?>(
  ///   future: viewModel.getSupervisorInfo(),
  /// )
  /// ```
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