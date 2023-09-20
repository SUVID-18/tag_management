import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

/// 설정 페이지의 백엔드 동작을 담고 있는 뷰모델 클래스.
class SettingsViewModel{
  // 싱글톤 패턴 선언부
  SettingsViewModel._privateConstructor();
  static final SettingsViewModel _instance = SettingsViewModel._privateConstructor();

  /// SettingsViewModel의 생성자이다.
  ///
  /// ```dart
  /// viewmodel = SettingsViewModel();
  /// ```
  factory SettingsViewModel() => _instance;


  // 설정 페이지에 띄워야 할 정보는 관리자의 아이디, 이름, 로그인 된 상태이다.
  // 추가적인 설정은 필요하면 추가할 예정이므로 그대로 둔다.
  late final String _userName = '';
  late final String _userEmail = '';

  String get userName => _userName;
  String get userEmail => _userEmail;

  /// 앱에서 로그아웃을 하는 메서드.
  void logout(BuildContext context){
    // 로그인된 사용자의 정보를 표시하는 위젯을 변경한다.
    FirebaseAuth.instance.signOut();
  }
}