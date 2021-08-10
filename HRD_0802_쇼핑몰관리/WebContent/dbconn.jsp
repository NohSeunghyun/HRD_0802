<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import = "java.sql.*"%>

<%
request.setCharacterEncoding("UTF-8");
Class.forName("oracle.jdbc.OracleDriver");
Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "1234");

Statement stmt = conn.createStatement(); //  select(조회)
PreparedStatement ps = null; // insert(추가), update(수정), delete(삭제)

ResultSet rs = null;
String sql = "";
%>