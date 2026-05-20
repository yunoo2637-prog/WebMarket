<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="dbconn.jsp"%>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>장바구니</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<!-- 상단 jumbotron 생략 (기존 코드 유지) -->
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">장바구니</h1>
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<table width="100%">
				<tr>
					<td align="left"><a href="./deleteCart.jsp" class="btn btn-danger">삭제하기</a></td>
					<td align="right"><a href="./shippingInfo.jsp" class="btn btn-success">주문하기</a></td>
				</tr>
			</table>
		</div>
		<div style="padding-top: 50px">
			<table class="table table-hover">
				<tr>
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
				<%
					int sum = 0;
					// 🎯 쌍둥이 리스트 꺼내기
					ArrayList<String> cartList = (ArrayList<String>) session.getAttribute("cartlist");
					ArrayList<Integer> orderNoList = (ArrayList<Integer>) session.getAttribute("ordernolist");
					
					if (cartList == null) {
						cartList = new ArrayList<String>();
						orderNoList = new ArrayList<Integer>();
					}

					for (int i = 0; i < cartList.size(); i++) {
						String productId = cartList.get(i);
						int qty = orderNoList.get(i); // 🎯 같은 인덱스에서 수량 꺼내기
						
						String sql = "select * from product where p_id = ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, productId);
						rs = pstmt.executeQuery();
						
						if (rs.next()) {
							int price = rs.getInt("p_unitPrice");
							int total = price * qty;
							sum += total;
				%>
				<tr>
					<td><%=rs.getString("p_id")%> - <%=rs.getString("p_name")%></td>
					<td><%=price%></td>
					<td><%=qty%></td>
					<td><%=total%></td>
					<td><a href="./removeCart.jsp?id=<%=productId%>" class="badge badge-danger">삭제</a></td>
				</tr>
				<%
						}
					}
					if (rs != null) rs.close();
					if (pstmt != null) pstmt.close();
				%>
				<tr>
					<th></th>
					<th></th>
					<th>총액</th>
					<th><%=sum%></th>
					<th></th>
				</tr>
			</table>
			<a href="./products.jsp" class="btn btn-secondary"> &laquo; 쇼핑 계속하기</a>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>