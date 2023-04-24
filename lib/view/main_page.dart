import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          title: const Text('수원대학교 TAG 유지보수'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                  icon: Icon(Icons.sticky_note_2),
                  child: Text("스티커 등록")
              ),
              Tab(
                  icon: Icon(Icons.medical_information_outlined),
                  child: Text("기존 정보 관리")
              ),
              Tab(
                  icon: Icon(Icons.settings),
                  child: Text("환경 설정")
              ),
            ],
          ),
        ),


        body: Center(
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () { ///탭 동작 수행
                debugPrint('Card tapped.');
              },
              child: SizedBox(
                width: 500,
                height: 500,
                child: Image.asset('assets/images/swu_bluelogo.png'),
                ),
              ),
            ),
          ),
        );
  }
}