import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/widget/diaryHeader.dart';

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
    print(jsonData);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(requestData),
      );

      print(jsonData);

      print(response.body);
    } catch (e) {
      print(e);
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

              const SizedBox(
                width: 300,
                child: TextField(
                  // controller: titleController,
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
              const SizedBox(
                width: 300,
                child: TextField(
                  maxLines: 10,
                  // obscureText: true,
                  // controller: contentController,
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
                      mood="피곤함";
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
                      mood="놀라움";
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
                      mood="기쁨";
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
                      mood="슬픔";
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
                      mood="화남";
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
