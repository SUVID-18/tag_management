import 'package:uuid/uuid.dart';

class Supervisor {
  String name;

  /// tag_management 앱 관리자를 만드는 생성자
  ///
  /// 관리자의 이름을 담고 있는 객체를 생성한다.
  /// Firestore로부터 관리자의 정보를 불러온다. 관리자는 이름을 제외하곤 앱 내에서 사용할 정보가 없다.
  Supervisor({required this.name});

  /// [json]에서 객체를 역직렬화 하는 경우(NFC 객체로 가져오기) 사용되는 `factory` 생성자
  ///
  /// `Firestore`에서 받은 데이터를 [NfcObject]객체로 반환하는 메서드로 [json]에
  /// `Firestore`에서 받은 데이터를 넣으면 된다.
  ///
  /// ```dart
  /// final supervisorRef = db.collection('supervisor').doc('test');
  /// supervisorRef.get().then(
  ///   (DocumentSnapshot doc) {
  ///     final supervisor = Supervisor.fromJson(jsonDecode(doc.data()));
  ///    },
  ///    onError: (e) => print('Error Detected: $e'),
  ///   );
  /// ```
  factory Supervisor.fromJson(Map<String, dynamic> json) =>
      Supervisor(name: json['name']);

  /// 객체를 `JSON`으로 직렬화 하는 메서드
  ///
  /// 객체를 `Firestore`에게 쉽게 올릴 수 있도록 직렬화를 수행한다.
  /// 이 메서드는 별도로 호출될 필요 없이 `jsonEncode()`메서드에 사용된다.
  ///
  /// ```dart
  /// String json = jsonEncode(nfc_object);
  /// ```
  Map<String, dynamic> toJson() => {'name': name};
}
