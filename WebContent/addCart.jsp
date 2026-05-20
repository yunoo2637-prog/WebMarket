<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%
	request.setCharacterEncoding("UTF-8");

	// 1. 넘어온 상품 ID와 개수 받기
	String id = request.getParameter("id");
	String qtyStr = request.getParameter("number2");
	
	if (id == null || id.trim().equals("")) {
		response.sendRedirect("products.jsp");
		return;
	}
	
	int quantity = 1; // 기본 개수
	if (qtyStr != null && !qtyStr.isEmpty()) {
		quantity = Integer.parseInt(qtyStr);
	}

	// 2. 세션에서 두 개의 쌍둥이 리스트 꺼내기
	ArrayList<String> cartList = (ArrayList<String>) session.getAttribute("cartlist");
	ArrayList<Integer> orderNoList = (ArrayList<Integer>) session.getAttribute("ordernolist");

	// 세션이 비어있으면 새로 만들기
	if (cartList == null) {
		cartList = new ArrayList<String>();
		orderNoList = new ArrayList<Integer>();
		session.setAttribute("cartlist", cartList);
		session.setAttribute("ordernolist", orderNoList);
	}

	boolean isAlreadyInCart = false;

	// 3. 이미 장바구니에 있는 상품인지 확인
	for (int i = 0; i < cartList.size(); i++) {
		if (cartList.get(i).equals(id)) {
			// 이미 있다면 개수만 누적해서 더해줌
			int existingQty = orderNoList.get(i);
			orderNoList.set(i, existingQty + quantity);
			isAlreadyInCart = true;
			break;
		}
	}

	// 4. 처음 담는 상품이라면 두 리스트의 끝에 각각 추가
	if (!isAlreadyInCart) {
		cartList.add(id);
		orderNoList.add(quantity);
	}

	// 다시 상품 페이지로 이동
	response.sendRedirect("product.jsp?id=" + id);
%>