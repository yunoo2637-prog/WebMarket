<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="dbconn.jsp"%>

<html>
<head>
<link rel ="stylesheet" href ="./resources/css/bootstrap.min.css" />
<title>상품 등록</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 코드 체크</h1>
		</div>
	</div>
	<div class="container">
		<div align="center">
			<%
				String askPid = request.getParameter("askPid");
				String sql = "select * from product where p_id='"+askPid+"'";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					out.println("<p>해당 상품 코드가 이미 존재하니 다른 코드를 사용하세요.");
				}
				else {
					out.println("<p>해당 상품 코드가 없으니 그대로 사용가능 합니다.");
				}
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			%>
			<p><a href="./addProduct.jsp?chkPid=<%=askPid%>" class="btn btn-info">상품 등록 페이지로 돌아가세요 &raquo;</a>
		</div>
		<hr>
	</div>
</body>
</html>