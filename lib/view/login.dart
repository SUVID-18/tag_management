import 'package:flutter/material.dart';
import 'package:tag_management/viewmodel/login.dart';

/// 로그인 시 나타나는 페이지 입니다.
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  ///뷰모델 선언
  late var viewModel = LoginViewModel(context: context);
  ///로그인 실패 AlertDialod 선언

  AlertDialog warningDialog =
      const AlertDialog(title: Text('로그인 실패'), content: Text('로그인에 실패하였습니다')
    );
  ///뷰모델 적용시 필요한 함수
  @override
   void initState(){
     WidgetsBinding.instance.addObserver(viewModel);
     super.initState();
   }

   @override
   void dispose(){
     WidgetsBinding.instance.removeObserver(viewModel);
     super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            ///상단 출석체크 위젯
            ///assets/images/swu_horizontalLogo.png 이미지 추가해놓음
          const SizedBox(height: 80.0),
          Column(
            children: <Widget>[
                Image.asset('assets/images/swu_horizontalLogo.png'),
              const SizedBox(height: 1.0),
              const Text(
                '태그 관리용',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
            /// 아이디 및 비밀번호 입력란
            /// _usernameController 변수 사용
          const SizedBox(
            height: 60.0,
          ),
          TextField(
            controller: viewModel.emailController,
            decoration: const InputDecoration(filled: true, labelText: 'ID'
                ),
              ),
            ///비밀번호 입력란
            ///obscureText 사용 비밀번호 입력시 숨김
          const SizedBox(height: 12.0),
          TextField(
            controller: viewModel.passwordController,
            decoration:
                const InputDecoration(filled: true, labelText: 'Password'
                ),
                obscureText: true,
              ),
              ///이벤트 버튼 구현 위젯

              ButtonBar(
                children: <Widget>[
                  // 다음 페이지로 가는 Next 버튼
                  /// 뷰모델 적용 완료
                  ElevatedButton(
                  onPressed: () =>
                      viewModel.signUp(loginTextEmptyDialog: warningDialog),
                  child: const Text('Next'))
            ],
          ),
            /// 하단 로고
            /// 이미지 에셋 해놓음
            Column(
                children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset('assets/images/swu_bluelogo.png')
          ]
            )
          ],
        ),
      )
    );
  }
}
