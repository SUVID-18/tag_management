import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:tag_management/model/nfc.dart';


/// NFC 태그를 읽고 쓰는 기능을 담은 뷰모델
class NfcManagementViewModel {
  /// NFC 태그 스티커에 기록된 dynamicLink를 수정하는 메서드. ( firebase 수정은 추후 작업 )
  ///
  /// NFC 태그 스티커에 정보 기입 시 동작을 나타내는 메서드로 [lectureRoom]에는 강의실 위치(ICT 404)가 전달되어야 하고
  /// [context]에는 현재의 `context`가 전달되어야 한다.
  ///
  /// 태그를 인식하는 동안에는 태그를 계속 붙이고 있으라는 안내창이 뜨며 정상 기입 시 정상 기입되었다는 메세지가
  /// 출력된다.
  ///
  /// ```dart
  /// var viewModel = NfcManagementViewModel();
  /// OutlinedButton(onPressed: () => viewModel.tagWrite('ICT 404', context), child: Text('태그 쓰기'))
  /// ```
  ///
  void tagWrite(String lectureRoom, BuildContext context) async {
    // 정보를 입력할 NFC 객체 생성
    NfcObject nfcObject = NfcObject(lectureRoom: lectureRoom);

    // 데이터베이스 수정을 위한 객체. 아직 사용 안함.
    Map<String, dynamic> json = nfcObject.toJson();

    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri(
          scheme: 'https',
          path: 'attendance',
          queryParameters: {'id': nfcObject.uuid}),
      uriPrefix: 'https://suvid.page.link',
      androidParameters: const AndroidParameters(
        packageName: 'com.suvid.check_attendance_student',
      ),
    );

    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    NdefMessage message =
        NdefMessage([NdefRecord.createUri(dynamicLink.shortUrl)]);
    // 비동기 코드 내에서 위젯을 띄울 시에는 `mounted`(위젯이 정상적으로 로드된 상태인지)된 경우에 진행하는게 맞음
    if (context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          title: Text('태그 기록'),
          content: Text('기록할 NFC 태그를 휴대전화 뒷면에 인식시켜주세요'),
        ),
      );
    }

    // 태그에는 firebase dynamic link 하나만 들어간다.
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);

      ndef?.write(message).then((value) {
        NfcManager.instance.stopSession();
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('태그 기입 완료')));
      }).catchError((_) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('태그 기입이 완료되지 않았습니다. 다시 시도하세요')));
      });

      // firestore 데이터베이스에 기록 부분은 생략.
    });
  }
}