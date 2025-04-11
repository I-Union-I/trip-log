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
 * Servlet implementation class MemberGoogleLoginController
 */
@WebServlet("/google-login/callback")
public class MemberGoogleLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    private final String clientId = KeyManager.get("google.clientId"); 
    private final String clientSecret = KeyManager.get("google.clientSecret"); 
    private final String redirectUri = KeyManager.get("google.redirectUri");
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberGoogleLoginController() {
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
                String email = getGoogleEmail(accessToken);
                processSocialLogin(email, request, response);
            } else {
                response.getWriter().println("구글 로그인 토큰 발급 실패");
            }
        } else {
            response.getWriter().println("구글 로그인 인가 코드가 없습니다.");
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public String getAccessToken(String code) throws IOException {
		String params = "code=" + code +
				"&client_id=" + clientId +
				"&client_secret=" + clientSecret +
				"&redirect_uri=" + redirectUri +
				"&grant_type=authorization_code";
		//System.out.println("params:"+params);
		URL url = new URL("https://oauth2.googleapis.com/token");
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
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
	
	private String getGoogleEmail(String token) throws IOException {
		String apiUrl = "https://www.googleapis.com/oauth2/v3/userinfo"; 
		URL url = new URL(apiUrl);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Authorization", "Bearer " + token);
		
		BufferedReader br = null;
		StringBuilder sb = new StringBuilder();
		String line;
		String email = null;
		
		try {
		    br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		    while ((line = br.readLine()) != null) {
		        sb.append(line);
		    }
		   
		    JsonObject json = JsonParser.parseString(sb.toString()).getAsJsonObject();
		    if (json.has("email")) {
		        email = json.get("email").getAsString();
		    } 
		
		} catch (IOException e) {
		    e.printStackTrace();
		}
		return email;
	}
	
	private void processSocialLogin(String email, HttpServletRequest request, HttpServletResponse response) throws IOException {
		MemberService memberService = new MemberServiceImpl();
		MemberDTO m = new MemberDTO(email);
		
		MemberDTO loginMember = memberService.socialMember(m);

		if (loginMember == null) {
		    String tempPassword = "social_" + System.currentTimeMillis(); // 예시: "social_" + 현재 시간, 임의의 비밀번호값 지정용
		    m.setPassword(tempPassword);
		    try {
		    	memberService.insertSocialMember(m);
		        loginMember = (MemberDTO) memberService.socialMember(m);
		    }catch(PersistenceException e) {
		    	e.printStackTrace();
		    	return;
		    }
		} 
		
		HttpSession session = request.getSession();
		session.setAttribute("loginMember", loginMember);
		System.out.println(loginMember);
		response.sendRedirect(request.getContextPath());
	}
}
