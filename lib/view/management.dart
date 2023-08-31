import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Firebase Firestore 인스턴스 생성
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _contentEditingController =
      TextEditingController();

//  위 코드에서 _firestore 변수를 사용하여 Firestore 인스턴스를 생성하고,
//  _loadCardDataList 메서드 내에서 Firestore에서 데이터를 가져오도록 변경하였습니다.
//  또한 수정된 정보를 Firestore에 업데이트하는 코드도 추가하였습니다.
//  위 코드를 실행하면 각 카드의 수정 버튼을 눌러 정보를 수정할 수 있고,
//  수정 사항이 Firebase Firestore에 자동으로 업데이트됩니다.

  List<CardData> _cardDataList = [];

  @override
  void initState() {
    super.initState();
    _loadCardDataList();
  }

  /// Firestore에서 데이터를 가져와 _cardDataList에 저장하는 메서드
  Future<void> _loadCardDataList() async {
    QuerySnapshot snapshot = await _firestore.collection('classroom').get();
    List<CardData> cardDataList = [];

    for (QueryDocumentSnapshot doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      cardDataList.add(CardData(
        title: data['title'] ?? '',
        content: data['content'] ?? '',
      ));
    }

    setState(() {
      _cardDataList = cardDataList;
    });
  }

  /// 카드 정보를 수정하는 다이얼로그를 표시하는 메서드
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
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () async {
                /// 수정된 정보를 Firestore에 업데이트하는 코드
                await _firestore
                    .collection('classroom')
                    .doc(index.toString())
                    .update({
                  'title': _titleEditingController.text,
                  'content': _contentEditingController.text,
                });
                _loadCardDataList();

                /// 데이터 다시 로드
                Navigator.pop(context);
              },
              child: Text('확인'),
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
                      child: Text('수정'),
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
    /// 페이지가 종료될 때, 사용한 TextEditingController들을 정리(dispose)합니다.
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