<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.cart.CartItem"%>
<%
    // 제네릭 타입을 CartItem으로 변경
    ArrayList<CartItem> list = (ArrayList<CartItem>) session.getAttribute("cartlist");
    
    if (list != null) {
        list.clear();
    }
    response.sendRedirect("cart.jsp");
%>