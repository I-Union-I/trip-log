# SEMI-PROJECT
## 회원관련 기능 개발 - 정혜영

> ### 회원가입
- 이메일 중복 확인 기능  
사용자가 이미 가입된 이메일을 입력했는지 실시간으로 확인하여 중복된 이메일로 가입하는 것을 방지하는 기능 구현  
입력되는 email값을 비동기방식인 Ajax를 통해 서버로 이메일 중복 체크 요청을 전송시킴.
서버에서는 DB에서 해당 이메일의 존재 여부를 COUNT(*)로 확인함.  
결과가 available일 시 비활성화 되어있던 회원가입 버튼을 활성화 시키며, unavailable일 시 Sweet Alert을 사용해 경고창을 띄운 후 회원가입 버튼 비활성화 유지
```js
	function emailCheck(){
		const $email = $(".signup-box #email").val();
		$.ajax({
			url : '/trip-log/members/email-check',
			data : { email : $email },
			success : function(result){
				if(result == "available"){
					console.log(result);
					Swal.fire({
						  title: "사용 가능한 이메일입니다!",
						  icon: "success"
						});		
					$(".signup-box #signupButton").removeAttr("disabled");
				} else {
					console.log(result);
					Swal.fire({
						  title: "이미 사용 중인 이메일입니다.",
						  icon: "error"
						});
					$(".signup-box #emailCheckButton").attr("readonly",true);
				}
			}, error : function(error){ console.log(error); }
		});
	}
```
```java
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
        new Member().setEmail(email);
		
		MemberService mService = new MemberServiceImpl();
		int count = mService.countMemberByEmail(email);
		if(count == 0) {
			response.getWriter().print("available");
		}else {
			response.getWriter().print("unavailable");
		}
	}
```
```xml
    <select id="countMemberByEmail" resultType="_int">
		SELECT COUNT(*) FROM TB_MEMBER WHERE EMAIL = #{email}
	</select>
```
- 회원가입 중 생년월일 입력 시에 금일 이후 선택 불가하도록 기능 구현  
input[type="date"]요소의 max 속성을 현재 날짜로 지정
```js
	var now_utc = Date.now();
    // 현재 날짜를 ms 단위로 추출
	var timeOff = new Date().getTimezoneOffset()*60000;
    // getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환하기 때문에 분단위를 밀리초로 변환
	var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
    // toISOString()는 ISO표준을 사용하여 YYYY-MM-DDTHH:mm:ss.sssZ 형태로 반환되기 때문에 T 앞에서 날짜를 끊어줌
	document.querySelector(".signup-box #birthday").setAttribute("max", today);
    // date 타입의 input 태그의 최댓값을 오늘로 설정
```
- 비밀번호 이중 확인 기능  
사용자의 비밀번호 입력 실수를 방지하고자 기능 설계  
비밀번호와 비밀번호 확인 필드의 값을 비교하고 불일치 할 경우 알림창을 띄운 후 가입 차단
```js
	function pwdCheck(){
		const pwd = document.querySelector(".signup-box #password").value;
		const pwdCheck = document.querySelector(".signup-box #passwordCheck").value;
		if(pwd != pwdCheck){
			Swal.fire({
                title: "비밀번호가 일치하지 않습니다.",
                text: "확인 후 다시 입력해 주세요.",
                icon: "warning"
            });
			return false;
		} else{
			return true;
		}
	}
```

> ### 회원정보 수정
- 비밀번호 이중 확인 후 회원정보 수정 가능하도록 기능 구현

> ### 회원 탈퇴
- 비밀번호 이중 확인 후 탈퇴 가능하도록 기능 구현

> ### URL 직접 접근 차단
- 서블릿의 `Filter` 인터페이스를 이용하여 로그인이 확인되지 않은 회원이 로그인 해야만 접근할 수 있는 
URL로 직접 접근하는 방법 차단

### 필터 설정
1. web.xml에 filter 태그를 추가하여 filter 등록  
filter-name 태그에 필터의 이름을 지정한 후 구현한 필터 클래스를 filter-class태그에 작성한다.  
filter-mapping 태그 안에 url-pattern 태그로 접근 제어할 url pattern을 작성하는 방식이다.
```xml
<filter>
    <filter-name>AccessFilter</filter-name>
    <filter-class>kr.co.khedu.common.AccessFilter<filter-class>
</filter>

<filter-mapping>
    <filter-name>AccessFilter</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
```

2. 필터 클래스에 @WebFilter 어노테이션을 사용하여 url패턴을 추가한다  
<mark>*해당 프로젝트에서 적용한 방법*</mark>
```java
@WebFilter({"/*"})
public class AccessFilter implements Filter{

	// 접근 허용할 url들을 List 형태로 저장
	   private static final List<String> EXCLUDED_URLS = 
		         Arrays.asList("/trip-log/", "/trip-log/members/sign-in","/trip-log/members/sign-up",
		               "/trip-log/products", "/trip-log/auth/sign-in", "/trip-log/google-login/callback", "/trip-log/kakao-login"  );

    @Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		String uri = req.getRequestURI();
		// 정적 리소스들 예외처리
		if (uri.endsWith(".css") || uri.endsWith(".js") || uri.endsWith(".png")
                || uri.endsWith(".jpg") || uri.endsWith(".ttf")) {
            chain.doFilter(request, response);
            return;
        }

        // 로그인 없이 접근 가능한 url인지 확인하고 접근 허용
        boolean isExcluded = EXCLUDED_URLS.stream().anyMatch(uri::equals);
    		if(isExcluded) {
			chain.doFilter(request, response);
			return;
		}

        // 그 외 url에 접근할 때 로그인 되어있는지 확인
    	if (session == null || session.getAttribute("loginMember") == null) {
			// ... (생략)
            out.println("Swal.fire({\r\n"
					+ "  title: \"로그인 후 이용 가능합니다.\",\r\n"
					+ "  icon: \"warning\"\r\n"
					+ "}).then(() => { location.href = '" + req.getContextPath() + "/members/sign-in'; });");
            // 로그인 되어있지 않다면 로그인 페이지로 이동하도록 처리
		}
```

