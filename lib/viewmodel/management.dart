import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tag_management/model/nfc.dart';

// 서버에 등록된 강의실 정보를 변경. ( 즉, 정보를 가져와야 한다. )
// 전체 정보를 가져오는 함수 GetNfcObjectList()
// 태그의 강의실 정보를 변경하는 EditLectureRoom()

/// 태그의 강의실 정보 변경 기능을 수행하는 뷰모델 클래스이다.
class ManagementViewModel {
  // 싱글톤 패턴 선언부
  BuildContext context;

  ManagementViewModel._privateConstructor({required this.context});

  /// ManagementViewModel의 생성자이다.
  ///
  /// ```dart
  /// viewmodel = ManagementViewmodel();
  /// ```
  factory ManagementViewModel({required BuildContext context}) =>
      ManagementViewModel._privateConstructor(context: context);

  /// firestore로부터 불러 온 nfc 태그 객체들의 고유 uuid, 강의실 정보가 담겨 있는 리스트이다.
  List<NfcObject> _nfcObjectList = [];
  List<NfcObject> get nfcObjectList => _nfcObjectList;

  /// firestore의 NFC테이블에 등록된 전체 NFC 태그 정보를 가져오는 메서드.
  /// ```dart
  /// _cardDataList = viewmodel.GetNfcObjectList();
  /// ```
  Future<List<NfcObject>> getNfcTagList() async {
    // firestore에 접근하여 모든 데이터를 끌어온다.
    var db = FirebaseFirestore.instance;
    List<NfcObject> tagList = [];

    await db.collection('classroom').get().then((event) {
      for (var doc in event.docs) {
        final NfcObject nfc = NfcObject.fromJson(doc.data());
        tagList.add(nfc);
      }
    }).catchError((error, stackTrace) {
      debugPrint("에러 발생 : $error");
      debugPrint("스택 추적 : $stackTrace");
    });
    debugPrint(tagList.toString());



    return tagList;


  }

  void tagEdit(){
    ///서버에 등록된 태그 정보나 강의실 정보를 수정하는 기능입니다.

    ///태그 등록 당시 입력했던 강의실 위치(강의를 진행하는 과목의 이름을 바꾸는 경우가 아님) 반환하기
    ///강의실 위치 수정 시 (수정 내역을 업로드 할 수 있어야 함?)

    // 1. 변경할 태그 하나만 받아옴. 예) 선택된 태그

  }

  /// 데이터베이스의 강의실 정보를 변경하는 메서드.
  /// 변경할 태그를 식별할 uuid를 받고, 받은 lectureroom으로 DB 정보를 수정한다.
  ///
  /// ```dart
  /// setState(() {
  ///   viewmodel.EditLectureRoom()
  /// });
  /// ```
  Future<void> editNfcTag (
      {required BuildContext context,
      required NfcObject tag,
      required newLectureRoom}) async{
    // firestore에 접근해 입력받은 데이터를 전달하는 코드를 추후에 추가 예정.

    // 태그 테이블 정보 가져오기.
    var db = FirebaseFirestore.instance.collection('classroom');

    // 특정 객체의 내용을 데이터베이스 수정.
    var queryTag = await db.where('uuid', isEqualTo: tag.uuid).get();
    return queryTag.docs.first.reference.update({"lectureRoom": newLectureRoom});

    // 데이터베이스와 통신한 후 변경된 내용을 반영해야 하므로 view의 상태 또한 새로고침할 필요가 있다.
    // 해당 내용은 나중에 진행할 예정.
  }
}
