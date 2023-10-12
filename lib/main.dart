import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/chat.dart';
import 'package:app/utils/util.dart';
import 'package:app/diaryWrite.dart';

const String accessTokenKey = 'accToken';
const String refreshTokenKey = 'refToken';
const String userPointKey = 'userPoint';

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

  @override
  void initState() {
    super.initState();
    isLoggedIn = widget.initialLoggedInState;
    loadSavedData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 90, left: 30),
              child: Row(
                children: [
                  Image.asset(
                    "assets/logo.png",
                    width: 70,
                    height: 70,
                  ),
                  const Text(
                    "고민해결사 Lace에게\n고민을 털어보세요",
                    style: TextStyle(
                        color: Color.fromRGBO(148, 67, 251, 1.0),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            // Container(
            //   margin: const EdgeInsets.only(top: 10),
            // ),
            Container(
              margin: EdgeInsets.only(right: 26, left: 26),
              height: 280,
              width: 500,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  chatBox(text: '친구랑 싸웠어 ㅠㅠ', widthIndex: 145, leftIndex: 170),
                  chatBox(
                      text: '우울 할때 든는 음악 추천 해줘',
                      widthIndex: 195,
                      leftIndex: 100),
                  chatBox(
                      text: '요즘 번아웃이 온 것 같아', widthIndex: 173, leftIndex: 130),
                  Container(
                      margin: EdgeInsets.only(left: 10, right: 26, top: 45),
                      height: 30,
                      width: 180,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(148, 67, 251, 1.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              blurRadius: 5.0,
                              spreadRadius: 0.0,
                              offset: const Offset(0, 1),
                            )
                          ],
                          border:
                          Border.all(color: Color.fromRGBO(124, 0, 249, 1)),
                          borderRadius: BorderRadius.circular(40)),
                      child: const Center(
                          child: Text(
                            "그렇다면 이렇게 해보세요",
                            style: TextStyle(color: Colors.white),
                          )
                      )
                  ),
                  Container(
                    // color: Color.fromRGBO(124, 0, 249, 1),
                    margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: ()
                            {
                              FlutterDialog(context);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(112, 0, 242, 1.0),
                              ),
                            ),
                            child: const Text(
                              "상담요청하러 가기",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 16),
            ),


            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Row(
                children: [
                  Image.asset(
                    "assets/diary.png",
                    width: 80,
                    height: 80,
                  ),
                  const Text(
                    "고민해결사 Lace에게\n고민을 털어보세요",
                    style: TextStyle(
                        color: Color.fromRGBO(148, 67, 251, 1.0),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),


            Container(
              margin: EdgeInsets.only(right: 26, left: 26),
              height: 280,
              width: 500,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 26, top: 20),
                    height: 30,
                    width: 300,
                    decoration: BoxDecoration(
                      border:
                      Border.all(color: Colors.transparent),
                    ),
                    child: Text(
                      "000 님 일기분석 결과를 살펴보아요",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(148, 67, 251, 1.0),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Container(
                    width: 1000,
                    height: 180,
                    child: Image.asset("assets/graph.png"),
                  ),
                  Container(
                    width: 400,
                    height: 34,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: ElevatedButton(
                      onPressed: ()
                      {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DiaryApp(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(112, 0, 242, 1.0),
                        ),
                      ),
                      child: const Text(
                        "작성하러 가기",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  Container(margin: EdgeInsets.only(top: 8, bottom: 2),)
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}

void FlutterDialog(BuildContext context) {
  List<bool> holymoly = [false, false, false, false, false];
  List<String> titleList = ["사춘기", "우울감", "문제 해결", "스트레스", "번아웃"];
  showDialog(
      context: context,
      //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
      barrierDismissible: false,
      builder: (BuildContext context) {
      return StatefulBuilder( // Add this to your code.
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            //Dialog Main Title
            title: const Center(child: Text("원활한 상담사 매칭을 위해 원하는 상담 유형을 선택해주세요.")),
            content: Wrap(
              direction: Axis.horizontal, // 정렬 방향
              alignment: WrapAlignment.center, // 정렬 방식
              children:<Widget>[
                for(int i=0; i<5; i++)
                  Padding(
                    padding: EdgeInsets.all(1),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          for(int j=0; j< holymoly.length; j++){
                            if(j == i){
                              holymoly[j] = true;
                            } else {
                              holymoly[j] = false;
                            }
                          }
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 85,
                        decoration:
                        BoxDecoration(borderRadius:
                        BorderRadius.circular(30),
                          border:
                          Border.all(color:(holymoly[i]) ? Color.fromRGBO(145, 59, 255, 1) : Colors.grey),
                        ),
                        child: Center(
                          child: Text(titleList[i], style: TextStyle(fontSize :20))
                        ),
                      ),
                    ),
                  )
              ],
            ),
            actions: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatApp(),
                    ),
                  );
                },
                child: Container(
                  height: 44,
                  width: 308,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(145, 59, 255, 1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      // color: Colors.transparent
                    )
                  ),
                  child: const Center(child: Text("요청하기", style: TextStyle(color: Colors.white, fontSize: 28))),
                ),
              )
            ],
          );
        });
      }
    );
}


Widget chatBox(
    {required String text,
    required double widthIndex,
    required double leftIndex}
    )
{
  return Container(
      margin: EdgeInsets.only(left: leftIndex, right: 26, top: 15),
      height: 30,
      width: 1340,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              blurRadius: 5.0,
              spreadRadius: 0.0,
              offset: const Offset(0, 1),
            )
          ],
          border: Border.all(
            color: Color.fromRGBO(148, 67, 251, 1.0),
          ),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
          child: Text(text)
      ),
  );
}
