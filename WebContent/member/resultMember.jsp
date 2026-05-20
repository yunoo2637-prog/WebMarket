<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
<title>회원 정보</title>
</head>
<body>
	<jsp:include page="/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원 정보</h1>
		</div>
	</div>
	<div class="container" align="center">
		<%
			// 🎯 1. 세션 사물함에서 로그인한 아이디를 꺼냅니다.
			String sessionId = (String) session.getAttribute("sessionId");
			
			String msg = request.getParameter("msg");
			if (msg != null) {
				if (msg.equals("0"))
					out.println(" <h2 class='alert alert-danger'>회원정보가 수정되었습니다.</h2>");
				else if (msg.equals("1"))
					out.println(" <h2 class='alert alert-danger'>회원가입을 축하드립니다.</h2>");
				else if (msg.equals("2")) {
					// 🎯 2. 원래 쓰시던 툴(alert-danger) 그대로, 안에 들어가는 글자만 아이디로 바꿔치기합니다!
					out.println(" <h2 class='alert alert-danger'>[" + sessionId + "님] 환영합니다</h2>");
				}				
			} else {
				out.println("<h2 class='alert alert-danger'>회원정보가 삭제되었습니다.</h2>");
			}
		%>
	</div>	
</body>
</html>