import 'package:flutter/material.dart';
import 'package:tag_management/model/nfc.dart';
import 'package:tag_management/viewmodel/management.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({super.key});

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  late var viewModel = ManagementViewModel(context: context);

  final _roomNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var dataList = viewModel.getNfcTagList();
    return Scaffold(
      body: FutureBuilder<List<NfcObject>>(
          future: dataList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.data == null) {
              return const Center(
                child: Text('데이터 없음'),
              );
            } else {
              return ListView.builder(
                ///리스트의 길이 만큼 카운트
                itemCount: snapshot.data!.length,

                ///위젯을 인덱스 만큼 만들도록 함
                itemBuilder: (context, index) {
                  ///태그한 내용을 탭하여 업로드 할 수 있도록 하는 gesturedetector
                  ///alertDialog를 통해 강의실 번호를 입력 받아 확인시 업로드가 된다
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                  title: const Text("업로드 정보"),
                                  content: TextField(
                                    controller: _roomNumberController,
                                    decoration: const InputDecoration(
                                        filled: true, labelText: '강의실 번호'),
                                  ),

                                  ///확인 버튼임
                                  //아직 입력 받아 리스트에 추가하는것 구현 안함
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('확인'))
                                  ]));
                    },
                    //호수와 고유번호가 보임
                    child: Card(
                      child: Column(
                        children: [
                          Text(
                            snapshot.data![index].lectureRoom,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}

/// 태그 조회 및 강의실 정보 변경 기능을 수행하는 뷰모델 클래스
