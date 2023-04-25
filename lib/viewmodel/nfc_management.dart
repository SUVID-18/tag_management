import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:tag_management/model/nfc.dart';
import 'package:nfc_manager/nfc_manager.dart';


/// NFC 태그를 읽고 쓰는 기능을 담은 뷰모델
class NfcManagementViewModel {

}
  /// NFC 태그 스티커에 기록된 dynamicLink를 수정하는 메서드. ( firebase 수정은 추후 작업 )
  void tagWrite(String? uuid, String lectureRoom){
    // 정보를 입력할 NFC 객체 생성
    NfcObject nfcObject = NfcObject(uuid: uuid, lectureRoom: lectureRoom);

    // 데이터베이스 수정을 위한 객체. 아직 사용 안함.
    Map<String, dynamic> json = nfcObject.toJson();

    // 태그에는 firebase dynamic link 하나만 들어간다.
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async{
      var ndef = Ndef.from(tag);

      final dynamicLinkParams = DynamicLinkParameters(
        link: Uri.parse('https://suvid.page.link/attendance?${nfcObject.uuid}'),
        uriPrefix: 'https://suvid.page.link',
        androidParameters: const AndroidParameters(
          packageName: 'com.suvid.check_attendance_student',
        ),
      );

      final dynamicLink = await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);

      NdefMessage message = NdefMessage([NdefRecord.createUri(dynamicLink)]);

      try{
        await ndef?.write(message);
        NfcManager.instance.stopSession();
      } catch(e){
        NfcManager.instance.stopSession(errorMessage: e.toString());
      }

      // firestore 데이터베이스에 기록 부분은 생략.
    });
}