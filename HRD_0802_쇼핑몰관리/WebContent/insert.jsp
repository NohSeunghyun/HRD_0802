<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰관리 프로그램</title>
</head>
<script type="text/javascript">
	function check() {
		if (f.memno.value == "") {
			alert("회원번호를 입력해주세요.");
			return f.memno.focus();
		}
		if (f.name.value == "") {
			alert("회원이름을 입력해주세요.");
			return f.name.focus();
		}
		if (f.address.value == "") {
			alert("주소를 입력해주세요.");
			return f.address.focus();
		}
		if (f.hiredate.value == "") {
			alert("가입일을 입력해주세요.");
			return f.hiredate.focus();
		}
		if (f.gender[0].checked == false && f.gender[1].checked == false) {
			alert("성별을 체크해주세요.");
			return;
		}
		if (f.tel1.value == "") {
			alert("전화번호를 입력해주세요.");
			return f.tel1.focus();
		}
		if (f.tel2.value == "") {
			alert("전화번호를 입력해주세요.");
			return f.tel2.focus();
		}
		if (f.tel3.value == "") {
			alert("전화번호를 입력해주세요.");
			return f.tel3.focus();
		}
		f.submit();
	}
</script>
<body>
	<%@ include file = "header.jsp" %><!-- header.jsp안에 dbconn.jsp(DB연결) -->
	<%
	sql = "select nvl(max(memno), 0)+1 as memno from member";
	rs = stmt.executeQuery(sql);
	rs.next();
	String memno = rs.getString("memno");
	
	sql = "select to_char(sysdate, 'yyyy-mm-dd') as hiredate from dual";
	rs = stmt.executeQuery(sql);
	rs.next();
	String hiredate = rs.getString("hiredate");
	
	%>
	<section>
		<div>
			<h2>회원등록</h2>
		</div>
	<form action = "insertPro.jsp" name = "f" method = "post">
		<table border = "1" width = "400" style = "margin : 0 auto">
			<tr>
				<th>회원번호</th>
				<td>
					<input type = "text" name = "memno" value = "<%=memno%>" size = "10" maxlength = "4" readonly = "readonly">자동입력
				</td>
			</tr>
			<tr>
				<th>회원이름</th>
				<td>
					<input type = "text" name = "name" value = "" size = "20" maxlength = "30">
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<input type = "text" name = "address" value = "" size = "40" maxlength = "100">
				</td>
			</tr>
			<tr>
				<th>가입일</th>
				<td>
					<input type = "text" name = "hiredate" value = "<%=hiredate%>" size = "20" readonly = "readonly">자동입력
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					&nbsp;&nbsp;<label><input type = "radio" name = "gender" value = "M">남자</label>
					&nbsp;&nbsp;<label><input type = "radio" name = "gender" value = "F">여자</label>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<input type = "text" name = "tel1" value = "" size = "5" maxlength = "3"> -
					<input type = "text" name = "tel2" value = "" size = "5" maxlength = "4"> -
					<input type = "text" name = "tel3" value = "" size = "5" maxlength = "4">
				</td>
			</tr>
			<tr>
				<th colspan = "2">
					<input type = "submit" value = "회원등록" onclick = "check(); return false">
					<input type = "button" value = "조회" onclick = "location = 'select.jsp'">
				</th>
			</tr>
		</table>
	</form>
	</section>
	<%@ include file = "footer.jsp"%><!-- DB연결 해제 -->
</body>
</html>