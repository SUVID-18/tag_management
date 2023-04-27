import 'package:uuid/uuid.dart';

class NfcObject {
  /// NFC 태그의 UUID(자동 생성됨)
  String get uuid => _uuid;

  /// 강의실 이름(예시: IT 404호)
  String lectureRoom;

  String _uuid = const Uuid().v4();

  /// 강의실 태그 정보를 업로드 하기 위한 생성자
  ///
  /// 강의실 태그에 관한 정보를 담고있는 객체의 생성자이다. [lectureRoom]에 강의실 위치(IT 404호)를
  /// 기입하면 된다. [uuid]의 경우 자동으로 생성되기 때문에 명시적으로 매개변수를 전달할 필요가 없다.
  NfcObject({String? uuid, required this.lectureRoom}) {
    if (uuid != null) {
      _uuid = uuid;
    }
  }

  /// [json]에서 객체를 역직렬화 하는 경우(NFC 객체로 가져오기) 사용되는 `factory` 생성자
  ///
  /// `Firestore`에서 받은 데이터를 [NfcObject]객체로 반환하는 메서드로 [json]에
  /// `Firestore`에서 받은 데이터를 넣으면 된다.
  ///
  /// ```dart
  /// final lectureRoomRef = db.collection('lectureRooms').doc('test');
  /// lectureRoomRef.get().then(
  ///   (DocumentSnapshot doc) {
  ///     final student = NfcObject.fromJson(jsonDecode(doc.data()));
  ///    },
  ///    onError: (e) => print('Error Detected: $e'),
  ///   );
  /// ```
  factory NfcObject.fromJson(Map<String, dynamic> json) =>
      NfcObject(uuid: json['uuid'], lectureRoom: json['lectureRoom']);

  /// 객체를 `JSON`으로 직렬화 하는 메서드
  ///
  /// 객체를 `Firestore`에게 쉽게 올릴 수 있도록 직렬화를 수행한다.
  /// 이 메서드는 별도로 호출될 필요 없이 `jsonEncode()`메서드에 사용된다.
  ///
  /// ```dart
  /// String json = jsonEncode(nfc_object);
  /// ```
  Map<String, dynamic> toJson() => {'uuid': uuid, 'lectureRoom': lectureRoom};
}
