<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.net.URLDecoder"%>

<%
		String shipping_cartId = "";
		String shipping_name = "";
		String shipping_shippingDate = "";
		String shipping_country = "";
		String shipping_zipCode = "";
		String shipping_addressName = "";

		Cookie[] cookies = request.getCookies();

		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie thisCookie = cookies[i];
				String n = thisCookie.getName();
				if (n.equals("Shipping_cartId"))
					shipping_cartId = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				else if (n.equals("Shipping_shippingDate"))
					shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			}
		}
%>

<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>주문 완료</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	
	<%
		// 🎯 핵심: 주문이 끝났으니 장바구니 관련 세션 2개를 모두 삭제합니다!
		session.removeAttribute("cartlist");
		session.removeAttribute("ordernolist");
	
		String orderId = "ORD-" + System.currentTimeMillis();
	%>
	
	<!-- (아래는 기존 주문 완료 디자인 그대로 사용하시면 됩니다!) -->
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문 완료</h1>
		</div>
	</div>ass="container">
		<h2 class="alert alert-danger">주문해주셔서 감사합니다.</h2>
		<p>	주문은 <%out.println(shipping_shippingDate);%>에 배송될 예정입니다!!	
		<p>	주문번호 : <%out.println(shipping_cartId);%>		
	</div>
	<div class="container">
		<p>	<a href="./products.jsp" class="btn btn-secondary"> &laquo; 상품 목록</a>		
	</div>
</body>
</html>

<%
	session.invalidate();

	for (int i = 0; i < cookies.length; i++) {
		Cookie thisCookie = cookies[i];
		String n = thisCookie.getName();
		if (n.equals("Shipping_cartId"))
			thisCookie.setMaxAge(0);
		else if (n.equals("Shipping_name"))
			thisCookie.setMaxAge(0);
		else if (n.equals("Shipping_shippingDate"))
			thisCookie.setMaxAge(0);
		else if (n.equals("Shipping_country"))
			thisCookie.setMaxAge(0);
		else if (n.equals("Shipping_zipCode"))
			thisCookie.setMaxAge(0);
		else if (n.equals("Shipping_addressName"))
			thisCookie.setMaxAge(0);
		
		response.addCookie(thisCookie);
	}
%>
