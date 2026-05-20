<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="dbconn.jsp"%>
<html>
<head>
<!-- 기존에 있던 링크 등은 그대로 두세요 -->
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>상품 상세 정보</title>

<!-- 🎯 새롭게 추가하는 장바구니 제어 스크립트 -->
<script type="text/javascript">
	function addToCart() {
		// 1. 세션에서 로그인 아이디를 가져와 자바스크립트 변수에 담습니다.
		var sessionId = "<%= (String)session.getAttribute("sessionId") %>";
		
		// 2. 사용자가 폼에 입력한 '주문 개수(number2)' 값을 가져옵니다.
		var quantity = document.addForm.number2.value;

		// 3. 비로그인 상태일 때 (경고창 + 이동)
		if (sessionId == "null" || sessionId == "") {
			alert("상품을 주문하려면 먼저 로그인을 해주세요!");
			location.href = "./member/loginMember.jsp"; 
			return; // 함수 종료
		} 
		
		// 4. 로그인 상태일 때 (수량 확인창 + 폼 전송)
		if (confirm("선택하신 상품 " + quantity + "개를 장바구니에 추가하시겠습니까?")) {
			// 확인(OK)을 누르면 addCart.jsp로 데이터를 전송합니다.
			document.addForm.action = "./addCart.jsp?id=<%=request.getParameter("id")%>";
			document.addForm.submit();
		}
	}
</script>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 정보</h1>
		</div>
	</div>
	<%
		String id = request.getParameter("id");
		String sql = "select * from product where p_id='"+id+"'";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		while (rs.next()) {
	%>
	<div class="container">
		<div class="row">
			<div class ="col-md-5">
				<img src="./resources/images/<%=rs.getString("p_fileName")%>" style="width: 100%">
			</div>
			<div class="col-md-6">
				<h3><%=rs.getString("p_name")%></h3>
				<p><%=rs.getString("p_description")%>
				<p><b>상품 코드 : </b><span class="badge badge-danger"><%=rs.getString("p_id")%></span>
				<p><b>제조사 : </b><%=rs.getString("p_manufacturer")%>
				<p><b>분류 : </b><%=rs.getString("p_category")%>
				<p><b>재고 수</b> : <%=rs.getString("p_unitsInStock")%>
				<h4><%=rs.getString("p_unitPrice")%>원</h4>
				
				<!-- 폼(form) 시작 -->
				<form name="addForm" method="post">
					<p><b>주문 개수 :</b>
						<input type="number" name="number2" id="number2" value="1" min="1">
					</p>
					
					<p>
						<a href="#" class="btn btn-info" onclick="addToCart()"> 상품 주문 &raquo;</a> 
						<a href="./cart.jsp" class="btn btn-warning"> 장바구니 &raquo;</a> 
						<a href="./products.jsp" class="btn btn-secondary"> 상품 목록 &raquo;</a>
					</p>
				</form>
			</div>
		</div>
		<hr>
	</div>
	<%
		}
				
		if (rs != null)
			rs.close();
 		if (pstmt != null)
 			pstmt.close();
 		if (conn != null)
			conn.close();
	%>
	<jsp:include page="footer.jsp" />
</body>
</html>