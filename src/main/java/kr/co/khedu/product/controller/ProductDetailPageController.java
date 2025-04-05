package kr.co.khedu.product.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.khedu.product.model.vo.Product;
import kr.co.khedu.product.service.ProductServiceImpl;

/**
 * Servlet implementation class ProductDetailPageController
 */
@WebServlet("/products/*")
public class ProductDetailPageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductDetailPageController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println(request.getPathInfo());
		
		// URL 경로에서 상품 아이디 추출
		String pathInfo = request.getPathInfo();
		String path = "";
		
		if(pathInfo == null || pathInfo.equals("/")) {
			String uri = request.getRequestURI(); // 웹 서버로 요청 시, 요청에 사용된 URL 로부터 URI 값을 리턴
			path = uri.substring(uri.lastIndexOf("/") + 1);
		} else {
			path = pathInfo.substring(1);
		}
		
		// 숫자인지 확인 후 변환
		int productId = 0;
		
		if(path.matches("\\d+")) {
			productId = Integer.parseInt(path);
		} else {
			// TODO: 에러 페이지 이동
			System.out.println("오류입니다.");
			request.getRequestDispatcher("WEB-INF/views/product/productList.jsp").forward(request, response);
		}
		
		System.out.println(productId);
		
		// 추출한 상품 아이디로 상품 조회 후 request에 저장하기
		Product product = new ProductServiceImpl().selectProductByProductId(productId);
		
		if(product == null) {
			// TODO: 에러 페이지로 이동
			System.out.println("오류입니다.");
			request.getRequestDispatcher("WEB-INF/views/product/productList.jsp").forward(request, response);
			return;
		}
		
		System.out.println(product);
		
		request.setAttribute("productInfo", product);
		
		request.getRequestDispatcher("/WEB-INF/views/product/productDetail.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
