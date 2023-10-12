import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/login.dart';

void main() {
  runApp(SignUpApp());
}

class SignUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final String apiUrl = "http://3.34.158.127:8080/api/v1/user/signup";

  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  Future<void> signup(BuildContext context) async {
    String id = idController.text;
    String password = passwordController.text;
    String name = nameController.text;
    String age = ageController.text;

    Map<String, dynamic> requestData = {
      'loginId': id,
      'password': password,
      'name': name,
      'age': age,
    };
    String jsonData = json.encode(requestData);

    print(jsonData);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );
      print(response);
      print(response.statusCode);
      if (response.statusCode == 201) {
        print("회원가입 성공");
        // 로그인 페이지로 이동
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginApp(), // LoginPage 대신 실제 로그인 페이지로 이동하려는 페이지로 교체
        ));
      }
    } catch(e) {
      print('에러 :e : $e');
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
                margin: EdgeInsets.all(100),
              ),
              Container(
                child: Text(
                  "회원가입",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromRGBO(148, 67, 251, 1.0),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
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
                margin: const EdgeInsets.all(10),
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "이름을 입력하세요",
                    hintText: '이름을 입력하세요',
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
                  controller: ageController,
                  decoration: const InputDecoration(
                    labelText: "나이를 입력하세요",
                    hintText: '나이를 입력하세요',
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
                  signup(context);
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
            ],
          ),
        ),
      ),
    );
  }
}
