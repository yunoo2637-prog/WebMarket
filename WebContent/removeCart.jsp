<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.cart.CartItem"%>
<%
    String id = request.getParameter("id");
    
    if (id != null && !id.trim().equals("")) {
        // 제네릭 타입을 CartItem으로 변경
        ArrayList<CartItem> list = (ArrayList<CartItem>) session.getAttribute("cartlist");
        
        if (list != null) {
            for (int i = 0; i < list.size(); i++) {
                // CartItem 객체 안의 ProductId를 꺼내서 비교!
                if (list.get(i).getProductId().equals(id)) {
                    list.remove(i);
                    break; 
                }
            }
        }
    }
    response.sendRedirect("cart.jsp");
%>