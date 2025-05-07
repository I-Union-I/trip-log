package kr.co.khedu.payment.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.co.bootpay.pg.Bootpay;
import kr.co.khedu.payment.model.vo.Payment;
import kr.co.khedu.payment.service.PaymentServiceImpl;

/**
 * Servlet implementation class PaymentConfirmController
 */
@WebServlet("/payment/confirm")
public class PaymentConfirmController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaymentConfirmController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	     // 응답 설정
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
		System.out.println("결제 요청!!");
		
		Properties prop = new Properties();
		
		try (InputStream input = PaymentConfirmController.class.getClassLoader().getResourceAsStream("bootpay.properties");) {
			if (input != null) {
				prop.load(input);
			}
        } catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        // 키값을 사용하여 값 가져오기
        String restAPI = prop.getProperty("rest.key");
        String priAPI = prop.getProperty("pri.key");
        System.out.println("restAPI: " + restAPI);
        System.out.println("priAPI: " + priAPI);
        
        // JSON 데이터 읽기
        BufferedReader reader = request.getReader();
        Gson gson = new Gson();
        Payment paymentInfo = gson.fromJson(reader, Payment.class);

        System.out.println(paymentInfo.getReceiptId());
        System.out.println(paymentInfo.getOrderId());
        System.out.println(paymentInfo.getMemberId());
        System.out.println(paymentInfo.getAmount());
        System.out.println(paymentInfo.getMethod());

        // TODO: 결제 정보 처리 로직

        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("success", false);  // 기본값

        try {
            Bootpay bootpay = new Bootpay(restAPI, priAPI);
            HashMap<String, Object> token = bootpay.getAccessToken();
            
            System.out.println(token);
            if(token.get("error_code") != null) {
            	hashMap.put("message", "토큰 발급 실패");
            } else {
                String receiptId = paymentInfo.getReceiptId();
                HashMap<String, Object> res = bootpay.confirm(receiptId);
                if(res.get("error_code") == null) {
                    
                    int result = new PaymentServiceImpl().insertPayment(paymentInfo);
                    
                    if(result > 0) {
                        // 결제 성공 처리
                        System.out.println("confirm success: " + res);
                        hashMap.put("success", true);
                        hashMap.put("message", "결제 확인 성공");
                    }
                    
                } else {
                    System.out.println("confirm false: " + res);
                    hashMap.put("message", "결제 확인 실패");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            hashMap.put("message", "서버 오류 발생");
        }

        // 클라이언트에 JSON 응답 전송
        gson = new Gson();
        String jsonResponse = gson.toJson(hashMap);
        System.out.println(jsonResponse);
        response.getWriter().write(jsonResponse);
	}

}
