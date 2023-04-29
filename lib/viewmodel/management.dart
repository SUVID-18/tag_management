import 'package:flutter/cupertino.dart';
import 'package:tag_management/model/nfc.dart';

// 서버에 등록된 강의실 정보를 변경. ( 즉, 정보를 가져와야 한다. )
// 전체 정보를 가져오는 함수 GetNfcObjectList()
// 태그의 강의실 정보를 변경하는 EditLectureRoom()

/// 태그의 강의실 정보 변경 기능을 수행하는 뷰모델 클래스이다.
class ManagementViewModel{
  // 싱글톤 패턴 선언부
  ManagementViewModel._privateConstructor();
  static final ManagementViewModel _instance = ManagementViewModel._privateConstructor();

  /// ManagementViewModel의 생성자이다.
  ///
  /// ```dart
  /// _viewmodel = ManagementViewmodel();
  /// ```
  factory ManagementViewModel() => _instance;

  /// firestore로부터 불러 온 nfc 태그 객체들의 고유 uuid, 강의실 정보가 담겨 있는 리스트이다.
  List<NfcObject> _nfcObjectList = [];

  List<NfcObject> get nfcObjectList => _nfcObjectList;

  /// firestore의 NFC테이블에 등록된 전체 NFC 태그 정보를 가져오는 메서드.
  /// ```dart
  /// _cardDataList = _viewmodel.GetNfcObjectList();
  /// ```
  List<NfcObject> GetNfcObjectList(){
    // firestore에 접근하여 모든 데이터를 끌어온다.

    // 지금은 firestore에서 정보를 가져오는 코드가 없어 임의로 변경할 정보를 넣어두었음.
    List<NfcObject> _nfcObjectList = [
      NfcObject(uuid: '123qe4', lectureRoom: 'IT 304'),
      NfcObject(uuid: '41awe', lectureRoom: 'IT 104'),
      NfcObject(uuid: '65fgsd', lectureRoom: 'IT 204'),
    ];
    return _nfcObjectList;
  }

  /// 데이터베이스의 강의실 정보를 변경하는 메서드.
  /// 변경할 태그를 식별할 uuid를 받고, 받은 lectureroom으로 DB 정보를 수정한다.
  void dbEdit(uuid, lectureroom){
    // firestore에 접근해 입력받은 데이터를 전달하는 코드를 추후에 추가 예정.
  }


}