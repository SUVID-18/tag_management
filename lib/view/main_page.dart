import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 홈 화면을 나타내는 페이지 입니다.
class MainPage extends StatelessWidget {
  /// 앱의 이름에 해당되는 변수입니다.
  final String appName;
  const MainPage({required this.appName, Key? key}) : super(key: key);


  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

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
    return MaterialApp(
      title: 'Flutter App with Card Widget in AppBar',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('수원대학교 출결 시스템'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                icon: Icon(Icons.people_alt),
                  child: Text("학생정보")
              ),
              Tab(
                icon: Icon(Icons.checklist),
                  child: Text("출석체크")
              ),
              Tab(
                icon: Icon(Icons.manage_search_outlined),
                  child: Text("출결확인")
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
              child: const SizedBox(
                width: 500,
                height: 500,
                child:Image(
                  image: NetworkImage('https://img.freepik.com/premium-vector/contactless-payment-logo-nfc-icon-nfc-letter-logo-nfc-payments-icon-for-apps_185004-435.jpg?w=826'),
                )
                ),
              ),
            ),
          ),
        )
      );
  }
}
