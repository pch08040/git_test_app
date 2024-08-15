import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_git_scroll/api/gitdata.dart';

class ApiProvider extends ChangeNotifier {
  List<GitHubUser> user = [];
  int currentPageNo = 1;
  // 로딩을 위한 bool 변수
  bool isAdd = false;

  // 시작시 데이터 넣어주는 함수
  Future<void> started() async {
    await _getData();
  }

  // 최대 스크롤 가능한 범위의 85% 도달했는지 판단 후 Data를 가져옴
  void scrollListerner(ScrollUpdateNotification notification) {
    if (notification.metrics.maxScrollExtent * 0.85 <
        notification.metrics.pixels) {
      _moreData();
    }
  }

  // 페이지가 스크롤 되면 새로운 페이지와 정보를 받아옴
  Future<void> _moreData() async {
    if (!isAdd) {
      isAdd = true;
      notifyListeners();
      List<GitHubUser>? _data = await _fetchPost(pageNo: currentPageNo);
      Future.delayed(Duration(microseconds: 1000), () {
        user.addAll(_data);
        currentPageNo = currentPageNo + 1;
        isAdd = false;
        notifyListeners();
      });
    }
  }

  // 초기 로딩 값 세팅
  Future<void> _getData() async {
    List<GitHubUser>? _data = await _fetchPost(pageNo: currentPageNo);
    user = _data;
    // 초기 로딩과 추가 로딩이 출동하지 않도록 하기 위한 안전장치
    currentPageNo = 2;
    // print(currentPageNo);
    notifyListeners();
  }

  Future<List<GitHubUser>> _fetchPost({
    required int pageNo,
  }) async {
    try {
      http.Response _reponse = await http.get(
          Uri.parse("https://api.github.com/users?page=$pageNo&limit=10"));
      if (_reponse.statusCode == 200) {
        // json 문자열을 Dart 객체로 변환(List<dynamic>으로 변환)
        List<dynamic> _data = json.decode(_reponse.body);
        // Iterable(리스트나 집합)로 만든 json을 새로운 Iterable로 생성하는 과정 json을 GitHubUser 객체로 변환 후 리스트에 저장
        // 이 단계에서 GitHubUser.fromJson 팩토리 생성자를 호출
        List<GitHubUser> _result =
            _data.map((e) => GitHubUser.fromJson(e)).toList();
        return _result;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
