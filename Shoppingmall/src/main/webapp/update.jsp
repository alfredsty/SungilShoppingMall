<%@ page import="DB.DBConnect"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String sql="select custno, custname, phone, address, "
			  +"to_char(joindate,'yyyymmdd') joindate, grade, city "
			  +"from member_tbl_02 where custno=" + request.getParameter("click_custno");

	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/style.css">
<script type="text/javascript">
	function checkValue() {
		if(!document.u_data.custname.value) {
			alert("회원성명을 입력하세요.");
			u_data.custname.focus();
			return false;
		} else if(!document.u_data.phone.value) {
			alert("전화번호를 입력하세요.");
			u_data.phone.focus();
			return false;
		} else if (!document.u_data.address.value) {
			alert("주소를 입력하세요.");
			u_data.address.focus();
			return false;
		} else if (!document.u_data.joindate.value) {
			alert("가입일자를 입력하세요.");
			u_data.joindate.focus();
			return false;
		} else if (!document.u_data.grade.value) {
			alert("고객등급을 입력하세요.");
			u_data.grade.focus();
			return false;
		}  else if (!document.u_data.city.value) {
			alert("도시코드를 입력하세요.");
			u_data.city.focus();
			return false;
		}
		alert("회원정보수정이 완료되었습니다.");
		return true;
	}
	function checkDel(custno) {
		msg="삭제하시겠습니까?";
		if(confirm(msg)!=0){
			alert("삭제");
			location.href="delete.jsp?d_custno="+custno;
		} else {
			alert("취소");
		}
	}
</script>
<title>update</title>
</head>
<body>
<header>
	  <jsp:include page="layout/header.jsp"></jsp:include>
 </header>

 <nav>
   	 <jsp:include page="layout/nav.jsp"></jsp:include>
 </nav>
		
 <section class="section">
   	 <h2>홈쇼핑 회원 정보수정</h2><br>
  <form name="u_data" action="update_p.jsp" method="post" onsubmit="return checkValue()">
			<table class="table_line">
				<tr>
					<th>회원번호</th>
					<td><input type="text" name="custno" value="<%= rs.getString("custno") %>"   readonly></td>
				</tr>
				<tr>
					<th>회원성명</th>
					<td><input type="text" name="custname" value="<%= rs.getString("custname") %>" ></td>
				</tr>
				<tr>
					<th>회원전화</th>
					<td><input type="text" name="phone" value="<%= rs.getString("phone") %>"  ></td>
				</tr>
				<tr>
					<th>회원주소</th>
					<td><input type="text" name="address" value="<%= rs.getString("address") %>"  ></td>
				</tr>
				<tr>
					<th>가입일자</th>
					<td><input type="text" name="joindate" value="<%= rs.getString("joindate") %>"  ></td>
				</tr>
				<tr>
					<th>고객등급[A:VIP,B:일반,C:직원]</th>
					<td><input type="text" name="grade" value="<%= rs.getString("grade") %>"  ></td>
				</tr>
				<tr>
					<th>도시코드</th>
					<td><input type="text" name="city" value="<%= rs.getString("city") %>"  ></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="수정">
						<input type="button" value="조회" onclick="location.href='member_list.jsp'">
						<input type="button" value="삭제" onclick="checkDel(<%= rs.getString("custno")%>);">
				</tr>
			</table>
		</form>		
</section>
<footer>
	<jsp:include page="layout/footer.jsp"></jsp:include>
</footer>
</body>
</html>