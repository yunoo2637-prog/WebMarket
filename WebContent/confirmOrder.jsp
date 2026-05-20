<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLDecoder"%>
<!-- 🎯 CartItem import는 이제 필요 없으므로 삭제했습니다! -->
<%@ include file="dbconn.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
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
			else if (n.equals("Shipping_name"))
				shipping_name = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			else if (n.equals("Shipping_shippingDate"))
				shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			else if (n.equals("Shipping_country"))
				shipping_country = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			else if (n.equals("Shipping_zipCode"))
				shipping_zipCode = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			else if (n.equals("Shipping_addressName"))
				shipping_addressName = URLDecoder.decode((thisCookie.getValue()), "utf-8");
		}
	}
%>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>주문 정보</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문 정보</h1>
		</div>
	</div>
	<div class="container col-8 alert alert-info">
		<div class="text-center ">
			<h1>영수증</h1>
		</div>
		<div class="row justify-content-between">
			<div class="col-4" align="left">
				<strong>배송 주소</strong> <br> 
				성명 : <% out.println(shipping_name); %><br> 
				우편번호 : <% out.println(shipping_zipCode);%><br> 
				주소 : <% out.println(shipping_addressName);%><br>
				국가 : <% out.println(shipping_country);%><br>
			</div>
			<div class="col-4" align="right">
				<p>	<em>배송일: <% out.println(shipping_shippingDate);%></em>
			</div>
		</div>
		<div>
			<table class="table table-hover">			
			<tr>
				<th class="text-center">상품</th>
				<th class="text-center">개수</th>
				<th class="text-center">가격</th>
				<th class="text-center">소계</th>
			</tr>
			<%
				// 🎯 [교체된 부분] cartlist와 ordernolist 쌍둥이 세션을 꺼냅니다.
				ArrayList<String> cartList = (ArrayList<String>) session.getAttribute("cartlist");
				ArrayList<Integer> orderNoList = (ArrayList<Integer>) session.getAttribute("ordernolist");
				
				if (cartList == null) {
					cartList = new ArrayList<String>();
					orderNoList = new ArrayList<Integer>();
				}
					
				int sum = 0;
				
				for (int i = 0; i < cartList.size(); i++) {
					String productIdInCart = cartList.get(i); // 상품 ID
					int quantity = orderNoList.get(i);        // 🎯 주문 개수 (ordernolist에서 꺼냄)
					
					String sql = "select * from product where p_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, productIdInCart);
					rs = pstmt.executeQuery();
					
					String name = "";
					int unitPrice = 0;
					int total = 0;
					
					if(rs.next()){
						name = rs.getString("p_name");
						unitPrice = rs.getInt("p_unitPrice");
						total = unitPrice * quantity; 
					}
					sum = sum + total;
			%>
			<tr>
				<td class="text-center"><em><%=name%></em></td>
				<td class="text-center"><%=quantity%></td>
				<td class="text-center"><%=unitPrice%>원</td>
				<td class="text-center"><%=total%>원</td>
			</tr>
			<%
				}
				// DB 자원 닫기
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
			%>
			<tr>
				<td> </td>
				<td> </td>
				<td class="text-right">	<strong>총액: </strong></td>
				<td class="text-center text-danger"><strong><%=sum%> 원 </strong></td>
			</tr>
			</table>
			
				<a href="./shippingInfo.jsp?cartId=<%=shipping_cartId%>" class="btn btn-secondary" role="button"> 이전 </a>
				<a href="./completeOrder.jsp"  class="btn btn-success" role="button"> 주문 완료 </a>
				<a href="./cancelOrder.jsp" class="btn btn-secondary" role="button"> 취소 </a>			
		</div>
	</div>	
</body>
</html>