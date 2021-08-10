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
			alert("회원번호를 입력해주세요.")
			return f.memno.focus();
		}
		if (f.name.value == "") {
			alert("회원이름을 입력해주세요.")
			return f.name.focus();
		}
		if (f.address.value == "") {
			alert("주소를 입력해주세요.")
			return f.address.focus();
		}
		if (f.hiredate.value == "") {
			alert("가입일을 입력해주세요.")
			return f.hiredate.focus();
		}
		if (f.gender[0].check == false && f.gender[1].check == false) {
			alert("성별을 체크해주세요.")
			return;
		}
		if (f.tel1.value == "") {
			alert("전화번호를 입력해주세요.")
			return f.tel1.focus();
		}
		if (f.tel2.value == "") {
			alert("전화번호를 입력해주세요.")
			return f.tel2.focus();
		}
		if (f.tel3.value == "") {
			alert("전화번호를 입력해주세요.")
			return f.tel3.focus();
		}
		f.submit();
	}
	
	function reWrite() {
		/*
		var x = confirm("다시 쓰시겠습니까?");
		if (x == true) {
			f.reset();
			f.name.focus();
		}
		*/
		f.reset();
		f.name.focus();
	}
</script>
<body>
	<%@ include file = "header.jsp" %><!-- header.jsp안에 dbconn.jsp(DB연결) -->
	<%
	String memno = request.getParameter("memno");
	
	sql += "select name, address, ";
	sql += "to_char(hiredate, 'yyyy-mm-dd') as hiredate, ";
	sql += "gender, ";
	sql += "tel1, tel2, tel3";
	sql += " from member";
	sql += " where memno = '"+memno+"'";
	
	rs = stmt.executeQuery(sql);
	rs.next(); // 결과 레코드 1개
	
	String name = rs.getString("name"); // rs.getString(1)로 사용해도됨 // 1 = 출력순서.첫번째 출력되는것이 name이므로
	String address = rs.getString("address");
	String hiredate = rs.getString("hiredate"); // 별칭사용 시 참조시키는 이 실행문 필수
	String gender = rs.getString("gender");
	String tel1 = rs.getString("tel1");
	String tel2 = rs.getString("tel2");
	String tel3 = rs.getString("tel3");
	%>
	<section>
		<div>
			<h2>회원수정</h2>
		</div>
	<form action = "updatePro.jsp" name = "f" method = "post">
		<table border = "1" width = "400" style = "margin : 0 auto">
			<tr>
				<th>회원번호</th>
				<td>
					<input type = "text" name = "memno" value = "<%=memno%>" size = "10" maxlength = "4" readonly>
				</td>
			</tr>
			<tr>
				<th>회원이름</th>
				<td>
					<input type = "text" name = "name" value = "<%=name%>" size = "20" maxlength = "30">
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<input type = "text" name = "address" value = "<%=address%>" size = "40" maxlength = "100">
				</td>
			</tr>
			<tr>
				<th>가입일</th>
				<td>
					<input type = "text" name = "hiredate" value = "<%out.print(hiredate);%>" size = "20" readonly>
																<%-- <%=hiredate%>와 같다 %> --%>
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					&nbsp;&nbsp;<label><input type = "radio" name = "gender" value = "M" <%if(gender != null && gender.equalsIgnoreCase("M")){out.print("checked");} %>>남자</label>
					&nbsp;&nbsp;<label><input type = "radio" name = "gender" value = "F" <%if(gender != null && gender.equals("F")){out.print("checked='checked'");} %>>여자</label>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<input type = "text" name = "tel1" value = "<%=tel1%>" size = "5" maxlength = "3"> -
					<input type = "text" name = "tel2" value = "<%=tel2%>" size = "5" maxlength = "4"> -
					<input type = "text" name = "tel3" value = "<%=tel3%>" size = "5" maxlength = "4">
				</td>
			</tr>
			<tr>
				<th colspan = "2">
					<input type = "submit" value = "회원수정" onclick = "check(); return false">
					<input type = "reset" value = "다시쓰기"> <!-- reset : 처음상태로 돌아감 -->
					<!-- <input type = "button" value = "다시쓰기" onclick = "location = 'update.jsp'"> -->
				</th>
			</tr>
		</table>
	</form>
	</section>
	<%@ include file = "footer.jsp"%><!-- DB연결 해제 -->
</body>
</html>