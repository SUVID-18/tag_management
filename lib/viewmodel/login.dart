import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LoginViewModel with WidgetsBindingObserver {

  // 뷰모델에서 프론트 팀이 위젯을 작업하는 것을 막기 위해서 AlertDialog 등을 매개변수로 넘겨야 할 필요가 있음.
  // 이 때, context를 제공해야 오류가 발생하지 않는다.
  BuildContext context;

  final _emailControllerText = TextEditingController();
  TextEditingController get emailControllerText => _emailControllerText;


  LoginViewModel._privateConstructor({required this.context}) {
    // 기존에 저장된 이메일이 있다면 바로 로그인을 진행한다.

    // SharedPreference에 저장된 이메일이 있다면 꺼낸다. ( 비밀번호 저장 기능 )
    // 앱을 시작한 동적 링크가 있다면 패스워드 없는 로그인을 진행

    SharedPreferences.getInstance().then((sharedPreferences) {
      var savedEmail = sharedPreferences.getString('email');
      if (savedEmail != null) {
        _emailControllerText.text = savedEmail;
      }
    });


    // 로그인을 위해서는, firebaseAuth에서 로그인 딥 링크를 필요로 한다.
    // 따라서 딥 링크가 있는지 확인하고, 이 링크가 로그인 링크라면 넘긴다.
    FirebaseDynamicLinks.instance.getInitialLink().then((dynamicLink) {
      if (dynamicLink != null && FirebaseAuth.instance.isSignInWithEmailLink(
          dynamicLink.link.toString())) {
        debugPrint('하이퍼링크 눌림 확인!!');
        _passwordlessLogin(dynamicLink);
      }
    });
  }

  /// 로그인 기능을 처리하는 뷰모델의 생성자이다.
  /// 해당 뷰모델을 사용하기 위해서는 initState()와 dispose() 메서드에 옵저버를 추가해 주어야 한다.
  /// ```dart
  /// class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver
  /// ```
  ///
  /// initState(), dispose() 또한 다음과 같은 선언이 필요하다.
  /// ```dart
  /// @override
  /// void initState(){
  ///   WidgetsBinding.instance.addObserver(this);
  ///   super.initState();
  /// }
  ///
  /// void dispose(){
  ///   WidgetsBinding.instance.removeObserver(this);
  ///   super.dispose();
  /// ```
  factory LoginViewModel({required BuildContext context}) =>
      LoginViewModel._privateConstructor(context: context);


  // -------------------------------------- 함수 정의 부분 ----------------------------------

  /// 앱 상태 변경을 위한 메서드이다.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    // 무엇을 바꾸지?
    switch (state) {
      case AppLifecycleState.resumed:
        // 가져오는 이메일은 반드시 null이 아니어야 한다.
        // sharedPref 객체는 생성될 때 반드시 email의 값을 저장하므로
        // 느낌표를 붙여 해당 String 값이 반드시 null이 아님을 밝힌다.

        SharedPreferences.getInstance().then((sharedPref) {
          emailControllerText.text = sharedPref.getString('email')!;
        });

        debugPrint('resumed 확인');

        try{
          FirebaseDynamicLinks.instance.onLink.listen((event) {
            _passwordlessLogin(event);
          });
        }catch(e){
          throw Exception('$e, dynamic 링크 오류');
        }

        break;

      case AppLifecycleState.inactive:
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', _emailControllerText.text);
        break;

      default:
        break;
    }
  }

  // inactive 및 paused 상태 : 백그라운드 전환,
  // foreground 전환 시 resumed 하나로 퉁치므로,

  /// ```dart
  ///
  /// ElevatedButton(
  ///   onPressed: () =>  viewmodel.onPressed_sendCreateAccountLink;
  /// )
  /// ```
  void sendCreateAccountLink(
      {required AlertDialog loginTextEmptyDialog}) async {
    // 이메일 링크를 만드는 정보를 담은 ActionCodeSettings 객체를 생성한다.
    if (emailControllerText.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => loginTextEmptyDialog,

      );
    } else {
      var acs = ActionCodeSettings(
          url: 'https://suvid.page.link/login',
          handleCodeInApp: true,
          // 건들지 말 것.
          androidPackageName: 'com.suvid.tag_management',
          androidInstallApp: true,
          androidMinimumVersion: '12'
      );

      // 위 ActionCodeSettings에 규정된 규칙대로, emailAuth 주소에 인증 요청 메일을 보내는 sendSignInLinkToEmail 함수를 호출한다.
      var emailAuth = emailControllerText.text;
      FirebaseAuth.instance.sendSignInLinkToEmail(
          email: emailAuth, actionCodeSettings: acs)
          .catchError((onError) {
            // 왜인지는 모르겠는데
        // Navigator.pop 을 사용하면 검은색 화면으로 넘어가고, 더 이상 진행이 안됨.
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('해당 이메일로 인증 메일을 보냈습니다. 확인해주세요.')));
      })
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('해당 이메일로 인증 메일을 보냈습니다. 확인해주세요.'),
        ));
      });
    }
  }

  void _passwordlessLogin(PendingDynamicLinkData dynamicLinkData) async {
    try {
      // 로그인을 진행함.
      final userCredential = await FirebaseAuth.instance.signInWithEmailLink(
        // 기존에 저장된 데이터가 있다면, 함수 호출 이전에 초기화 시켜줘야 한다.
          email: emailControllerText.text,
          emailLink: dynamicLinkData.link.toString()
      );

      if(context.mounted){
        context.go('/');
      }
    }

    // 주어진 링크가 로그인 링크가 아닐 경우
    catch (identifier) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('로그인에 실패하였습니다.')
        )
      );
    }
  }
}