import 'package:flutter/material.dart';
import 'package:flutter_git_scroll/provider/api_provider.dart';
import 'package:flutter_git_scroll/subpage.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // 이벤트 url이동 메서드
  void moveWeb(BuildContext context) async {
    final Uri url = Uri.parse('https://taxrefundgo.kr/');
    // url이 만료 되었을 경우 처리
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      );
    } else {
      print('asdasd ${canLaunchUrl(url)}');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                width: 200,
                height: 170,
                decoration: BoxDecoration(
                  color: Color(0xFF686775),
                  borderRadius:
                      BorderRadius.circular(15), // 모든 모서리를 15의 반지름으로 둥글게 처리
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '만료된 페이지 입니다.',
                      style: TextStyle(
                          fontFamily: 'Retro',
                          fontSize: 25,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF8A9DFF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Text(
                          '확인',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApiProvider>(
      create: (_) => ApiProvider()..started(),
      child: Consumer<ApiProvider>(builder: (context, state, child) {
        return Scaffold(
          backgroundColor: Color(0xFF27262C),
          appBar: AppBar(
            backgroundColor: Color(0xFF2E2D34),
            title: Text(
              '홈',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w400),
            ),
            centerTitle: true,
          ),
          // 스크롤 이벤트 감지
          body: NotificationListener<ScrollUpdateNotification>(
            // 현재 스크롤 상태 전달 후 메서드 호출
            onNotification: (ScrollUpdateNotification notification) {
              state.scrollListerner(notification);
              return false;
            },
            // 사용자 리스트 표시
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              itemCount: state.user.length,
              itemBuilder: (context, index) {
                // 10번째 마다 이벤트 배너 출력
                if ((index + 1) % 10 == 0) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF8A9DFF),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin: EdgeInsets.only(top: 40),
                    padding: EdgeInsets.all(10),
                    // width: 320,
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/images/event_text.png'),
                        // 사용자 주소 이동버튼
                        Container(
                          width: 270,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              moveWeb(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0030B3),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Text(
                              '무료 환급 조회하기',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF686775),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin: EdgeInsets.only(top: 40),
                    padding: EdgeInsets.all(10),
                    // width: 320,
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // 사용자 이름
                        Text(
                          state.user[index].gitName,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        // 사용자 이미지
                        ClipOval(
                          child: Image.network(
                            state.user[index].avatarUrl,
                            width: 150, // 원하는 크기로 설정
                            height: 150, // 원하는 크기로 설정
                            fit: BoxFit.cover,
                          ),
                        ),
                        // 사용자 주소 이동버튼
                        Container(
                          width: 200,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(SubPage(), arguments: {
                                'name': state.user[index].gitName,
                                'avatarUrl': state.user[index].avatarUrl,
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF8A9DFF),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Text(
                              'Repository',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
