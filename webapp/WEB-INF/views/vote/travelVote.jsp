<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<%
String rootPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>������ ���� ������</title>

<%--
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
        integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
        integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    --%>
<link rel="stylesheet"
	href="<%=rootPath%>/assets/css/vote/travelVote.css" />
<style>
</style>

</head>

<body>
	<div id="root">
		<jsp:include page="../common/header.jsp"></jsp:include>
		<div class="container">
			<div class="vote-header">
				<div class="vote-header-title">
					<h2 class="title">�̹����� �츮 ���� ����?</h2>
				</div>
				<div class="vote-header-subtitle">
					<h6>���� ������� �������� ����ּ���.</h6>
				</div>
			</div>
			<form action="vote/result" method="get">
				<input type="hidden" name="userId" value="${ loginUser.userId }"/>
				<div class="vote-body">
					<div class="vote-lists">
						<div class="vote-list">
							<div class="vote-list-image">
								<img src="<%=rootPath%>/assets/images/vote/����.png" alt="">
							</div>
							<div class="vote-list-name">
								<!-- ����ִ� �� -->
								<input type="radio" name="travel" id="����" value="����"> <label
									for="����">����</label>
							</div>
						</div>
						<div class="vote-list">
							<div class="vote-list-image">
								<img src="<%=rootPath%>/assets/images/vote/����.png" alt="">
							</div>
							<div class="vote-list-name">
								<!-- ����ִ� �� -->
								<input type="radio" name="travel" id="����" value="����"> <label
									for="����">����</label>
							</div>
						</div>
						<div class="vote-list">
							<div class="vote-list-image">
								<img src="<%=rootPath%>/assets/images/vote/����.png" alt="">
							</div>
							<div class="vote-list-name">
								<!-- ����ִ� �� -->
								<input type="radio" name="travel" id="����" value="����"> <label
									for="����">����</label>
							</div>
						</div>
						<div class="vote-list">
							<div class="vote-list-image">
								<img src="<%=rootPath%>/assets/images/vote/����.png" alt="">
							</div>
							<div class="vote-list-name">
								<!-- ����ִ� �� -->
								<input type="radio" name="travel" id="����" value="����"> <label
									for="����">����</label>
							</div>
						</div>
					</div>
					<div class="vote-lists">
						<div class="vote-list">
							<div class="vote-list-image">
								<img src="<%=rootPath%>/assets/images/vote/��õ.png" alt="">
							</div>
							<div class="vote-list-name">
								<!-- ����ִ� �� -->
								<input type="radio" name="travel" id="��õ" value="��õ"> <label
									for="��õ">��õ</label>
							</div>
						</div>
						<div class="vote-list">
							<div class="vote-list-image">
								<img src="<%=rootPath%>/assets/images/vote/����.png" alt="">
							</div>
							<div class="vote-list-name">
								<!-- ����ִ� �� -->
								<input type="radio" name="travel" id="����" value="����"> <label
									for="����">����</label>
							</div>
						</div>
						<div class="vote-list">
							<div class="vote-list-image">
								<img src="<%=rootPath%>/assets/images/vote/�λ�.png" alt="">
							</div>
							<div class="vote-list-name">
								<!-- ����ִ� �� -->
								<input type="radio" name="travel" id="�λ�" value="�λ�"> <label
									for="�λ�">�λ�</label>
							</div>
						</div>
						<div class="vote-list">
							<div class="vote-list-image">
								<img src="<%=rootPath%>/assets/images/vote/���ֵ�.png" alt="">
							</div>
							<div class="vote-list-name">
								<!-- ����ִ� �� -->
								<input type="radio" name="travel" id="���ֵ�" value="���ֵ�"> <label
									for="���ֵ�">���ֵ�</label>
							</div>
						</div>
					</div>
				</div>

				<div class="vote-footer">
					<button class="vote-btn">��ǥ�ϱ�</button>
				</div>
			</form>
		</div>
		<jsp:include page="../common/footer.jsp"></jsp:include>
	</div>
</body>
<!-- 
1) ������ �߰��ϸ� ����**
2) üũ ĭ �ٽùٲٱ� input ���� (�����͸� DB�� �����ؾߵǱ� ������)
-->

</html>