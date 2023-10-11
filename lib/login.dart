import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/main.dart';
import 'package:app/utils/util.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(initialLoggedInState: false),
    );
  }
}

class LoginPage extends StatefulWidget {
  bool initialLoggedInState;

  LoginPage({Key? key, required this.initialLoggedInState}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String apiUrl = "http://3.34.158.127:8080/api/v1/user/login";

  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String responseText = "";

  Future<void> _login(BuildContext context) async {
    String id = idController.text;
    String password = passwordController.text;

    Map<String, dynamic> requestData = {
      'email': id,
      'password': password,
    };
    String jsonData = json.encode(requestData);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        print("로그인 성공!");

        final jsonResponse = json.decode(response.body);
        final accessToken = jsonResponse['accessToken'];
        final refreshToken = jsonResponse['refreshToken'];

        // 액세스 토큰을 저장합니다.
        saveAccessToken(accessToken);  // 액세스 토큰 저장 함수를 정의해야 합니다.
        // 리플레쉬 토큰을 저장합니다
        // saveRefreshToken(refreshToken);  // 리플레쉬 토큰 저장 함수를 정의해야 합니다.
        widget.initialLoggedInState = true;

        // 초기 로그인 상태를 설정하고 메인 앱으로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp(initialLoggedInState: widget.initialLoggedInState),
          ),
        );
      } else {
        setState(() {
          if (response.statusCode == null) {
            responseText = "로그인 실패: 응답 상태 코드 없음";
          } else {
            responseText = "로그인 실패: ${response.statusCode}";
          }
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        responseText = "오류 발생: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(150),
              ),
              Container(
                child: Text(
                  "로그인",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromRGBO(148, 67, 251, 1.0),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: idController,
                  decoration: const InputDecoration(
                    labelText: '아이디를 입력해주세요',
                    hintText: '아이디를 입력해주세요',
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
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: '비밀번호를 입력해주세요',
                    hintText: '비밀번호 입력',
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
                margin: EdgeInsets.all(10),
              ),
              ElevatedButton(
                onPressed: () {
                  _login(context);
                },
                child: Text("로그인"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(148, 67, 251, 1.0),
                  minimumSize: Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                  shadowColor: Colors.grey,
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  responseText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
