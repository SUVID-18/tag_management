import 'package:flutter/material.dart';
import 'package:tag_management/view/management.dart';
import 'package:tag_management/view/settings.dart';

/// 홈 화면을 나타내는 페이지 입니다.

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required String appName}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TAG 유지보수'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(icon: Icon(Icons.sticky_note_2), child: Text("스티커 등록")),
              Tab(icon: Icon(Icons.pan_tool), child: Text("기존 정보 관리")),
              Tab(
                icon: Icon(Icons.settings),
                  child: Text("환경 설정")
              ),
            ],
          ),
        ),
        body: TabBarView(controller: _tabController, children: [
          Center(
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  ///탭 동작 수행
                  debugPrint('Card tapped.');
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('새 강의실 이름 입력'),
                        content: TextField(),
                        actions: [
                          TextButton(onPressed: null, child: Text('확인'))
                        ],
                      );
                    },
                  );
                },
                child: SizedBox(
                  width: 500,
                  height: 500,
                  child: Image.asset('assets/images/swu_bluelogo.png'),
                ),
              ),
            ),
          ),
          ManagementPage(),
          SettingsPage(
            username: '한동민',
            onLogout: () {},
          ),
        ]));
  }
}