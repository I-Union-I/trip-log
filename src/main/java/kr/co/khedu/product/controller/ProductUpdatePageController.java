package kr.co.khedu.product.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.khedu.country.model.dto.CountryDTO;
import kr.co.khedu.country.service.CountryServiceImpl;
import kr.co.khedu.product.common.ProductPath;
import kr.co.khedu.product.model.vo.Product;
import kr.co.khedu.product.service.ProductServiceImpl;

/**
 * Servlet implementation class ProductUpdateController
 */
@WebServlet("/products/update/*")
public class ProductUpdatePageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductUpdatePageController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 국가 정보 가져오기
		List<? extends CountryDTO> countryList = new CountryServiceImpl().selectCountryList();
		
		for(CountryDTO c : countryList) System.out.println(c);
		
		// 상품 아이디 값 구하기
		String pathInfo = request.getPathInfo();
		int productId = ProductPath.getProductId(request, pathInfo);
		
		Product product = new ProductServiceImpl().selectProductByProductId(productId);
		
		if(product == null) {
			// TODO: 에러 페이지로 이동
			request.setAttribute("errorMsg", "상품 정보를 불러올 수 없습니다.");
		    request.getRequestDispatcher("/WEB-INF/views/common/errorPage.jsp").forward(request, response);
		    return;
		}
		
		System.out.println(product);

		request.setAttribute("countryInfo", countryList);
		request.setAttribute("productInfo", product);
		request.getRequestDispatcher("/WEB-INF/views/product/productUpdate.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
