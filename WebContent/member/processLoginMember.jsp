<%@ include file="/dbconn.jsp"%>

<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	String sql = "select * from member where id=? and password=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	pstmt.setString(2, password);
	rs = pstmt.executeQuery();
	if(rs.next()){
		session.setAttribute("sessionlogin", "user");
		session.setAttribute("sessionId", id); 
		
		Cookie userId = new Cookie("UserId", id);
		Cookie passWord = new Cookie("PassWord", password);
		response.addCookie(userId);
		response.addCookie(passWord);
		
		if (rs != null) rs.close();							
		if (pstmt != null) pstmt.close();				
		if (conn != null) conn.close();
		
		response.sendRedirect("resultMember.jsp?msg=2");
	}
	else{
		if (rs != null) rs.close();							
		if (pstmt != null) pstmt.close();				
		if (conn != null) conn.close();
		
		response.sendRedirect("loginMember.jsp?error=1");
	}
%>