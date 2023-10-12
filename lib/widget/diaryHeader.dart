import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container diaryHeader(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 40),
    alignment: Alignment.center,
    child: Column(
      children: [
        Image.asset("assets/diary.png", width: 100, height: 100,),
        Container(
          child: Text(
            "오늘의 감정일기",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24
            ),
          ),
        )
      ],
    )
  );
}