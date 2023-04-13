import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tag_management/model/nfc.dart';
// import 'package:uuid/uuid.dart';

void main() {
  group('NFC 객체 테스트', () {
    test('NFC 객체가 정상적으로 생성되는지 테스트', () {
      final object = NfcObject(lectureRoom: 'IT 404호', uuid: 'not-found-404');
      expect(object.lectureRoom, 'IT 404호');
    });
    test('NFC 객체의 직렬화 테스트', () {
      final object = NfcObject(lectureRoom: 'IT 404호', uuid: 'not-found-404');
      final jsonData = jsonEncode(object);
      expect(NfcObject.fromJson(jsonDecode(jsonData)).uuid, 'not-found-404');
    });
  });
}
