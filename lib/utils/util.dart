import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String accessTokenKey = 'accessToken';
final String refreshTokenKey = 'refreshToken';

bool isLoggedIn = false;

Future<void> saveAccessToken(String token) async {
  try {
    if (token != null && token.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', token);
    }
  } catch (e) {
    print(e);
  }
}

Future<void> saveRefreshToken(String token) async {
  try {
    if (token != null && token.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('refreshToken', token);
    }
  } catch (e) {
    print(e);
  }
}

Future<void> saveClientName(String name) async {
  try {
    if (name != null && name.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('clientName', name);
    }
  } catch (e) {
    print(e);
  }
}

Future<Map> loadSavedData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? accessToken = prefs.getString(accessTokenKey);
  if (accessToken != null) {
    print('액세스 토큰: $accessToken');
  } else {
    print('저장된 액세스 토큰이 없습니다.');
    //다시 로그인창으로 보내야됨. ok?
  }

  String? refreshToken = prefs.getString(refreshTokenKey);
  if (refreshToken != null) {
    print('리프레시 토큰: $refreshToken');
  } else {
    print('저장된 리프레시 토큰이 없습니다.');
  }

  return {
    "accessToken": accessToken,
    "refreshToken": refreshToken
  };
}

