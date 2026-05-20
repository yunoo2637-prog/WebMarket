<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="dbconn.jsp" %>
<%
	// 1. 넘어온 ID 낚아채기
	String id = request.getParameter("id");

	if (id != null && !id.trim().equals("")) {
		try {
			// 2. DB에서 진짜로 삭제하기
			String sql = "DELETE FROM product WHERE p_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("상품 삭제 중 오류 발생: " + e.getMessage());
		} finally {
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}
	}

	// 3. 삭제 완료 후 멍때리지 말고 깔끔하게 다시 목록으로 튕겨내기!
	response.sendRedirect("editProduct.jsp?edit=delete");
%>