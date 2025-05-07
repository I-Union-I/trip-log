# Trip : Log
* [프로젝트 소개](#-프로젝트-소개)
* [개발 목표](#개발-목표)
* [주요 기능](#-주요-기능)
* [팀원](#-팀원)
* [개발 환경](#개발-환경)
* [프로젝트 구조](#프로젝트-구조)

## 팀명 : I UNION I
> KH 정보교육원 (디지털컨버전스) 공공데이터 융합 자바개발자 양성과정<br>개발기간 : 2025.03.19 ~ 2025.04.16

## 🖥 프로젝트 소개
### “개발자는 코드를 기록하고, 당신은 여행을 기록한다.”
- 다양한 사람들이 작성한 여행 후기를 서로 공유할 수 있는 여행 후기 커뮤니티 기반 플랫폼입니다.
- 수많은 사람들의 솔직한 후기를 통해 보다 신뢰할 수 있는 여행 정보를 얻을 수 있는 프로젝트입니다.

## 🎯개발 목표
- 사용자 중심의 여행 후기 공유 플랫폼 구축
- 후기, 댓글, 공감 기능을 통한 사용자 간 상호작용 강화
- 여행지 추천, 경비 계산기 등 다양한 부가 기능 제공
- 소셜 로그인과 찜 기능을 통한 편리한 사용자 경험 제공

## 📌 주요 기능
- 여행 후기 게시글 CRUD (등록, 수정, 삭제, 목록, 상세)
- 댓글 기능 및 공감 기능
- 여행지 추천 투표 기능
- 여행 경비 계산기 기능 (Doughnut 차트 시각화)
- 상품 CRUD (등록, 수정, 삭제, 목록, 상세)
- 상품 부가 기능 (찜, 평점, 이미지 첨부 등)
- 일반 로그인 & 소셜 로그인 (Google, Kakao)
- 마이페이지 기능 (내 글, 내 댓글, 내 찜 목록, 회원정보 수정 등)
- 게시판/상품 목록 및 찜 목록 페이징 처리
- 검색 및 정렬 기능
- 웹 필터링 처리



## 🧑‍💻👩‍💻 팀원
### 팀장 및 형상관리자 임성준 [@Seong-Jun1525](https://github.com/Seong-Jun1525)

- 프로젝트
    - 프로젝트 총괄
    - 소스 코드 형상 관리(github)
    - 회의록 검토 및 작성
    - 협업 git 사용 가이드 문서 작성
    - 유사 프로그램 분석
    - 발표자료 작업 및 발표
- UI
    - 프로젝트 폰트 및 색상 선정
    - 메인페이지 및 헤더, 푸터
    - 상품 목록 및 상세 페이지
    - UI 흐름도 작업
- 기능 개발
    - 상품 목록 페이징 처리 구현
    - 내 찜 목록 페이징 처리 구현
    - 상품 검색 및 검색정렬 기능 구현
    - 상품 등록 및 상품 이미지 첨부파일 기능 구현
    - 상품 수정 및 삭제 기능 구현
    - 상품 별점 등록 및 평점 계산 기능 구현
    - 상품 찜 기능 구현

### 이슈 및 형상관리자 김일현 [@Kim-ilhyeon](https://github.com/Kim-ilhyeon)
- 프로젝트
    - 프로젝트 이슈 및 형상 관리
    - 여행경비 계산기, 국내 인기 여행지 투표 아이디어 도출
- UI
    - 글 상세 페이지
    - 투표 관련 페이지 (선택화면, 결과화면)
    - 여행 경비 계산기 페이지
- 기능 개발
    - 글 삭제 기능 구현
    - 글 상세 네비게이터 구현
    - 댓글 기능 구현
    - 글 & 댓글 공감기능 구현
    - 여행지 투표 등록 & 수정 구현
    - 여행 경비 계산기 기능 구현
        - 금액 별 비율 Doughnut chart 구현
        
### 일정 관리자 노승재 [@noseungjae](https://github.com/noseungjae)
- 프로젝트
    - 회의록 작성
- UI
    - 상품 등록 페이지
    - 에러 페이지
- 기능 개발
    - 상품 등록 기능 구현

### 이슈관리자 안민영 [@Tokemo](https://github.com/Tokemo)
- 프로젝트
    - 이슈 관리
    - 프로젝트 환경 설정
    - 프로젝트 환경 설정 가이드 문서 작성
- UI
    - 게시글 목록 페이지
    - 게시글 등록 & 수정 페이지
    - 게시글 댓글 페이지
- 기능 개발
    - 게시글 목록 페이징 처리 구현
    - 게시글 등록 & 수정 기능 구현
    - 게시글 삭제 기능 구현
    - 투표 결과 기능 구현

### DB 관리자 이윤서 [@yoonseo0832](https://github.com/yoonseo0832)
- 프로젝트
    - DB 설계 및 관리
- UI
    - 로그인 페이지
    - 내  댓글 정보 관리 페이지
    - 상품 찜 목록 페이지
    - 결제 내역 페이지
- 기능 개발
    - 일반 로그인 & 소셜 로그인(카카오, 구글) 기능 구현
    - 소셜 회원가입 처리 구현
    - 로그아웃 기능 구현
    - 웹 필터링 기능 구현

### DB 관리자 정혜영 [@vocoxo9](https://github.com/vocoxo9)
- 프로젝트
    - 프로젝트 주제 제공
    - DB 설계 및 관리
- UI
    - 회원가입 페이지
    - 내 정보 관리 페이지
    - 내 글 정보 관리 페이지
- 기능 개발
    - 일반 회원가입 기능 구현
    - 이메일 중복 확인 기능 구현
    - 비밀번호 이중 확인 기능 구현
    - 회원정보 수정 기능 구현
    - 회원탈퇴 기능 구현
    - 웹 필터링 기능 구현

## 개발 환경
항목 | 내용
:--: |:--
Tool | ![Eclipse](https://img.shields.io/badge/IDE-Eclipse-2C2255?logo=eclipse&logoColor=white), ![VS Code](https://img.shields.io/badge/IDE-VS%20Code-007ACC?logo=visualstudiocode&logoColor=white)
Server | ![Apache Tomcat](https://img.shields.io/badge/Server-Apache%20Tomcat-F8DC75?logo=apachetomcat&logoColor=black)
Tech stack |  ![Java](https://img.shields.io/badge/Language-JAVA-007396?logo=java&logoColor=white), ![JavaScript](https://img.shields.io/badge/Language-JavaScript-F7DF1E?logo=javascript&logoColor=black), ![CSS3](https://img.shields.io/badge/Style-CSS3-1572B6?logo=css3&logoColor=white), ![JSP](https://img.shields.io/badge/View-JSP-FF9800?logo=jsp&logoColor=white)
Library | ![Lombok](https://img.shields.io/badge/Library-Lombok-EA1B1B?logo=java&logoColor=white), ![JSON](https://img.shields.io/badge/Library-JSON-000000?logo=json&logoColor=white), ![GSON](https://img.shields.io/badge/Library-GSON-FF6F00?logo=google&logoColor=white), ![JSTL](https://img.shields.io/badge/Library-JSTL-336791?logo=java&logoColor=white), ![JDBC](https://img.shields.io/badge/Library-JDBC-007396?logo=java&logoColor=white), ![jQuery](https://img.shields.io/badge/Library-jQuery-0769AD?logo=jquery&logoColor=white), ![simpleMDE](https://img.shields.io/badge/Library-simpleMDE-2B2B2B?logo=markdown&logoColor=white), ![SweetAlert2](https://img.shields.io/badge/Library-SweetAlert2-FF6C6C?logo=javascript&logoColor=white), ![Font Awesome](https://img.shields.io/badge/Icon-Font%20Awesome-339AF0?logo=fontawesome&logoColor=white)
Framework | ![MyBatis](https://img.shields.io/badge/Framework-MyBatis-1F6E43?logo=java&logoColor=white), ![Bootstrap](https://img.shields.io/badge/Framework-Bootstrap-7952B3?logo=bootstrap&logoColor=white)
DB |  ![Oracle DB](https://img.shields.io/badge/Database-Oracle%20DB-F80000?logo=oracle&logoColor=white)
API | ![Kakao API](https://img.shields.io/badge/API-Kakao-yellow?logo=kakao&logoColor=black), ![Google API](https://img.shields.io/badge/API-Google-4285F4?logo=google&logoColor=white)

## 프로젝트 구조
```
📦 trip-log
├── 📂docs                # 프로젝트 문서
├── 📂resources           # MyBatis 설정, SQL 등
│   ├── 📂mappers
│   ├── mybatis-config.xml
│   └── schema.sql
├── 📂src
│   └── 📂main
│       ├── 📂java
│       │   └── 📂kr.co.khedu
│       │       ├── 📂member         # 회원 기능
│       │       ├── 📂post           # 게시글 기능
│       │       ├── 📂product        # 상품 기능
│       │       ├── 📂vote           # 투표 기능
│       │       ├── 📂comment        # 댓글 기능
│       │       └── 📂common         # 공통 유틸, 설정 등
│       ├── 📂resources
│       └── 📂webapp
│           └── 📂WEB-INF
│               └── 📂views         # JSP 뷰 파일
├── 📂webapp
│   ├── 📂assets           # 정적 자원
│   │   ├── 📂css
│   │   ├── 📂js
│   │   └── 📂images
│   └── 📜index.jsp
├── .gitignore
└── README.md
```