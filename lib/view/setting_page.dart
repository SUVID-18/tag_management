import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  ///사용자 이름 변수
  final _userName = TextEditingController();
  ///사용자 학번 변수
  final _userNumber = TextEditingController();
  ///사용자 전공 변수
  final _userMajor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Settings',style: TextStyle(fontSize: 22)),
            leading: IconButton(
              onPressed: ()=>Navigator.pop(context,"/"),
              icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black
              ),
            )
        ),
        body:SafeArea(
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                children:[
                  SizedBox(height: 20),
                  ///상단 부제목 부분
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      Text("Account",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold))
                    ],
                  ),

                  ///여백용 SizedBox
                  SizedBox(height: 10),

                  ///계정정보란
                  //터치시 AlertDialog 이용하여 계정정보를 보여줌
                  //그냥 쓰니 text overflow가 나서 sizedbox로 감싸고 shrinkwarp사용
                  GestureDetector(
                      onTap: (){
                        showDialog(context: context,
                            builder: (BuildContext context)=>
                                AlertDialog(
                                    title:Text("계정정보"),
                                    content: SizedBox(
                                      width: double.maxFinite,
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: [
                                          Text("이름: $_userName, 학번: $_userNumber, 소속: $_userMajor")
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(onPressed: ()=> Navigator.pop(context),
                                          child: Text("확인"))
                                    ]
                                )
                        );
                      },

                      //안쪽 여백을 위해 Container가 아닌 padding을 이용
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                          child: Row(
                            //여백을 주기위한 spaceBetween
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("계정 정보 확인",style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600]
                              )),
                              Icon(Icons.arrow_forward_ios, color: Colors.grey)
                            ],
                          )
                      )
                  ),

                  ///로그아웃 란
                  //터치시 AlertDialog이용 로그아웃 여부 질문
                  //확인 버튼 터치시 로그인 화면 이동, 취소버튼시 이전화면으로 push처리
                  //확인 버튼은 비교적 짙은색의 elevetedbutton, 취소버튼은 textbutton
                  GestureDetector(
                      onTap: (){
                        showDialog(context: context,
                            builder: (BuildContext context)=>
                                AlertDialog(
                                    title:Text("로그아웃"),
                                    content: Text("로그아웃 하시겠습니까?"),
                                    actions: <Widget>[
                                      TextButton(onPressed: ()=> Navigator.pop(context),
                                          child: Text("취소")),
                                      ElevatedButton(onPressed: (){
                                        context.push("/login");
                                      },
                                          child: Text("확인"))
                                    ]
                                )
                        );
                      },
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            //여백을 주기 위한 spaceBetween
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("로그아웃",style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600]
                              )),
                              Icon(Icons.arrow_forward_ios, color: Colors.grey)
                            ],
                          )
                      )
                  )
                ]
            )
        )
    );
  }
}