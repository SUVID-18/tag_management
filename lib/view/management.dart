import 'package:flutter/material.dart';

/// 서버에 기등록된 강의실 정보를 변경하는 페이지 입니다.
class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _titleEditingController =
  TextEditingController();
  final TextEditingController _contentEditingController =
  TextEditingController();

  List<CardData> _cardDataList = [
    CardData(title: '고혁진', content: '105호'),
    CardData(title: '장성태', content: '418호'),
    CardData(title: '박필성', content: '108호'),
    CardData(title: '조영일', content: '517호'),
  ];

  void _showEditDialog(int index) {
    _titleEditingController.text = _cardDataList[index].title;
    _contentEditingController.text = _cardDataList[index].content;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Content'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleEditingController,
                decoration: InputDecoration(
                  hintText: 'Enter new title',
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _contentEditingController,
                decoration: InputDecoration(
                  hintText: 'Enter new content',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _cardDataList[index].title = _titleEditingController.text;
                  _cardDataList[index].content =
                      _contentEditingController.text;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('강의실 정보 수정 페이지'),
      ),
      body: ListView.builder(
        itemCount: _cardDataList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(_cardDataList[index].title),
                  subtitle: Text(_cardDataList[index].content),
                ),
                ButtonBar(
                  children: [
                    TextButton(
                      onPressed: () {
                        _showEditDialog(index);
                      },
                      child: Text('Edit'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _contentEditingController.dispose();
    super.dispose();
  }
}

class CardData {
  String title;
  String content;

  CardData({
    required this.title,
    required this.content,
  });
}
