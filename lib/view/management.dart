import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tag_management/model/nfc.dart';
import 'package:tag_management/viewmodel/management.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({super.key});

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  late var viewModel = ManagementViewModel(context: context);

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
                                  title: Text(
                                      '강의실 정보 변경(이전 이름: ${snapshot.data?[index].lectureRoom})'),
                                  content: TextField(
                                    controller: viewModel.roomNumberController,
                                    decoration: const InputDecoration(
                                        filled: true, labelText: '새로운 강의실 이름'),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () async {
                                          if (viewModel.roomNumberController
                                              .text.isEmpty) {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text('경고'),
                                                content: const Text(
                                                    '강의실 이름을 입력하지 않았습니다.'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () =>
                                                          context.pop(),
                                                      child: const Text('확인'))
                                                ],
                                              ),
                                            );
                                          } else {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) =>
                                                  const AlertDialog(
                                                content: Row(
                                                  children: [
                                                    CircularProgressIndicator(),
                                                    Text('작업 중....')
                                                  ],
                                                ),
                                              ),
                                            );
                                            await viewModel.editNfcTag(
                                              context: context,
                                              tag: snapshot.data![index],
                                            );
                                            if (context.mounted) {
                                              context.pop();
                                              context.pop();
                                            }
                                          }
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
