<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="
	kr.co.khedu.member.model.vo.Member, 
	kr.co.khedu.product.model.vo.Product,
	kr.co.khedu.product.model.dto.ProductReviewDTO,
	java.util.List
"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String rootPath = request.getContextPath();
	Member member = (Member) request.getSession().getAttribute("loginMember");
	Product product = (Product) request.getAttribute("productInfo");
	/*
	List<ProductReviewDTO> reviewMemberList = (List<ProductReviewDTO>) request.getAttribute("productReviewMemberList");
	
	for(ProductReviewDTO prDTO : reviewMemberList) System.out.println(prDTO);
	*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= rootPath %>/assets/css/product/producDetail.css">

<%-- 부트페이 CDN 연결 --%>
<script src="https://js.bootpay.co.kr/bootpay-5.1.4.min.js" type="application/javascript"></script>
</head>
<body>
	<div id="root">
		<jsp:include page="../common/header.jsp"></jsp:include>
	    <div class="container mb-5">
	        <!-- 상품 이미지 영역 -->
	        <div class="product-image-area">
	            <div class="product-image">
	            	<%--
					<c:choose>
						<c:when test="${productInfo.changeFileName == null}">
							<img src="${pageContext.request.contextPath}/${defaultPath}" alt="Product Image" class="product-image" />
						</c:when>
						<c:otherwise>
							<img src="/trip-log/${productInfo.changeFileName}" alt="Product Image" class="product-image" />
						</c:otherwise>
					</c:choose>
	            	 --%>
					<img src="<%= rootPath %>/${productInfo.changeFileName}" alt="Product Image" class="product-image" />
	            </div>
	        </div>
	        <!-- 상품 상단 영역 -->
	        <div class="product-detail-header">
	            <!-- 상품 상단 제목 영역 -->
	            <div class="product-detail-header-title">
	                <p class="title">${productInfo.name }</p>
					<div class="product-icon-area">
						<span id="heartBtn" class="heart-icon">
							<%--
		                	<i class="fa-solid fa-heart" <c:if test="${ not empty productFavoriteInfo }"> style="color: var(--heart-color);" </c:if> ></i>
		                	--%>
		                	<i class="fa-solid fa-heart ${not empty productFavoriteInfo ? 'heart-active' : ''}"></i>
		                </span>
		                
		                <% if(member.getMemberId() == product.getMemberId()) { %>
		                	<span class="product-edit-icon">
			                	<i class="fa-solid fa-edit"></i>
			                </span>
			                <span class="product-trash-icon">
			                	<i class="fa-solid fa-trash-can"></i>
			                </span>
		                <% } %>
					</div>
	            </div>
	
	            <!-- 상품 상단 기타 영역(가격 정보, 여행 후기 링크) -->
	            <div class="product-detail-header-etc">
	                <div class="product-detail-header-etc-price">
	                    <p>
	                    	<fmt:formatNumber value="${ productInfo.price }" type="number" groupingUsed="true"  />원
	                    	<button id="paymentBtn" class="btn btn-primary">구매하기</button>
	                    </p>
	                </div>
	                <div class="product-detail-header-etc-review">
	                    <span class="review-score"><i class="fa-solid fa-star"></i><span>${reviewScore }</span></span>
	                    <span><i class="fa-solid fa-location-dot"></i> ${ countryName }</span>
	                    <span class="review-link"><a href="#">여행후기 <i class="fa-solid fa-arrow-right"></i></a></span>
	                </div>
	            </div>
	        </div>
	
	        <!-- 상품 설명 영역 -->
	        <div class="product-detail-description">
	            <!-- 상품 설명 제목 영역 -->
	            <div class="product-detail-description-title">
	                <p>상품설명</p>
	            </div>
	            <!-- 상품 설명 내용 영역 -->
	            <div class="product-detail-description-content">
	                <p>
	                	${ productInfo.description }
					</p>
	            </div>
	        </div>
	
			<%-- TODO: 상품 리뷰 테이블에서 해당 상품의 별점 정보를 모두 조회해서 각 점수별로 계산해서 출력 --%>
			<%--
		        <div class="product-detail-review-area">
		            <div class="product-detail-review-content">
		                <div class="product-detail-review-score-area">
		                    <div class="product-detail-review-header">
		                        <span class="review-score"><i class="fa-solid fa-star"></i><span>${ reviewScore }</span></span>
		                    </div>
		                    <div class="product-detail-review-score progress" role="progressbar" aria-label="Success example" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
		                        <div class="progress-bar" style="width:25%">25%</div>
		                    </div>
		                    <div class="product-detail-review-score progress" role="progressbar" aria-label="Basic example" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
		                        <div class="progress-bar" style="width:35%">35%</div>
		                    </div>
		                    <div class="product-detail-review-score progress" role="progressbar" aria-label="Basic example" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
		                        <div class="progress-bar" style="width:45%">45%</div>
		                    </div>
		                    <div class="product-detail-review-score progress" role="progressbar" aria-label="Basic example" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
		                        <div class="progress-bar" style="width:60%">60%</div>
		                    </div>
		                    <div class="product-detail-review-score progress" role="progressbar" aria-label="Basic example" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
		                        <div class="progress-bar" style="width:60%">60%</div>
		                    </div>
		                </div>
		            </div>
		        </div>
			 --%>
	
			<%-- TODO: 한번 평점을 남겼다면 아래 버튼을 안보이게 하기 --%>
	        <div class="btn-area">
				<button data-bs-toggle="modal" data-bs-target="#productReviewBtn" class="product-review-btn">당신의 평점은?</button>
	        </div>
	        <%--
				<% for(int i = 0; i < reviewMemberList.size(); i++) { %>
					<% System.out.println("1 : " + reviewMemberList.get(i).getMemberId());  %>
					<% if(reviewMemberList.get(i).getMemberId() != member.getMemberId()) { %>
		            	<button data-bs-toggle="modal" data-bs-target="#productReviewBtn" class="product-review-btn">당신의 평점은?</button>
					<% } else {%>
		            	<button class="product-review-btn">당신의 평점은?</button>
					<% } %>
				<% } %>
	         --%>
	    </div>
	
		<div class="modal fade" id="productReviewBtn" tabindex="-1"
			aria-labelledby="productReviewBtnLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="productReviewBtnLabel">상품의 후기를 남겨 주세요!</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form>
							<div class="rating">
								<label class="rating__label rating__label--half" for="starhalf">
									<input type="radio" id="starhalf" class="rating__input" name="rating" value="">
									<span class="star-icon"></span>
								</label>
								<label class="rating__label rating__label--full" for="star1">
									<input type="radio" id="star1" class="rating__input" name="rating" value="">
									<span class="star-icon"></span>
								</label>
								<label class="rating__label rating__label--half" for="star1half">
									<input type="radio" id="star1half" class="rating__input" name="rating" value="">
									<span class="star-icon"></span>
								</label> <label class="rating__label rating__label--full" for="star2">
									<input type="radio" id="star2" class="rating__input" name="rating" value="">
									<span class="star-icon"></span>
								</label>
								<label class="rating__label rating__label--half" for="star2half">
									<input type="radio" id="star2half" class="rating__input" name="rating" value="">
									<span class="star-icon"></span>
								</label>
								<label class="rating__label rating__label--full" for="star3">
									<input type="radio" id="star3" class="rating__input" name="rating" value="">
									<span class="star-icon"></span>
								</label>
								<label class="rating__label rating__label--half" for="star3half">
									<input type="radio" id="star3half" class="rating__input" name="rating" checked>
									<span class="star-icon"></span>
								</label>
								<label class="rating__label rating__label--full" for="star4">
									<input type="radio" id="star4" class="rating__input" name="rating" value="">
									<span class="star-icon"></span>
								</label>
								<label class="rating__label rating__label--half" for="star4half">
									<input type="radio" id="star4half" class="rating__input" name="rating" value="">
									<span class="star-icon"></span>
								</label>
								<label class="rating__label rating__label--full" for="star5">
									<input type="radio" id="star5" class="rating__input" name="rating" value="">
									<span class="star-icon"></span>
								</label>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button id="reviewRegisterBtn" type="button"
							class="btn btn-success">등록하기</button>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../common/footer.jsp"></jsp:include>
	</div>
	
    <script>
        // 외부 JS 파일에서 상품 정보를 출력하기 위해 전역변수에 저장
        <% if(member != null) { %>
	        const productInfo = {
	            productId: ${productInfo.productId},
	            name: "${productInfo.name}",
	            memberId: "<%= member.getMemberId() %>",
	            price: ${productInfo.price}
	        }
        <% } %>
    </script>
	<script type="module" src="<%= rootPath %>/assets/js/product/productDetail.js"></script>
	<script type="module" src="/trip-log/assets/js/product/bootpay.js"></script>
</body>
</html>