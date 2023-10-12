import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/widget/diaryHeader.dart';
import 'package:app/utils/util.dart';

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


    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "":'Barear $token'
        },
        body: json.encode(requestData),
      );

      print(jsonData);

      print(response.body);

      if (response.statusCode == 200) {
        print("챗GPT 응답성공");

        final jsonResponse = json.decode(response.body);

        responseText = jsonResponse;
      }
    } catch(e) {
      print(e);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 680, left: 20, right: 20),
                    child: const SizedBox(
                      width: 300,
                      child: TextField(
                        controller: questionController,
                        obscureText: true,
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
                    margin: EdgeInsets.only(top: 675, right: 20),
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