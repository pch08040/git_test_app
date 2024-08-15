import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_git_scroll/api/gitsubdata.dart';
import 'package:http/http.dart' as http;

class SubApiProvider extends ChangeNotifier {
  List<GitSubData> data = [];
  final String name;

  SubApiProvider({required this.name});

  Future<void> subStarted() async {
    List<GitSubData>? result = await _subGetData();
    data = result;
    notifyListeners();
  }

  // 받은 login 정보로 레파지토리 url에 접근해서 api정보 송출
  Future<List<GitSubData>> _subGetData() async {
    try {
      http.Response response = await http.get(
        Uri.parse("https://api.github.com/users/$name/repos"),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<GitSubData> result =
            data.map((e) => GitSubData.fromJson(e)).toList();
        return result;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
