<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<footer><!-- ⓒ쓰는법 : [한글 ㅇ -> 한자 -> 3번 => ⓒ] or [&copy;]-->
		HRDKOREA Copyright&copy;2019 All reserved.
	</footer>
</body>
</html>
<!-- ★★DB연결 해제 -->
<%
	try {
		if(conn != null) conn.close();
		if(stmt != null) stmt.close();
		if(ps != null) ps.close();
		if(rs != null) rs.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
%>