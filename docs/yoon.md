# 로그인 기능 구현(일반 로그인과 소셜 로그인)

- 일반 로그인
- 소셜 로그인 (카카오, 구글 API)

## 카카오, 구글 소셜 로그인 
- 카카오 디벨롭퍼와 구글 디벨롭퍼 콘솔에서 앱을 생성해 API 활성화 및 Redirect URI 를 설정함
- 각 디벨롭퍼에서 클라이언트 아이디와 클라이언트 시크릿 아이디를 받아와서 접근 토큰 발급 요청을 API 서버에 보내서 승인된 토큰을 받은 뒤에 우리 서비스는 회원의 이메일 정보만 필요해 사용자 정보 가져오기 중 이메일만 요청 `getGoogleEmail(String token)`, 받아온 사용자 이메일을 통해 로그인 완료 및 데이터베이스에 저장, 비밀번호 같은 경우는 회원가입의 경우 필수적인 필드이기에 `String tempPassword = "social_" + System.currentTimeMillis();` 이런식으로 임의값을 자동을 부여
 - 일반 로그인 컨트롤러에게 `KeyManager클래스를 통해 API 키값을 전달`, 왜냐하면 API키값 중 클라이언트 아이디와 시크릿아이디는 외부에 유출되면 안되서 하드코딩하면 안된다. 
* 개발하기 전에 카카오와 구글 API 를 사용하기 위해 스크립트를 설정해야함

        `<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.4/kakao.min.js"crossorigin="anonymous"></script>` 


        `<script src="https://apis.google.com/js/platform.js" async defer></script>`
- 개발 문서는 REST API, JavaScript 를 함께 사용
## 단계 설명(카카오를 예제로 설명)
### 1) 사용자가 카카오 로그인 요청을 보내면 서버에는 인가코드를 발급 요청을 보낸다.
### 2) 카카오 디벨롭퍼에 지정해둔 Redirect URI로 리다이렉션되며 토큰 발급 요청을 보내 받은 토큰으로 앱에 연결된다.
### 3) 회원 등록을 위해 사용자 정보 가져오기 요청을 서버에 보내서 개발자가 지정해둔 동의항목의 정보를 가지고 회원을 등록한다.
### 4) 해당 정보를 세션에 저장, 로그인 완료로 메인 페이지로 돌아간다.

## 카카오/구글 컨트롤러 구현 

- GET 요청을 보내서 카카오 서버는 리다이렉트 URI와 함께 인가 코드를 사용자에게 전달, 여기서 응답 처리는 jsp 에서 script로 처리함
    <pre>
    <code>
		Kakao.init('${kakaoScriptKey}');
		function signKakaoLogin() {
			Kakao.Auth.authorize({
				redirectUri : '${kakaoRedirectUri}',
				scope : 'account_email',
				prompt : 'select_account'
			});
		}
		function signGoogleLogin() {
			const authUrl = `https://accounts.google.com/o/oauth2/auth?client_id=656177775181-k2rlucfj6kjrb8ka3j0g7218rmlktm2h.apps.googleusercontent.com&redirect_uri=http://localhost:8080/trip-log/google-login/callback&response_type=code&prompt=select_account%20consent&scope=email`;
			
            window.location.href = authUrl;
			console.log(authUrl);
		}
</code></pre>
- 전달 받은 인가코드 `String code = request.getParameter("code");` code를 통해 토큰을 발급 받을 때 쓰인다.
- code를 null 체크를 하고 null이 아닌 경우 토큰을 발급 요청을 한다.
    <pre>
    if (code != null && !code.isEmpty()) {
        String accessToken = getAccessToken(code);
        if (accessToken != null && !accessToken.isEmpty()) {
            String email = getKakaoEmail(accessToken);
            processSocialLogin(email,request, response);
        } else {
            response.getWriter().println("카카오 로그인 토큰 발급 실패");
        }
    } else {
        response.getWriter().println("카카오 로그인 인가 코드가 없습니다.");
    }</pre>

- 토큰에 접근하기 위해서는 클라이언트 코드, 위에서 사용한 code, 클라이언트 시크릿, Redirect_Uri 가 있어야 토큰을 발급 받을 수 있다. 그리고 카카오와 구글 모두 `&grant_type=authorization_code`으로 필수적으로 지정해야 한다. 해당 키값은 하드코딩하지 않는다. 외부에 유출되면 안되는 개인정보를 포함하고 있어서 그렇다. 그래서 `KeyManager클래스`를 통해 가공한 API 키값을 `KeyManager.get("kakao.restKey");` 불러와서 객체에 넣어서 사용, 키값들은 KEYS.PROPPERTIES에 키-밸류 형태로 저장해두었다. 
    <pre>
    String params = "code=" + code +
 			"&client_id=" + clientId +
 			"&client_secret=" + clientSecret +
 			"&redirect_uri=" + redirectUri +
 			"&grant_type=authorization_code";
</pre>

- URL은 구글의 경우는 https://oauth2.googleapis.com/token으로 되어 있고, 카카오의 토큰 발급 받기 엔드포인트는 https://kauth.kakao.com/oauth/token는 지정되어 있다, 홈페이지를 참고해서 지정하면 된다.
    <pre>
    // 구글
    URL url = new URL("https://oauth2.googleapis.com/token");
    //카카오
    URL url = new URL("https://kauth.kakao.com/oauth/token");`
</pre>

- 생성한 URL에 대한 HTTP 연결을 위한 `HttpURLConnection conn = (HttpURLConnection) url.openConnection();`, 방식은 `POST` 토큰 발급 받는 방식은 POST.
- 카카오 서버로부터의 응답 데이터를 읽어오기 위해 BufferedReader를 생성

- 저장된 응답 문자열을 JSON 객체로 파싱하기 위해 GSON 라이브러리를 활용
    <pre>
    JsonObject json = JsonParser.parseString(sb.toString()).getAsJsonObject();
</pre>

- 파싱된 JSON 객체에서 access_token이라는 키에 해당하는 값을 가져와 문자열 형태로 반환한다. 이 값이 == 발급받은 접근 토큰이다.
    <pre>
    return json.get("access_token").getAsString();
</pre>

- 다음 단계는 만약 accessToken가 null이 아닌 경우에 진행한다. accessToken을 이용해 사용자 정보를 가져오는 코드를 작성해야 한다. 우리 서비스는 카카오에서 필요한 사용자 정보가 이메일이여서 이메일만 전달받았다. 
    <pre>
    if (accessToken != null && !accessToken.isEmpty()) {
        String email = getKakaoEmail(accessToken);
        processSocialLogin(email,request, response);
    }
</pre>

- 카카오에서 지정한 url를 통해 사용자 정보에 접근한다.
    <pre>
    URL url = new URL("https://kapi.kakao.com/v2/user/me");
</pre>

- getAcessToken 과 동일한 방식으로 서버의 응답 데이터를 읽어오려고 BufferedReader를 생성하고 응답 문자열을 JSON 객체로 파싱, 파싱된 JSON 객체에서 `json.getAsJsonObject("kakao_account").get("email").getAsString();` 카카오가 지정해둔 사용자 이메일 정보를 가져오는데 사용되는 `kakao_account.email` 카카오계정 이메일 사용자 정보 가져오기의 kakao_account.email에 해당 이는 ID 토큰 페이로드에 지정한 값 작성

- 앞의 모든 것이 끝나면 이메일과 토큰값을 통해 로그인을 한다. 
    `processSocialLogin(email,request, response);`

- 전달 받은 이메일을 사용해서 MemberDTO 객체를 생성하고 회원 정보를 저장
    <pre>
    MemberService memberService = new MemberServiceImpl();
	MemberDTO m = new MemberDTO(email);
</pre>

- 이미 있는 회원인지 아니면 새로운 회원인지 확인 절차
    <pre>
    MemberDTO loginMember = memberService.socialMember(m);
</pre>

- 조건문(loginMember == null)을 통해 새로운 회원의 경우 임의의 비밀번호값을 지정해주고, MemberDTO에 해당 비밀번호를 저장하고 데이터베이스에 저장하기 위해 Mapper로 이동, loginMember에 저장
    <pre>
     if (loginMember == null) {
            String tempPassword = "social_" + System.currentTimeMillis(); // 예시: "social_" + 현재 시간, 임의의 비밀번호값 지정용
            m.setPassword(tempPassword);
            try {
            	memberService.insertSocialMember(m);
                loginMember = memberService.socialMember(m);
            }catch(PersistenceException e) {
            	e.printStackTrace();
            	return;
            }
     }
</pre>

- 조건문(loginMember == null)을 통해 거짓인 경우 이미 회원가입한 회원이기에 세션에 저장해둔 회원정보가 맞는 경우 로그인 처리되서 로그인된 상태로 메인 페이지로 이동 
    <pre>
    HttpSession session = request.getSession();
    session.setAttribute("loginMember", loginMember);
    System.out.println(loginMember);
    response.sendRedirect(request.getContextPath());
</pre>

## 구글의 경우 카카오와 로직은 동일하다, 다른점은 URL만 다르고 나머지는 동일해서 하나의 소셜로그인 기능을 구현하면 다른 소셜도 구현하기 쉬워진다.