<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="kr.co.khedu.post.model.dto.CommentDTO,
			java.util.ArrayList,
			kr.co.khedu.post.model.dto.PostDetailDTO"%>
<%
String rootPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Post Detail</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
	integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
	integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="<%=rootPath%>/assets/css/reset.css" />
<link rel="stylesheet"
	href="<%=rootPath%>/assets/css/post/postDetail.css" />

<style>
</style>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
        crossorigin="anonymous">
    </script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/marked/15.0.7/marked.min.js"
	        integrity="sha512-rPuOZPx/WHMHNx2RoALKwiCDiDrCo4ekUctyTYKzBo8NGA79NcTW2gfrbcCL2RYL7RdjX2v9zR0fKyI4U4kPew=="
	        crossorigin="anonymous"
	        referrerpolicy="no-referrer">
	</script>
	<link rel="stylesheet"
	      href="https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.8.1/github-markdown.min.css"
	      integrity="sha512-BrOPA520KmDMqieeM7XFe6a3u3Sb3F1JBaQnrIAmWg3EYrciJ+Qqe6ZcKCdfPv26rGcgTrJnZ/IdQEct8h3Zhw=="
	      crossorigin="anonymous"
	      referrerpolicy="no-referrer" />
</head>

<body>
	<div id="root">
		<div class="container">
			<div>
				<div class="board-detail-header" id="pageUp">
					<div class="card bg-dark text-white">
						<div class="position-relative">
							<img
								src="<%=rootPath%>/assets/images/post/postDetail-title.png"
								class="card-img" alt="대표 이미지">
							<div
								class="card-img-overlay d-flex align-items-center justify-content-center"
								style="background-color: rgba(0, 0, 0, 0.5); backdrop-filter: blur(5px);">
								<h1 class="card-title">${ postDetail.title }</h1>
							</div>
						</div>
					</div>
				</div>
				<div class="board-detail-body">
					<div class="content">
						<div class="markdown-body"
						     id="content"
						     name="content"
						     readonly
						>${ postDetail.content }</div>
                        <script>
                            const element = document.getElementById('content')
                            element.innerHTML = marked.parse(element.innerHTML)
                        </script>
                        <input type="hidden" id="memberId" value="${ postDetail.memberId }"/> <%--  나중에 연결하면 loginUser의 memberId로 바꾸기!! --%>
						<div class="nav-btn">
							<nav>
								<a href="#pageUp"><i class="fa-solid fa-circle-up"></i></a>
								<a href="#pageDown"><i class="fa-solid fa-circle-down"></i></a> 
								<a href="#pageComment"><i class="fa-solid fa-pencil"></i></a>
							</nav>
						</div>
					</div>
					<div class="content-update-delete">
						<div class="buttons">
							<div class="update-delete-btn">
								<input type="hidden" name="postId"
									value="${ postDetail.postId }" />
									<a href="${pageContext.request.contextPath}/post/edit?postId=${ postDetail.postId }"><i class="fa-solid fa-pen-to-square"></i></a>
									<a href="${pageContext.request.contextPath}/post/delete?pno=${ postDetail.postId }"><i class="fa-solid fa-trash-can"></i></a>
							</div>
							<div class="board-like-count">
								<i class="fa-regular fa-heart"></i> <span class="like-count">${ postDetail.likeCount }</span>
							</div>
						</div>
					</div>
					<div class="comments" id="pageComment">
						<div class="views">
							<div class="comment-input">
								<textarea id="comment"></textarea>
								<i class="fa-regular fa-paper-plane"></i>
							</div>
								<%
								ArrayList<CommentDTO> comments = (ArrayList<CommentDTO>) request.getAttribute("comments");
								%>
								<%
								if (comments != null) {
								%>
								<%
								for (CommentDTO c : comments) {
								%>
							<div class="comment">
								<input type="hidden" name="commentId" value="<%= c.getCommentId() %>" />
								<div class="comment-views">
									<div class="comment-user-profile">
										<i class="fa-solid fa-user"></i>
									</div>
									<div class="comment-view" data-comment-target="<%= c.getCommentId() %>">
										<div class="comment-view-header">
											<div class="comment-user-name" id="userName"><%=c.getNickname()%></div>
											<div class="date-update-delete">
												<div class="comment-date" id="registDate">
												<%=c.getRegistDate()%>일전
												</div>
												<div class="update-delete-menu active" data-etc-target="<%= c.getCommentId()%>">
													<i class="fa-solid fa-ellipsis"></i>
												</div>
												<div class="comment-update-delete" id="etc<%= c.getCommentId() %>">
													<i class="fa-solid fa-pen-to-square"></i>
													<i class="fa-solid fa-trash-can"></i>
												</div>
											</div>
										</div>
										<div class="comment-view-body">
											<textarea id="commentView" name="comment" readonly><%=c.getContent()%></textarea>
										</div>
										<div class="comment-view-footer">
											<div class="reply-btn active"
												data-comment-target="<%=c.getCommentId()%>">
												<i class="fa-solid fa-square-caret-down"></i> <span
													id="replyWriter">댓글 달기</span>
											</div>
											<div class="reply-close-btn"
												data-comment-target="<%=c.getCommentId()%>">
												<i class="fa-solid fa-square-caret-up"></i> <span
													id="replyCloser">댓글 닫기</span>
											</div>
											<div class="comment-like" id="<%= c.getCommentId() %>">
												<i class="fa-regular fa-heart"></i> <span class="like-count"><%=c.getLikeCount()%></span>
											</div>
										</div>
									</div>
								</div>

								<div class="reply" id="reply<%=c.getCommentId()%>">
									<div class="reply-input">
										<!-- <input type="text" id="reply"> -->
										<textarea id="reply"></textarea>
										<i class="fa-regular fa-paper-plane"></i>
									</div>

								</div>
							</div>
							<%
							}
							%>
							<%
							}
							%>
							</div>
						</div>

					<script>
						
					</script>
					<div class="down-btn">
						<i class="fa-solid fa-circle-arrow-down"></i>
					</div>
				</div>
				<div class="board-detail-footer" id="pageDown">
				<% 
					PostDetailDTO beforePost = (PostDetailDTO)request.getAttribute("beforePost");
					PostDetailDTO afterPost = (PostDetailDTO)request.getAttribute("afterPost");
				%>
					<div class="before">
						<div class="before-board">이전글</div>
						<div class="board-title"><a href="postDetail?pno=<%= beforePost.getPostId() %>"><%= beforePost.getTitle() %></a></div>
					</div>
					<div class="next">
						<div class="next-board">다음글</div>
						<div class="board-title"><a href="postDetail?pno=<%= afterPost.getPostId() %>"><%= afterPost.getTitle() %></a></div>
					</div>
					<div class="end"></div>
				</div>
			</div>
		</div>
	</div>
	<script src="<%=rootPath%>/assets/js/post/postDetail.js"></script>



</body>
<!--
1) 네비게이터 바 만들기**
2) 댓글 수정 삭제 버튼 숨겼다가 ...클릭하면 나오게 바꾸기
    수정버튼 클릭 시 수정하는 칸 만들기
    삭제버튼 클릭 시 해당 댓글 삭제
3) 댓글달기 버튼 눌렀을 때 대댓글 입력칸과 대댓글들 나타나기 ->(진행중임, script보면 할일 적어둠)
4) 나머지 클릭버튼 처리하기**
5) 댓글 상하 폭 줄이기
6) 댓글 입력 창 textarea 로 변경하기**
7) 댓글 프로필 이미지 영역(div)으로 border-radius 줘서 원으로 영역 잡기
-->

</html>