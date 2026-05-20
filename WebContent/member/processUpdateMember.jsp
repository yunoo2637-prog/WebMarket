<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="../dbconn.jsp"%>
<%
	// 1. 폼 데이터 한글 인코딩
	request.setCharacterEncoding("UTF-8");

	// 2. 폼에서 넘어온 데이터 받기
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	
	String year = request.getParameter("birthyy");
	String month = request.getParameterValues("birthmm")[0];
	String day = request.getParameter("birthdd");
	String birth = year + "/" + month + "/" + day;
	
	String mail1 = request.getParameter("mail1");
	String mail2 = request.getParameterValues("mail2")[0];
	String email = mail1 + "@" + mail2;
	
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");

	int updateResult = 0; // 🎯 DB 업데이트 성공 여부를 확인할 변수

	try {
		// 3. 🎯 가장 중요한 부분! mail=? 이 아니라 email=? 로 완벽히 수정!
		String sql = "UPDATE member SET password=?, name=?, gender=?, birth=?, email=?, phone=?, address=? WHERE id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, password);
		pstmt.setString(2, name);
		pstmt.setString(3, gender);
		pstmt.setString(4, birth);
		pstmt.setString(5, email);
		pstmt.setString(6, phone);
		pstmt.setString(7, address);
		pstmt.setString(8, id);
		
		// 🎯 쿼리 실행 후 몇 줄이 수정되었는지 숫자로 받아옵니다. (성공하면 1)
		updateResult = pstmt.executeUpdate();
		
	} catch (SQLException e) {
		System.out.println("🔥 [DB 업데이트 에러 발생] : " + e.getMessage());
	} finally {
		// 4. DB 자원 닫기
		if (pstmt != null) pstmt.close();
		// 주의: dbconn.jsp에서 열어둔 conn은 다른 페이지에서도 써야 할 수 있으므로 여기서 닫지 않는 것이 안전할 때가 많습니다.
	}

	// 5. 🎯 진짜로 DB 수정이 성공했을 때만 완료 페이지로 넘김!
	if (updateResult > 0) {
		response.sendRedirect("resultMember.jsp?msg=0");
	} else {
		// 실패했으면 가짜 성공 화면 대신 경고창을 띄우고 뒤로 돌려보냄
		out.println("<script>");
		out.println("alert('회원정보 수정에 실패했습니다. (콘솔 창의 에러를 확인하세요!)');");
		out.println("history.back();");
		out.println("</script>");
	}
%>