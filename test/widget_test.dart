// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:tag_management/main.dart';

void main() {
  testWidgets('앱이 정상적으로 실행 되는지 확인', (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(App());
    });
  });
}