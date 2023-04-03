import 'package:flutter/material.dart';

/// 서버에 기등록된 강의실 정보를 변경하는 페이지 입니다.
class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
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
        title: const Text('수원대학교 출석'), ///앱 상단 제목

        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
                icon: Icon(Icons.people_alt),
                child: Text("학생정보")
            ),
            Tab(
                icon: Icon(Icons.checklist_sharp),
                child: Text("출석체크")
            ),
            Tab(
                icon: Icon(Icons.manage_search),
                child: Text("출결확인")
            ),


          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(

            child: Text("학생정보 관리하는 화면"),
          ),
          Center(
            child: Text("출석체크 하는 화면"),
          ),
          Center(
            child: Text("출결 확인하는 화면"),
          ),
        ],
      ),
    );
  }
}
