# 개발 환경

## 기술 스택

저희가 사용한 기술 스택은 다음과 같습니다.

- Java
- JavaScript
- JSP
- Tomcat
- Gson
- Lombok
- MyBatis
- Oracle DB

## 민감 정보 분리

원격 저장소에 DB 계정과 같이 민감한 정보가 업로드되면 보안 문제를 초래할 수 있습니다. 따라서 저희는 다음 파일들을 `.gitignore`를 통해 원격 저장소에 업로드 되지 않도록 하였습니다.

- `environment.properties` DB 계정 및 주소
- `keys.properties` 소셜 로그인 API 키

## 문서 작성

개발 환경 설정과 같은 부분은 문서로 작성하여 공유하였습니다.

- [`Git` 저장소 복사 및 `Eclipse` 환경 설정 가이드](/docs/clone_guide.md)
- [`Git` 규칙 및 명령어 가이드](/docs/git_guide.md)

## CSS 및 JavaScript 파일 분리

`JSP` 파일 내 `CSS`와 `JavaScript` 부분은 `/webapp/assets` 아래에 두어 서로 간 의존성을 줄였습니다.