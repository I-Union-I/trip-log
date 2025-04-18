package kr.co.khedu.member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.exceptions.PersistenceException;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.co.khedu.keys.KeyManager;
import kr.co.khedu.member.model.dto.MemberDTO;
import kr.co.khedu.member.model.vo.Member;
import kr.co.khedu.member.service.MemberService;
import kr.co.khedu.member.service.MemberServiceImpl;

/**
 * Servlet implementation class MemberKakaoLoginController
 */
@WebServlet("/kakao-login")
public class MemberKakaoLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private final String clientId = KeyManager.get("kakao.restKey"); 
    private final String clientSecret = KeyManager.get("kakao.clientSecret"); 
    private final String redirectUri = KeyManager.get("kakao.redirectUri");
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberKakaoLoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String code = request.getParameter("code");

        if (code != null && !code.isEmpty()) {
            String accessToken = getAccessToken(code);
            if (accessToken != null && !accessToken.isEmpty()) {
                String email = getKakaoEmail(accessToken);
                processSocialLogin(email,request, response);
            } else {
            	request.setAttribute("errorMsg", "카카오 로그인 토큰 발급 실패");
                request.getRequestDispatcher("/WEB-INF/views/common/errorPage.jsp").forward(request, response);
            }
        } else {
        	request.setAttribute("errorMsg", "카카오 로그인 인가 코드가 없습니다.");
            request.getRequestDispatcher("/WEB-INF/views/common/errorPage.jsp").forward(request, response);
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	private String getAccessToken(String code) throws IOException {
        String params ="grant_type=authorization_code"
                + "&client_id="+ clientId
                + "&redirect_uri="+redirectUri
                + "&code=" + code
                + "&client_secret=" + clientSecret;
        
        System.out.println("params:"+params);
        URL url = new URL("https://kauth.kakao.com/oauth/token");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
        conn.setDoOutput(true);

        conn.getOutputStream().write(params.getBytes());

        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        StringBuilder sb = new StringBuilder();
        
        String line;
        while ((line = br.readLine()) != null) sb.append(line);
        br.close();

        JsonObject json = JsonParser.parseString(sb.toString()).getAsJsonObject();
        return json.get("access_token").getAsString();
	}
	private String getKakaoEmail(String token) throws IOException {
        URL url = new URL("https://kapi.kakao.com/v2/user/me");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + token);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");

        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) sb.append(line);
        br.close();

        JsonObject json = JsonParser.parseString(sb.toString()).getAsJsonObject();
        return json.getAsJsonObject("kakao_account").get("email").getAsString();
    }

    private void processSocialLogin(String email,HttpServletRequest request, HttpServletResponse response) throws IOException {
		MemberService memberService = new MemberServiceImpl();
		MemberDTO m = new MemberDTO(email);
		
		MemberDTO loginMember = memberService.socialMember(m);

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
        }else {
        	
        }
        
        HttpSession session = request.getSession();
        session.setAttribute("loginMember", loginMember);
        System.out.println(loginMember);
        response.sendRedirect(request.getContextPath());
    }
}
