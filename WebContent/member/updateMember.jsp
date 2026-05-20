<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="../dbconn.jsp"%>
<%
	// 1. 세션에서 로그인한 아이디 가져오기
	String loginId = (String) session.getAttribute("sessionId");
%>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
<title>회원 수정</title>
</head>
<body onload="init()">
	<jsp:include page="/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원 수정</h1>
		</div>
	</div>
	
	<%
		// 2. JSTL 대신 순수 자바 코드로 회원 정보 조회
		String sql = "SELECT * FROM member WHERE id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, loginId);
		rs = pstmt.executeQuery();
		
		if (rs.next()) {
			String id = rs.getString("id");
			String password = rs.getString("password");
			String name = rs.getString("name");
			String gender = rs.getString("gender");
			
			// null 방어 코드 (빈칸일 경우 서버가 뻗는 것을 방지)
			String birth = rs.getString("birth");
			if(birth == null) birth = "";
			
			// 🎯 JSTL 에러의 원인이었던 이메일 컬럼 완벽 수정! (mail -> email)
			String email = rs.getString("email");
			if(email == null) email = "";
			
			String phone = rs.getString("phone");
			if(phone == null) phone = "";
			
			String address = rs.getString("address");
			if(address == null) address = "";
			
			// 이메일 안전하게 자르기
			String mail1 = "";
			String mail2 = "";
			if (email.contains("@")) {
				String[] mailArr = email.split("@");
				mail1 = mailArr[0];
				mail2 = (mailArr.length > 1) ? mailArr[1] : "";
			} else {
				mail1 = email;
			}
			
			// 생년월일 안전하게 자르기
			String year = "", month = "", day = "";
			if (birth.contains("/")) {
				String[] birthArr = birth.split("/");
				year = (birthArr.length > 0) ? birthArr[0] : "";
				month = (birthArr.length > 1) ? birthArr[1] : "";
				day = (birthArr.length > 2) ? birthArr[2] : "";
			} else {
				year = birth;
			}
	%>
	
	<div class="container">
		<form name="newMember" class="form-horizontal" action="processUpdateMember.jsp" method="post" onsubmit="return checkForm()">
			<div class="form-group row">
				<label class="col-sm-2 ">아이디</label>
				<div class="col-sm-3">
					<input name="id" type="text" class="form-control" value="<%=id%>" readonly />
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">비밀번호</label>
				<div class="col-sm-3">
					<input name="password" type="password" class="form-control" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">비밀번호확인</label>
				<div class="col-sm-3">
					<!-- 🎯 '비밀번호 동일하게 입력' 에러 방지를 위해 확인 칸도 미리 채워둠 -->
					<input name="password_confirm" type="password" class="form-control" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">성명</label>
				<div class="col-sm-3">
					<input name="name" type="text" class="form-control" value="<%=name%>" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">성별</label>
				<div class="col-sm-10">
					<!-- JSTL의 <c:if> 대신 자바 조건문을 사용하여 라디오 버튼 체크 -->
					<input name="gender" type="radio" value="남" <%= "남".equals(gender) ? "checked" : "" %>> 남 
					<input name="gender" type="radio" value="여" <%= "여".equals(gender) ? "checked" : "" %>> 여
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">생일</label>
				<div class="col-sm-4">
					<input type="text" name="birthyy" maxlength="4" size="6" value="<%=year%>">
						<select name="birthmm" id="birthmm">
							<option value="">월</option>
							<option value="01">1</option>
							<option value="02">2</option>
							<option value="03">3</option>
							<option value="04">4</option>
							<option value="05">5</option>
							<option value="06">6</option>
							<option value="07">7</option>
							<option value="08">8</option>
							<option value="09">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select> 
					<input type="text" name="birthdd" maxlength="2" size="4" value="<%=day%>">
				</div>
			</div>
			<div class="form-group row ">
				<label class="col-sm-2">이메일</label>
				<div class="col-sm-10">
					<input type="text" name="mail1" maxlength="50" value="<%=mail1%>"> @
					<select name="mail2" id="mail2">
						<option value="">선택</option>
						<option value="naver.com">naver.com</option>
						<option value="daum.net">daum.net</option>
						<option value="gmail.com">gmail.com</option>
						<option value="nate.com">nate.com</option>
					</select>
				</div>
			</div>		
			<div class="form-group  row">
				<label class="col-sm-2">전화번호</label>
				<div class="col-sm-3">
					<input name="phone" type="text" class="form-control" value="<%=phone%>">
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2 ">주소</label>
				<div class="col-sm-5">
					<input name="address" type="text" class="form-control" value="<%=address%>">
				</div>
			</div>
			<div class="form-group  row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="submit" class="btn btn-primary" value="회원수정"> 
					<a href="deleteMember.jsp" class="btn btn-primary">회원탈퇴</a>
				</div>
			</div>
		</form>	
	</div>
	
	<!-- 콤보박스(월, 이메일) 초기값을 설정해주는 스크립트 호출 부분 -->
	<script type="text/javascript">
		function init() {
			setComboMailValue("<%=mail2%>");
			setComboBirthValue("<%=month%>");
		}
	</script>
	
	<%
		} // if(rs.next()) 종료
		
		// 3. 자원 해제
		if (rs != null) rs.close();
		if (pstmt != null) pstmt.close();
	%>
	
<script type="text/javascript">
	function setComboMailValue(val) {
		var selectMail = document.getElementById('mail2');
		for (i = 0, j = selectMail.length; i < j; i++) {
			if (selectMail.options[i].value == val) {
				selectMail.options[i].selected = true; 
				break;
			}
		}
	}
	function setComboBirthValue(val) {
		var selectBirth = document.getElementById('birthmm'); 
		for (i = 0, j = selectBirth.length; i < j; i++){
			if (selectBirth.options[i].value == val){
				selectBirth.options[i].selected = true; 
				break;
			}
		}
	}
	function checkForm() {
		if (!document.newMember.password.value) {
			alert("비밀번호를 입력하세요.");
			return false;
		}
		if (document.newMember.password.value != document.newMember.password_confirm.value) {
			alert("비밀번호를 동일하게 입력하세요.");
			return false;
		}
	}
</script>
</body>
</html>