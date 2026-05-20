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
	
	// 가입일자 타임스탬프 생성
	java.util.Date currentDatetime = new java.util.Date(System.currentTimeMillis());
	java.sql.Timestamp timestamp = new java.sql.Timestamp(currentDatetime.getTime());

	int insertResult = 0; 

	try {
		// 🎯 핵심 수정: UPDATE가 아니라 INSERT INTO를 사용해야 합니다!
		String sql = "INSERT INTO member VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, password);
		pstmt.setString(3, name);
		pstmt.setString(4, gender);
		pstmt.setString(5, birth);
		pstmt.setString(6, email);
		pstmt.setString(7, phone);
		pstmt.setString(8, address);
		pstmt.setTimestamp(9, timestamp);
		
		insertResult = pstmt.executeUpdate();
		
	} catch (SQLException e) {
		// 브라우저 화면에 에러 바로 띄우기 (진단용)
		out.println("<h1 style='color:red;'>회원가입 DB 에러 발생!</h1>");
		out.println("<p>내용: " + e.getMessage() + "</p>");
		out.println("<button onclick='history.back()'>돌아가기</button>");
		return; 
	} finally {
		if (pstmt != null) pstmt.close();
	}

	// 3. 가입 성공 여부에 따른 이동
	if (insertResult >= 1) {
		// msg=1 은 "회원가입을 축하합니다" 메시지용
		response.sendRedirect("resultMember.jsp?msg=1");
	} else {
		out.println("<h1>가입 실패: 알 수 없는 이유로 데이터가 저장되지 않았습니다.</h1>");
	}
%>