import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tag_management/model/nfc.dart';
import 'package:tag_management/viewmodel/management.dart';
// import 'package:uuid/uuid.dart';

void main() {
  group('ManagementViewmodel 테스트', () {
    test('GetNfcObjectList 테스트', () {
      final viewmodel = ManagementViewModel();
      List<NfcObject> list = viewmodel.GetNfcObjectList();
      expect(list[0].lectureRoom, 'IT 304');
    });
  });
}
