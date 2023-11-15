import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tag_management/model/nfc.dart';

// 서버에 등록된 강의실 정보 및 태그 정보를 가져오는 기능을 담당하는 뷰모델이다.
// 전체 정보를 가져오는 함수 GetNfcObjectList()
// 태그의 강의실 정보를 변경하는 EditLectureRoom()

/// 태그 조회 및 강의실 정보 변경 기능을 수행하는 뷰모델 클래스이다.
class ManagementViewModel {
  // 싱글톤 패턴 선언부
  BuildContext context;

  /// 새로운 강의실 이름을 입력받는 컨트롤러
  final roomNumberController = TextEditingController();
  ManagementViewModel._privateConstructor({required this.context});

  /// ManagementViewModel의 생성자이다.
  ///
  /// ```dart
  /// viewmodel = ManagementViewmodel();
  /// ```
  factory ManagementViewModel({required BuildContext context}) =>
      ManagementViewModel._privateConstructor(context: context);

  /// firestore의 NFC테이블에 등록된 전체 NFC 태그 정보를 가져오는 메서드.
  /// ```dart
  /// List<NfcObject> _cardDataList = [];
  /// _cardDataList = viewmodel.getNfcTagList();
  /// ```
  Stream<List<NfcObject>> getNfcTagList() {
    // firestore에 접근하여 모든 데이터를 끌어온다.
    var db = FirebaseFirestore.instance;
    return db.collection('classroom').snapshots().map((event) =>
        event.docs.map((e) => NfcObject.fromJson(e.data())).toList());
  }

  /// 데이터베이스의 강의실 정보를 변경하는 메서드.
  /// 변경할 태그를 식별할 uuid를 받고, 받은 lectureroom으로 DB 정보를 수정한다.
  ///
  /// ```dart
  ///   // 입력할 NfcObject nfc 생성
  ///   viewmodel.EditLectureRoom({
  ///     context : context,
  ///     tag : nfc,
  ///     newLectureRoom : 'IT101'
  ///   })
  /// });
  /// ```
  Future<void> editNfcTag (
      {required BuildContext context, required NfcObject tag}) async {
    // firestore에 접근해 입력받은 데이터를 전달하는 코드를 추후에 추가 예정.

    // 태그 테이블 정보 가져오기.
    var db = FirebaseFirestore.instance.collection('classroom');

    // 특정 객체의 내용을 데이터베이스 수정.
    var queryTag = await db.where('tag_uuid', isEqualTo: tag.uuid).get();
    var newLectureRoom = roomNumberController.text;
    roomNumberController.text = '';
    return queryTag.docs.first.reference.update({'name': newLectureRoom});

    // 데이터베이스와 통신한 후 변경된 내용을 반영해야 하므로 view의 상태 또한 새로고침할 필요가 있다.
    // 해당 내용은 나중에 진행할 예정.
  }
}