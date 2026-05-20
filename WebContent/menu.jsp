<%@ page contentType="text/html; charset=utf-8"%>
<%
	// 톰캣 관리자 로그인 여부 확인
	String loginId = request.getRemoteUser();
	
	// 🎯 [과제 핵심 4] 일반 회원 로그인 여부 확인 (세션에서 꺼내기)
	String sessionId = (String) session.getAttribute("sessionId");
%>
<nav class="navbar navbar-expand navbar-dark bg-dark">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="/WebMarket/welcome.jsp">Home</a>
			<%
				// 1. 일반 회원이 로그인한 경우
				if (sessionId != null) { 
			%>
					<a class="navbar-brand" href="/WebMarket/member/logoutMember.jsp">[<%=sessionId%>님] 로그아웃</a>
			<%
				// 2. 관리자가 로그인한 경우
				} else if ("admin".equals(loginId)) { 
			%>
					<a class="navbar-brand" href="/WebMarket/logout.jsp">관리자 로그아웃</a>
			<%
				// 3. 아무도 로그인하지 않은 경우
				} else { 
			%>
					<a class="navbar-brand" href="/WebMarket/welcomeAdmin.jsp">관리자 로그인</a>
			<%
				}
			%>			
		</div>
		<div>
			<ul class="navbar-nav mr-auto">
			<%
				if (sessionId != null) { // 일반 회원 로그인 시 보이는 메뉴
			%>
					<li class="nav-item"><a class="nav-link" href="/WebMarket/member/updateMember.jsp">회원 수정</a></li>
					<li class="nav-item"><a class="nav-link" href="/WebMarket/products.jsp">상품 목록</a></li>
					<li class="nav-item"><a class="nav-link" href="/WebMarket/cart.jsp">장바구니</a></li>
			<%
				} else if ("admin".equals(loginId)) { // 관리자 로그인 시 보이는 메뉴
			%>
					<li class="nav-item"><a class="nav-link" href="/WebMarket/products.jsp">상품 목록</a></li>
					<li class="nav-item"><a class="nav-link" href="/WebMarket/addProduct.jsp">상품 등록</a></li>
					<li class="nav-item"><a class="nav-link" href="/WebMarket/editProduct.jsp?edit=update">상품 수정</a></li>
					<li class="nav-item"><a class="nav-link" href="/WebMarket/editProduct.jsp?edit=delete">상품 삭제</a></li>
			<%
				} else { // 비로그인 상태일 때 보이는 메뉴
			%>
					<li class="nav-item"><a class="nav-link" href="/WebMarket/member/loginMember.jsp">로그인 </a></li>
					<li class="nav-item"><a class="nav-link" href="/WebMarket/member/addMember.jsp">회원 가입</a></li>
					<li class="nav-item"><a class="nav-link" href="/WebMarket/products.jsp">상품 목록</a></li>
					<li class="nav-item"><a class="nav-link" href="/WebMarket/cart.jsp">장바구니</a></li>
			<%
				}
			%>
			</ul>
		</div>
	</div>
</nav>