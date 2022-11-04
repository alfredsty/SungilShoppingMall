<%@ page import="DB.DBConnect"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String sql="select mb.custno, mb.custname, "
			  +"case when grade = 'A' then 'VIP' "
			  +"when grade = 'B' then '일반' else '직원' end grade, "
			  +"sum(mo.price) price from member_tbl_02 mb, money_tbl_02 mo "
			  +"where mb.custno = mo.custno and mo.price is not null "
			  +"group by mb.custno, mb.custname, mb.grade "
			  +"order by sum(mo.price) desc";

	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>sales_list</title>
</head>
<body>
<header>
	  <jsp:include page="layout/header.jsp"></jsp:include>
 </header>

 <nav>
   	 <jsp:include page="layout/nav.jsp"></jsp:include>
 </nav>
		
 <section class="section">
   	 <h2>회원매출조회</h2><br>

    <table class="table_line">
			<tr>
				<th>회원번호</th>
				<th>회원성명</th>
				<th>고객등급</th>
				<th>매출</th>
			</tr>
			<%
			int i=0;
			
				while(rs.next()) {
			%>
			<tr class="center">
				<td><%= rs.getString("custno")%></td>
				<td><%= rs.getString("custname") %></td>
				<td><%= rs.getString("grade") %></td>
				<td><%= rs.getString("price") %></td>
			</tr>
			<%
			 i += Integer.parseInt(rs.getString("price"));  
				}
			%>
			<tr class="center">
			<td colspan="3">총합</td>
			<td><%= i %></td>
			</tr>
		</table>
		
</section>
<footer>
	<jsp:include page="layout/footer.jsp"></jsp:include>
</footer>

</body>
</html>