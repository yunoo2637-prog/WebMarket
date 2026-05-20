<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ include file="dbconn.jsp" %>
<%
	String realFolder = request.getServletContext().getRealPath("/resources/images"); //이미지 파일 저장 및 접근 경로	
	String encType = "utf-8"; //인코딩 타입
	int maxSize = 5 * 1024 * 1024; //최대 업로드될 파일의 크기5Mb
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	String productId = multi.getParameter("productId");
	String name = multi.getParameter("name");
	String unitPrice = multi.getParameter("unitPrice");
	String description = multi.getParameter("description");
	String manufacturer = multi.getParameter("manufacturer");
	String category = multi.getParameter("category");
	String unitsInStock = multi.getParameter("unitsInStock");
	String condition = multi.getParameter("condition");
	
	Integer price;
	if (unitPrice == null || unitPrice.isEmpty()) // [수정] Null 에러 방지
		price = 0;
	else
		price = Integer.valueOf(unitPrice);
		
	long stock;
	if (unitsInStock == null || unitsInStock.isEmpty()) // [수정] Null 에러 방지
		stock = 0;
	else
		stock = Long.valueOf(unitsInStock);
		
	Enumeration files = multi.getFileNames();
	String fname = (String) files.nextElement();
	
	// [수정] 한글 설명글 앞에 주석(//) 처리하여 빨간 줄 해결
	String fileName = multi.getFilesystemName(fname); // 폼 서식에서 이미지 파일을 등록하지 않으면 null로 되어 이미지 파일 이름이 null로 된다.
	
	String sql = "select * from product where p_id = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, productId);
	rs = pstmt.executeQuery();
	
			//폼 서식에서 이미지 파일을 등록하지 않는다고 해서 이미지 파일 이름이 null로 수정되면 안 되므로 이미지 파일 이름이 null 여부에 따라 이미지 파일 이름을 변경 여부를 정한다.
			if (fileName != null) {
				sql = "UPDATE product SET p_name=?, p_unitPrice=?, p_description=?, p_manufacturer=?, p_category=?, p_unitsInStock=?, p_condition=?, p_fileName=? WHERE p_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setInt(2, price);
				pstmt.setString(3, description);
				pstmt.setString(4, manufacturer);
				pstmt.setString(5, category);
				pstmt.setLong(6, stock);
				pstmt.setString(7, condition);
				pstmt.setString(8, fileName);
				pstmt.setString(9, productId);
				pstmt.executeUpdate();
			} else {
				sql = "UPDATE product SET p_name=?, p_unitPrice=?, p_description=?, p_manufacturer=?, p_category=?, p_unitsInStock=?, p_condition=? WHERE p_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setInt(2, price);
				pstmt.setString(3, description);
				pstmt.setString(4, manufacturer);
				pstmt.setString(5, category);
				pstmt.setLong(6, stock);
				pstmt.setString(7, condition);
				pstmt.setString(8, productId);
				pstmt.executeUpdate();
			}
			
	if (rs != null)
		rs.close();
 	if (pstmt != null)
 		pstmt.close();
 	if (conn != null)
		conn.close();
		
	response.sendRedirect("editProduct.jsp?edit=update");
%>