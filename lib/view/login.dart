import 'package:flutter/material.dart';

/// 로그인 시 나타나는 페이지 입니다.
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// 아이디를 입력받는 [TextEditingController]
  final _usernameController = TextEditingController();
  /// 비밀번호를 입력받는 [TextEditingController]
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            ///상단 출석체크 위젯
            ///assets/images/swu_horizontalLogo.png 이미지 추가해놓음
            SizedBox(height: 80.0),
             Column(
              children: <Widget>[
                Image.asset('assets/images/swu_horizontalLogo.png'),
                SizedBox(height: 1.0),
                Text('태그 관리용', style: TextStyle(fontSize: 30),),
                ],
             ),
            /// 아이디 및 비밀번호 입력란
            /// _usernameController 변수 사용
            SizedBox(height: 60.0,),
            TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'ID'
                ),
              ),
            ///비밀번호 입력란
            ///obscureText 사용 비밀번호 입력시 숨김
            SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Password'
                ),
                obscureText: true,
              ),
              ///이벤트 버튼 구현 위젯
              ButtonBar(
                children: <Widget>[
                  // cancel버튼
                  // 누를 시 입력한 내용 다 지워지도록 구현
                  TextButton(onPressed: (){
                    _usernameController.clear();
                    _passwordController.clear();
                  }, child: Text("Cancel"),
                  ),
                  // 다음 페이지로 가는 Next 버튼
                  // pop기능 만들어놨음 메인페이지로 이동하면 됨
                  // 잘못된 정보 입력시 AlertDialog뜨도록 주석으로 구현해놓음
                  ElevatedButton(onPressed: (){
                    //showDialog(
                    //       context: context,
                    //       builder: (BuildContext context)=>AlertDialog(
                    //       title: Text('로그인 실패'),
                    //       content: Text('ID나 비밀번호가 없거나 잘못되었습니다'),
                    //       actions: <Widget>[
                    //                   TextButton(onPressed: ()=> Navigator.pop(context),
                    //                   child: Text('확인'))
                    //                  ]
                    //                 )
                    //                );
                    //Navigator.pop(context,"/");
                  }, child: Text('Next'))
                ],
              ),
            /// 하단 로고
            /// 이미지 에셋 해놓음
            Column(
                children: [
                  SizedBox(height: 50,),
                  Image.asset('assets/images/swu_bluelogo.png')
                ]
            )
          ],
        ),
      )
    );
  }
}
