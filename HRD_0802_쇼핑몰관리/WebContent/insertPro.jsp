<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- DB와 연결 -->
<%@ include file = "dbconn.jsp" %>

<%
try {
// 방법2. prepareStatement 구문객체 사용
sql = "insert into member values (?, ?, ?, ?, ?, ?, ?, ?)";
// sql문을 매개값으로 PrepareStament 객체 생성
ps = conn.prepareStatement(sql); // 컴파일되어 DBMS로 넘김 -> 속도가빠름.
ps.setString(1, request.getParameter("memno"));
ps.setString(2, request.getParameter("name"));
ps.setString(3, request.getParameter("address"));
ps.setString(4, request.getParameter("hiredate"));
ps.setString(5, request.getParameter("gender"));
ps.setString(6, request.getParameter("tel1"));
ps.setString(7, request.getParameter("tel2"));
ps.setString(8, request.getParameter("tel3"));

ps.executeUpdate(); // 성공 : 예외객체 생성X
%>
<!-- 성공알림창-script -->
<script>
	alert("회원 등록이 완료되었습니다.");
	location = "insert.jsp"; // 이 코드가 더 간결함
	//location.href("insert.jsp"); // 이 코드 사용해도됨
</script>
<%
} // 성공
catch (Exception e){ // 실패하면 예외객체가 만들어짐.
%>
<script>
alert("회원 등록이 실패하였습니다.");
//location = "insert.jsp"; // 실패시 등록화면으로
history.back(); // 그전 단계로 돌아간다. // 위 코드와 같은 결과
//history.go(-1); // 이전 페이지로 돌아간다. -2 : 이전의 이전페이지 -3 : 이전의 이전의 이전 페이지
</script>
<%
} finally { // 예외발생 여부에 관계없이 무조건 실행
// DB와 연결 해제 
	try {
		if(conn != null) conn.close();
		if(stmt != null) stmt.close();
		if(ps != null) ps.close();
		if(rs != null) rs.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
}
%>