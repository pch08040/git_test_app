import 'package:flutter/material.dart';
import 'package:flutter_git_scroll/provider/api_provider.dart';
import 'package:flutter_git_scroll/provider/sub_api_provider.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class SubPage extends StatelessWidget {
  const SubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final String name = arguments['name'];
    final String avatarUrl = arguments['avatarUrl'];

    // 레파지토리로 이동하는 메서드
    void moveRepo(BuildContext context, String url) async {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.inAppWebView,
        );
      } else {
        print('asdasd ${canLaunchUrl(uri)}');
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

    return ChangeNotifierProvider<SubApiProvider>(
      create: (_) => SubApiProvider(name: name)..subStarted(),
      child: Consumer<SubApiProvider>(
        builder: (context, state, child) {
          return Scaffold(
            backgroundColor: const Color(0xFF27262C),
            appBar: AppBar(
              backgroundColor: const Color(0xFF2E2D34),
              title: const Text(
                '정보',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w400),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(40),
              // 스크롤 가능하게 수정
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF686775),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    // margin: const EdgeInsets.only(top: 40),
                    padding: const EdgeInsets.all(10),
                    width: 320,
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // 사용자 이름
                        Text(
                          name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        // 사용자 이미지
                        ClipOval(
                          child: Image.network(
                            avatarUrl,
                            width: 200, // 원하는 크기로 설정
                            height: 200, // 원하는 크기로 설정
                            fit: BoxFit.cover,
                          ),
                        ),
                        // 사용자 주소 이동버튼
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true, // 스크롤 뷰의 높이 문제를 해결하기 위해 추가
                    physics:
                        const NeverScrollableScrollPhysics(), // 부모 스크롤뷰에 따라 움직이도록 설정
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        height: 140,
                        margin: const EdgeInsets.only(top: 40),
                        decoration: BoxDecoration(
                          color: const Color(0xFF686775),
                          borderRadius: BorderRadius.circular(
                              15), // 모든 모서리를 15의 반지름으로 둥글게 처리
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                moveRepo(context,
                                    state.data[index].htmlurl.toString());
                              },
                              // TextButton 기본 패딩값 삭제
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: Text(
                                state.data[index].repoName,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star_border,
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(state.data[index].star.toString(),
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 15,
                                      color: Color(0xFF8A9DFF),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(state.data[index].language.toString(),
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
