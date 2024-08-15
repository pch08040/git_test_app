# 플러터로 만든 깃 예제

이 앱은 GitHub 사용자 목록을 표시하고, 각 사용자의 저장소를 상세히 볼 수 있는 기능을 제공합니다.
사용자는 홈 화면에서 GitHub 사용자 리스트를 스크롤하며 동적으로 로드되는 데이터를 확인할 수 있습니다.
목록의 특정 위치에서는 광고 배너가 나타나며, 클릭 시 외부 웹사이트로 이동합니다.
각 사용자를 클릭하면 해당 사용자의 저장소 목록이 상세 페이지에서 보여지며, 저장소에 대한 정보와 함께 이동할 수 있는 링크를 제공합니다.

### 주요 기능 및 구조
- GitHub 사용자 목록: 사용자 목록을 스크롤하며 동적으로 데이터를 로드합니다.
- 광고 배너: 특정 위치에서 광고 배너가 표시되며, 클릭 시 외부 웹사이트로 이동합니다.
- 저장소 상세 페이지: 각 사용자의 저장소 정보를 자세히 확인할 수 있습니다.
- 홈페이지와 상세페이지의 api와 provider의 사용을 구별하기위한 파일 구조를 만들었습니다.

### 기술 스택
- 상태 관리: Provider 패키지를 사용하여 상태를 관리하고 데이터 흐름을 제어합니다.
- 데이터 통신: http 패키지를 사용하여 GitHub API와 통신하며, 사용자 데이터 및 저장소 정보를 가져옵니다.
- UI 구성: Flutter의 기본 위젯을 토대로 Figma로 미리 제작하였습니다.

### Provider 선택 이유
- **간단한 API:** Provider는 사용하기 쉬운 api를 제공하여 간단한 프로젝트에서 상태 관리와 관련된 복잡성을 줄입니다.
- **성능 최적화:** Provider는 필요한 부분만 업데이트하여 전체 앱의 성능을 효율적으로 관리할 수 있다.
                Consumer는 특정 위젯 트리의 일부분만 상태 변화가 가능하여 전체를 리빌드하는 것보다 효율적이고
                build 메서드 내부에서 context를 사용하지 않아서 코드가 간결하다.

### api_provider 설계 순서
- **초기화 및 데이터 로드:** 앱 시작시 started() 메서드가 호출되어 첫 번째 페이지의 데이터를 로드합니다.
- **스크롤 감지:** 스크롤을 하면 scrollListerner()가 호출되고, 스크롤 위치에 따라(85%지점) _moreData()가 실행됩니다.
- **추가 데이터 로드:** _moreData()가 추가 데이터를 로드하고 user 리스트에 추가합니다.
- **UI 업데이트:** 모든 상태 변경되면 notifyListeners()가 호출되어 화면이 변경되어 데이터를 반영하도록 합니다.

### sub_api_provider 설계 순서
- **사용자 이름 설정:** 홈페이지에서 서브페이지도 이동 할 시 특정 GitHub 사용자의 이름을 설정합니다.
- **데이터 로드 요청:** subStarted() 메서드가 호출되어 사용자의 레포지토리 데이터를 로드합니다.
- **API 호출 및 데이터 등록:** _subGetData() 메서드가 API에 요청을 보내고, 응답으로 받은 JSON 데이터를 GitSubData 객체의 리스트로 등록합니다.
- **UI 업데이트:** 모든 상태 변경되면 notifyListeners()가 호출되어 화면이 변경되어 데이터를 반영하도록 합니다.

### 실행 이미지

![홈 페이지]https://github.com/pch08040/git_test_app/blob/main/assets/images/%EB%8C%80%EC%A7%80%202.png

![이벤트 배너]https://github.com/pch08040/git_test_app/blob/main/assets/images/%EB%8C%80%EC%A7%80%203.png

![이벤트 페이지 이동 확인]https://github.com/pch08040/git_test_app/blob/main/assets/images/%EB%8C%80%EC%A7%80%204.png

![서브 페이지]https://github.com/pch08040/git_test_app/blob/main/assets/images/%EB%8C%80%EC%A7%80%205.png

![레파지토리 확인]https://github.com/pch08040/git_test_app/blob/main/assets/images/%EB%8C%80%EC%A7%80%206.png
