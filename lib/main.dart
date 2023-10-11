import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String accessTokenKey = 'accToken';
final String refreshTokenKey = 'refToken';
final String userPointKey = 'userPoint';

void main() async {
  runApp(
    MaterialApp(
      home: MyApp(initialLoggedInState: false),
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool initialLoggedInState;

  MyApp({required this.initialLoggedInState});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  int? userPoint;

  @override
  void initState() {
    super.initState();
    isLoggedIn = widget.initialLoggedInState;
    loadSavedData();
  }

  // 사용자 로그인 또는 로그아웃 상태를 업데이트하는 함수
  void updateLoginStatus(bool status) {
    setState(() {
      isLoggedIn = status;
    });
  }

  Future<void> loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? accessToken = prefs.getString(accessTokenKey);
    if (accessToken != null) {
      print('액세스 토큰: $accessToken');
    } else {
      print('저장된 액세스 토큰이 없습니다.');
    }

    String? refreshToken = prefs.getString(refreshTokenKey);
    if (refreshToken != null) {
      print('리프레시 토큰: $refreshToken');
    } else {
      print('저장된 리프레시 토큰이 없습니다.');
    }
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('accToken'); // 수정: 'accToken' 대신 변수 사용
    prefs.remove('refToken');
    print("removed userData");

    setState(() {
      isLoggedIn = !isLoggedIn; // 로그인 상태를 변경
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
