import 'package:flutter/material.dart';

/// 태그 정보 업로드를 위한 페이지 입니다.
/// 강의실 정보 업로드
class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
///강의실 리스트
  List<Map<String, dynamic>> _dataList = [
    {'number': '201호', 'id': '1a2s3d4f5g'},
    {'number': '202호', 'id': '6h7j8k9l0q'},
    {'number': '303호', 'id': '11w22e33r4'},
  ];
  /// 강의실 고유번호 변수
  final _roomIdController = TextEditingController();
  /// 강의실 번호 변수
  final _roomNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar 부분
      appBar: AppBar(
        title: Text("업로드 페이지"),
          leading: IconButton(
            onPressed: ()=>Navigator.pop(context,"/"),
            icon: Icon(
                Icons.arrow_back,
                color: Colors.black
            ),
          )
      ),

      //ListView를 사용해 리스트를 동적으로 나타내도록 함
      body: ListView.builder(
        ///리스트의 길이 만큼 카운트
        itemCount: _dataList.length,

        ///위젯을 인덱스 만큼 만들도록 함
        itemBuilder: (context, index) {
          ///태그한 내용을 탭하여 업로드 할 수 있도록 하는 gesturedetector
          ///alertDialog를 통해 강의실 번호를 입력 받아 확인시 업로드가 된다
          return GestureDetector(
            onTap: (){
              showDialog(context: context,
                  builder: (BuildContext context)=>
              AlertDialog(
                title: Text("업로드 정보"),
                content: TextField(
                  controller: _roomNumberController,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '강의실 번호'
                  ),
                ),
                  ///확인 버튼임
                  //아직 입력 받아 리스트에 추가하는것 구현 안함
                  actions: <Widget>[
                    TextButton(onPressed: (){
                      Navigator.pop(context);},
                        child: Text('확인'))
                  ]
                )
              );
            },
            //호수와 고유번호가 보임
            child: Column(
              children: [
                Text(_dataList[index]['number']),
                Text(_dataList[index]['id'])
              ],
            ),
          );
        },
      ),
    );
  }
}

