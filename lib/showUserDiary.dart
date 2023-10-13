import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app/login.dart';
import 'package:app/signup.dart';
import 'package:app/widget/diaryHeader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(ShowDiary());
}

class ShowDiary extends StatelessWidget {
  ShowDiary();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShowDiaryPage(),
    );
  }
}

class ShowDiaryPage extends StatefulWidget {
  @override
  State<ShowDiaryPage> createState() => _ShowDiaryState();
}

class _ShowDiaryState extends State<ShowDiaryPage> {
  String title='';
  String content='';
  Future<void> _show(BuildContext context) async {
    String apiUrl = 'http://3.34.158.127:8080/api/v1/diary';
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('accessToken');
    print(token);

    if (token != null && token.isNotEmpty) {
      try {
        final response = await http.get(
            Uri.parse(apiUrl),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
        );
        print(response.body);


        if(response.statusCode == 200) {
          print("요청성공");

          // JSON 문자열을 파싱하여 Map으로 변환
          Map<String, dynamic> jsonMap = json.decode(response.body);

          title = jsonMap['title'];

          print(title);

          content = jsonMap['content'];
          print(content);
        }
      } catch(e) {
        print("요청 실패");
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _show(context);
    return Scaffold(
      body: Column(
        children: [
          diaryHeader(context),

          Container(
            margin: EdgeInsets.only(right: 26, left: 26, top: 20),
            height: 350,
            width: 500,
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 시작 부분에 정렬
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, left: 30),
                  height: 250,
                  width: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 40
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          content,
                          style: TextStyle(
                              fontSize: 20
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
