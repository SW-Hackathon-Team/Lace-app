import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/widget/diaryHeader.dart';
import 'package:app/diaryWrite.dart';

void main() {
  runApp(AnalyzeApp());
}

class AnalyzeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnalyzePage(),
    );
  }
}

class AnalyzePage extends StatefulWidget {
  @override
  _AnalyzePageState createState() => _AnalyzePageState();
}

class _AnalyzePageState extends State<AnalyzePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            diaryHeader(context),
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Text(
                  "작성된 일기가 없습니다"
              ),
            ),
            Container(
              width: 300,
              height: 48,
              margin: EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiaryApp(),
                    ),
                  );
                },
                child: Text("작성하기"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(148, 67, 251, 1.0),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 48),
              child: Text(
                "오늘의 감정일기",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24, right: 160),
              child: Text(
                "Lace의 일기 분석 결과",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color.fromRGBO(148, 67, 251, 1.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
