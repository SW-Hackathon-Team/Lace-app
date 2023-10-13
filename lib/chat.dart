import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/widget/diaryHeader.dart';
import 'package:app/utils/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final String apiUrl = "http://3.34.158.127:8080/api/v1/gpt/solution";

  final TextEditingController questionController = TextEditingController();
  String responseText = "";

  Future<void> _chat(BuildContext context) async {
    String question = questionController.text;

    Map<String, dynamic> requestData = {
      'question': question,
    };
    String jsonData = json.encode(requestData);
    print(jsonData);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString(accessTokenKey);

    if(token != null && token != "") {
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode(requestData),
        );
        print(jsonData);

        print(response.body);
        print(response.statusCode);

        if (response.statusCode == 200) {
          print("챗GPT 응답성공");

          final jsonResponse = json.decode(response.body);
          print(jsonResponse);

          responseText = jsonResponse;
        }
      } catch(e) {
        print(e);
        responseText="$e";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 64),
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/logo.png",
                  width: 100,
                  height: 100,
                ),
              ),


              Expanded(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 26, left: 26),
                          height: 600,
                          width: 1000,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(questionController.text,
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                              ),

                              Container(
                                child: Text(
                                  responseText,
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),







              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 24),
                    child: SizedBox(
                      width: 300,
                      child: TextField(
                        // controller: questionController,
                        controller: questionController,
                        decoration: InputDecoration(
                          labelText: 'Lace에게 고민을 말해주세요',
                          hintText: 'Lace에게 고민을 말해주세요',
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
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, right: 16, bottom: 24),
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        _chat(context);
                      },
                      child: Image.asset(
                          "assets/send.png"
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}