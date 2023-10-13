import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/widget/diaryHeader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/showUserDiary.dart';

import 'main.dart';

void main() {
  runApp(DiaryApp());
}

class DiaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DiaryPage(),
    );
  }
}

class DiaryPage extends StatefulWidget {
  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final String apiUrl = 'http://3.34.158.127:8080/api/v1/diary';
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  String mood="";

  String responseText = "";

  Future<void> _write(BuildContext context) async {
    String title = titleController.text;
    String content = contentController.text;

    Map<String, dynamic> requestData = {
      'title': title,
      'content': content,
      'mood': mood
    };
    String jsonData = json.encode(requestData);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('accessToken');
    print(token);

    if (token != null && token.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonData,
        );

        print(response.statusCode);

        print(response.body);

        if (response.statusCode == 201) {
          responseText="감정일기를 적었습니다";
          print(responseText);

          // 성공적으로 감정일기를 적었을 때, 필요한 작업을 수행하십시오.
          // 예를 들어, 적었던 일기 내용을 초기화하거나 홈 화면으로 이동할 수 있습니다.
          print(response.body);

          // titleController와 contentController를 초기화
          titleController.clear();
          contentController.clear();

          // mood 초기화 (선택한 감정 리셋)
          mood = "";

          // 이동하려는 화면 또는 다른 동작을 수행할 수 있습니다.
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ShowDiary(),
            ),
          );
        }
      } catch (e) {
        print(e);
        responseText='$e';
      }
    }
  }


  @override
  Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              diaryHeader(context),
              Container(
                margin: EdgeInsets.only(top: 40),
              ),

              SizedBox(
                width: 300,
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: '제목을 입력해주세요',
                    hintText: '제목을 입력해주세요',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.black12),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  maxLines: 10,
                  controller: contentController,
                  decoration: InputDecoration(
                    labelText: '내용을 작성해주세요',
                    hintText: '내용을 작성해주세요',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.black12),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 10),
              ),

              Container(
                margin: const EdgeInsets.only(top:20,left: 20, right: 20),
                child: const Text(
                  "오늘 감정을 선택해주세요.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      print("1번 클릭");
                      mood="TIRED";
                    },
                    child: Image.asset(
                      "assets/face1.png",
                      width: 32,
                      height: 32,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      print("2번 클릭");
                      mood="WONDER";
                    },
                    child: Image.asset(
                      "assets/face2.png",
                      width: 32,
                      height: 32,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      print("3번 클릭");
                      mood="HAPPY";
                    },
                    child: Image.asset(
                      "assets/face3.png",
                      width: 32,
                      height: 32,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      print("4번 클릭");
                      mood="SAD";
                    },
                    child: Image.asset(
                      "assets/face4.png",
                      width: 32,
                      height: 32,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      print("5번 클릭");
                      mood="ANGRY";
                    },
                    child: Image.asset(
                      "assets/face5.png",
                      width: 32,
                      height: 32,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                width: 320,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    _write(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromRGBO(148, 67, 251, 1.0),
                    ),
                  ),
                  child: const Text(
                    "완료",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
  }
}
