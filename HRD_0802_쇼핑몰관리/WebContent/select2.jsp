<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰관리 프로그램</title>
</head>
<body>
	<%@ include file = "header.jsp" %><!-- header.jsp안에 dbconn.jsp(DB연결) -->
	<section>
		<div>
			<h2>매출조회</h2>
		</div>
		<table style = "margin : 0 auto" border = "1" width = 90%>
			<tr>
				<th>등급</th>
				<th>회원번호</th>
				<th>이름</th>
				<th>구입액</th>
			</tr>
			<%
			sql += "select decode(memgrade, '1', 'VIP', '2', 'GOLD', '3', 'SILVER', '4', 'NORMAL') as memgrade,"; // 초기값 null일 경우 +를 빼고 =만 사용
			sql += " memno, name, totalprice";
			sql += " from grade join (select memno, name, sum(price*bno) as totalprice";
			sql += " from member natural join buy";
			sql += " group by memno, name)";
			sql += " on (totalprice between loprice and hiprice)";
			sql += " order by totalprice desc";
			rs = stmt.executeQuery(sql);
				while(rs.next()) {
			%>
			<tr align = "center">
				<td><%=rs.getString(1)%></td>
				<td><%=rs.getString(2)%></td>
				<td><%=rs.getString(3)%></td>
				<td><%=rs.getString(4)%></td>
			</tr>
			<%
				}
			%>
		</table>
	</section>
	<%@ include file = "footer.jsp" %><!-- DB연결 해제 -->
</body>
</html>