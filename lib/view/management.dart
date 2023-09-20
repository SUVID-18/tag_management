import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/nfc.dart';

/// 앱의 메인 함수
void main() {
  runApp(ManagementPage());
}

class ManagementPage extends StatefulWidget {
  @override
  _ManagementPageState createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NFC Tag '),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            /// NFC 태그 목록을 가져오는 함수 호출
            List<NfcObject> _cardDataList =
                await ManagementViewModel.getNfcTagList();

            /// 가져온 NFC 태그 목록을 활용하여 수행할 수 있음
          },
          child: Text('Get NFC'),

          /// 버튼에 표시될 텍스트
        ),
      ),
    );
  }
}

/// 태그 조회 및 강의실 정보 변경 기능을 수행하는 뷰모델 클래스
class ManagementViewModel {
  BuildContext context;

  /// 생성자를 통해 BuildContext 초기화
  ManagementViewModel._privateConstructor({required this.context});

  /// 팩토리 메서드를 통한 ManagementViewModel 인스턴스 생성

  // ManagementViewModel의 생성자이다.
  //
  // ```dart
  // viewmodel = ManagementViewmodel();
  // ```
  //

  factory ManagementViewModel({required BuildContext context}) =>
      ManagementViewModel._privateConstructor(context: context);

  /// Firestore에서 NFC 태그 목록을 가져오는 비동기 함수
  static Future<List<NfcObject>> getNfcTagList() async {
    /// firestore에 접근하여 모든 데이터를 끌어옴
    var db = FirebaseFirestore.instance;
    List<NfcObject> tagList = [];

    /// try/catch 예외처리 함수
    try {
      /// 'classroom' 컬렉션에서 모든 문서 가져오기
      var event = await db.collection('classroom').get();

      /// 각 문서에 대해 반복
      for (var doc in event.docs) {
        /// 문서 데이터를 NfcObject로 변환하여 리스트에 추가
        final NfcObject nfc = NfcObject.fromJson(doc.data());
        tagList.add(nfc);
      }
    } catch (error, stackTrace) {
      debugPrint("에러 발생 : $error"); // 에러 메시지 출력
      debugPrint("스택 추적 : $stackTrace"); // 에러 스택 추적 정보 출력
    }

    return tagList;

    /// NFC 태그 목록 반환
  }

  /// NFC 태그를 수정하는 함수
  static Future<void> editNfcTag({
    required BuildContext context,
    required NfcObject tag,
    required String newLectureRoom,
  }) async {
    var db = FirebaseFirestore.instance.collection('classroom');

    try {
      /// UUID가 일치하는 문서 가져오기
      var queryTag = await db.where('uuid', isEqualTo: tag.uuid).get();

      /// 해당 문서의 강의실 정보 업데이트
      await queryTag.docs.first.reference
          .update({"lectureRoom": newLectureRoom});
    } catch (error, stackTrace) {
      debugPrint("에러 발생 : $error");
      debugPrint("스택 추적 : $stackTrace");
    }
  }
}
