<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="dbconn.jsp"%>
<%
	// 1. menu.jsp로부터 전달받은 edit 파라미터 추출 및 변수 설정
	String edit = request.getParameter("edit");
	String head1 = "";
	
	if (edit != null && edit.equals("update")) {
		head1 = "수정";
	} else if (edit != null && edit.equals("delete")) {
		head1 = "삭제";
	}
%>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>상품 편집</title>
<script type="text/javascript">
	// 2. 삭제 확인용 자바스크립트 함수 구현
	function deleteConfirm(id) {
		if (confirm("해당 상품을 삭제합니다!!")) {
			location.href = "deleteProduct.jsp?id=" + id;
		}
	}
</script>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 <%=head1%></h1>
		</div>
	</div>
	<div class="container">
		<div class="row" align="center">
			<%
				String sql = "select * from product";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
			%>
			<div class="col-md-4">
				<img src="./resources/images/<%=rs.getString("p_fileName")%>" style="width: 100%">
				<h3><%=rs.getString("p_name")%></h3>
				<p><%=rs.getString("p_description")%></p>
				<p><%=rs.getString("p_unitPrice")%>원</p>
				<p>
				<% if (edit != null && edit.equals("update")) { %>
					<a href="./updateProduct.jsp?id=<%=rs.getString("p_id")%>" class="btn btn-success" role="button"> 수정 &raquo;</a>
				<% } else if (edit != null && edit.equals("delete")) { %>
					<a href="#" onclick="deleteConfirm('<%=rs.getString("p_id")%>')" class="btn btn-danger" role="button"> 삭제 &raquo;</a>
				<% } %>
				</p>
			</div>
			<%
				}
				if (rs != null) rs.close();
	 			if (pstmt != null) pstmt.close();
	 			if (conn != null) conn.close();
 			%>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>