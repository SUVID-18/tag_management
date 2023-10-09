import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tag_management/view/management.dart';
import 'package:tag_management/view/settings.dart';
import 'package:tag_management/viewmodel/nfc_management.dart';

/// 홈 화면을 나타내는 페이지 입니다.

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required String appName}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var navgationList = [
      const NavigationRailDestination(
          icon: Icon(Icons.sticky_note_2_outlined), label: Text('스티커 등록')),
      const NavigationRailDestination(
          icon: Icon(Icons.pan_tool_alt_outlined), label: Text('기존 정보 관리')),
      const NavigationRailDestination(
          icon: Icon(Icons.supervised_user_circle_outlined),
          label: Text('사용자 설정')),
    ];

    var viewModel = NfcManagementViewModel();

    return Scaffold(
        appBar: AppBar(
          title: const Text('TAG 유지보수'),
        ),
        body: Row(
          children: [
            NavigationRail(
              labelType: NavigationRailLabelType.selected,
              destinations: navgationList,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (value) => setState(() {
                _selectedIndex = value;
              }),
            ),
            if (_selectedIndex == 0) ...[
              Flexible(
                child: Center(
                  child: OutlinedButton(
                    child: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      {
                        var textController = TextEditingController();

                        ///탭 동작 수행
                        debugPrint('Card tapped.');
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: const Text('새 강의실 이름 입력'),
                              content: TextField(
                                controller: textController,
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      if (textController.text.isEmpty) {
                                        showDialog(
                                          context: dialogContext,
                                          builder: (context) => AlertDialog(
                                            title: const Text('경고'),
                                            content: const Text(
                                                '강의실 이름을 입력하지 않았습니다.'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      context.pop(),
                                                  child: const Text('확인'))
                                            ],
                                          ),
                                        );
                                      } else {
                                        viewModel.tagWrite(
                                            textController.text, context);
                                      }
                                    },
                                    child: const Text('확인'))
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              )
            ] else if (_selectedIndex == 1) ...[
              const Flexible(child: ManagementPage())
            ] else ...[
              const Flexible(child: SettingsPage())
            ]
          ],
        ));
  }
}
