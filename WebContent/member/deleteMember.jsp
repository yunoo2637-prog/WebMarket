<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="../dbconn.jsp"%>
<%
    // 1. 세션에서 현재 로그인된 아이디 가져오기
    String sessionId = (String) session.getAttribute("sessionId");

    // 로그인 상태가 아니라면 실행 중단
    if (sessionId == null || sessionId.equals("")) {
        response.sendRedirect("loginMember.jsp");
        return;
    }

    int deleteResult = 0;

    try {
        // 2. DB에서 해당 아이디의 레코드를 완전히 삭제하는 쿼리
        String sql = "DELETE FROM member WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, sessionId);
        
        deleteResult = pstmt.executeUpdate();

    } catch (SQLException e) {
        out.println("🔥 [회원탈퇴 DB 에러] : " + e.getMessage());
    } finally {
        // 3. 자원 해제
        if (pstmt != null) pstmt.close();
    }

    // 4. 삭제 성공 시 세션 종료 및 알림
    if (deleteResult > 0) {
        session.invalidate(); // 🎯 세션 무효화 (로그아웃 처리)
%>
        <script>
            alert("회원 탈퇴가 완료되었습니다. 그동안 이용해주셔서 감사합니다.");
            location.href = "../welcome.jsp"; // 메인 페이지로 이동
        </script>
<%
    } else {
%>
        <script>
            alert("회원 탈퇴 처리에 실패했습니다.");
            history.back();
        </script>
<%
    }
%>