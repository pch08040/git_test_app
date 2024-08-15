// 레포 이름(이미 가져옴), 설명, 별 수, 사용 언어 가져옴
class GitSubData {
  final String repoName;
  final int star;
  final String? language;
  final String? htmlurl;

  // fianl 변수로 선언되면 값이 반드시 있어야됨, required를 사용하면 객체를 생성할 때 해당 값을 제공하도록 강제할 수 있음
  //
  GitSubData({
    required this.repoName,
    required this.star,
    required this.language,
    required this.htmlurl,
  });

  factory GitSubData.fromJson(Map<String, dynamic> json) {
    return GitSubData(
      repoName: json["name"],
      star: json["stargazers_count"],
      language: json["language"],
      htmlurl: json["html_url"],
    );
  }
}
