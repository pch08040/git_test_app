// 각 사용자의 아바타 이미지와, 사용자명을 보여줌
import 'package:get/get_state_manager/get_state_manager.dart';

class GitHubUser {
  final String gitName;
  final String avatarUrl;
  final String gitUrl;

  // fianl 변수로 선언되면 값이 반드시 있어야됨, required를 사용하면 객체를 생성할 때 해당 값을 제공하도록 강제할 수 있음
  //
  GitHubUser({
    required this.gitName,
    required this.avatarUrl,
    required this.gitUrl,
  });

  factory GitHubUser.fromJson(Map<String, dynamic> json) {
    return GitHubUser(
      gitName: json["login"],
      avatarUrl: json["avatar_url"],
      gitUrl: json["html_url"],
    );
  }
}
