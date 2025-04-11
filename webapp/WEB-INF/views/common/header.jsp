<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.khedu.member.model.vo.Member" %>
<% 
	String rootPath = request.getContextPath();
	Member loginMember = (Member) session.getAttribute("loginMember");
%>    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link href="<%= rootPath %>/assets/css/reset.css" rel="stylesheet">
<link href="<%= rootPath %>/assets/css/common.css" rel="stylesheet">
<link rel="icon" type="image/x-icon" href="<%= rootPath %>/assets/images/favicon.ico" />
<%-- 추가 정적 파일은 이 주석 아래에 추가!! --%>
<body>
	<%
		System.out.println(rootPath);
	%>
	<header>
        <div class="quick">
            <%-- <button type="button" class="btn btn-sm user-btn">로그인/로그아웃</button>--%>
            <% if (loginMember == null) { %>
        		<button type="button" onclick="location.href='<%= rootPath %>/members/sign-in'" class="btn btn-sm user-btn">로그인</button>
    		<% } else { %>
        		<button type="button" onclick="location.href='<%= rootPath %>/members/logout'" class="btn btn-sm user-btn">로그아웃</button>
    		<% } %>
        </div>
        <div class="header-top">
            <div class="team-logo">
            	<a href="<%= rootPath %>">
	                <span class="logo-t-image-area"><span class="logo-t"></span></span>
	                <span class="logo-text">rip:L</span>
	                <span class="logo-o-image-area"><span class="logo-o"></span></span>
	                <span class="logo-text">g</span>
            	</a>
            </div>
            <div class="user-menu">
                <ul class="menu-list">
                    <!-- 각 메뉴(li) 클릭 시 해당 페이지로 이동 -->
                    <!-- 
                        로그인 / 로그아웃 버튼을 명시적으로 보여주는 것이 좋은 경우
                            => 소셜 미디어, 커뮤니티 사이트처럼 로그인 여부가 중요한 경우
                            => 사용자가 로그인 상태를 쉽게 확인할 수 있어야 하는 경우
                            => 명확한 접근성을 제공해야 하는 경우
                            * 단점으로는 UI 공간을 차지함
                        
                        로그인 / 로그아웃 버튼을 명시하지 않아도 되는 경우
                            => 웹 사이트의 주요 기능들을 로그인 없이도 대부분 이용할 수 있는 경우
                            => 깔끔한 UI를 선호할 경우
                            => 로그인 여부를 사용자가 크게 신경 쓰지 않아도 되는 경우
                            * 단점은 로그인 여부가 직관적으로 보이지 않을 수 있음
                            * 사용자가 로그인/로그아웃을 찾기 어려움

                        ===> 결론으로 우리 프로젝트 특성상 커뮤니티가 메인이므로 로그인 여부가 중요!! 그래서 꼭 표시해줘야함
                    -->
                    <li>
                    	<a href="" class="menu-list-item">
	                        <i class="fa-solid fa-user"></i>
	                        <span>My</span>
                    	</a>
                    </li>
                    <li>
                    	<a href="" class="menu-list-item">
	                        <i class="fa-solid fa-heart" style="color: var(--heart-color)"></i>
	                        <span>찜</span>
                    	</a>
                    </li>
                </ul>
            </div>
        </div>

        <nav>
            <div class="nav-list">
                <!-- 각 메뉴(li) 클릭 시 해당 페이지로 이동 -->
                <div class="nav-list-item">
                    <a href="">
                        <i class="fa-solid fa-users"></i>
                        <span>커뮤니티</span>
                    </a>
                </div>
                <div class="nav-list-item">
                    <a href="/trip-log/products">
                        <i class="fa-solid fa-cart-shopping"></i>
                        <span>여행상품</span>
                    </a>
                </div>
                <div class="nav-list-item">
                    <a href="travelVote.do">
                        <i class="fa-solid fa-check-to-slot"></i>
                        <span>여행지투표</span>
                    </a>
                </div>
                <div class="nav-list-item">
                    <a href="tripCalculator.do">
                        <i class="fa-solid fa-calculator"></i>
                        <span>여행경비계산기</span>
                    </a>
                </div>
            </div>
        </nav>
    </header>