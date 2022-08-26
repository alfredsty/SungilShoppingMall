# SungilShoppingMall
# 구현 목록
### 메인 페이지(Index.jsp)
![image](https://user-images.githubusercontent.com/102028778/186560993-f099fa84-bf1e-4c49-a0bb-7f4af94a5000.png)
### 회원등록 페이지(join.jsp)
![image](https://user-images.githubusercontent.com/102028778/186561901-07b8bc5d-aa3d-4128-ab8a-4b8dbaa0580b.png)
### 회원목록조회/수정 페이지(member_list.jsp)
![image](https://user-images.githubusercontent.com/102028778/186562480-fba716ea-5d93-4cf6-b205-ad16cf72aeaf.png)

# 기능 설명
## 데이터베이스 연결

```java
package DB;

import java.sql.*;

public class DBConnect {

	public static Connection getConnection() {
		Connection conn = null;
		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "system";
		String pw = "1234";
		
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(url, id, pw);
			
			System.out.println("DB test");
		} catch(Exception e) {
			e.printStackTrace();
		}

		return conn;
	}
}
```
* 데이터베이스 연결 
![image](https://user-images.githubusercontent.com/102028778/186582624-7645a40c-3878-4939-b72f-5a8b31565a36.png)
여기서 Connection은 데이터베이스 연결 설정을 하는 인터페이스다. Connection안에서 sql문이 실행되고 반환이 됨.

![image](https://user-images.githubusercontent.com/102028778/186582885-41166257-8b43-4e8d-a6c6-4a6ad10e6e34.png)
### String으로 선언된 각각의 변수들의 의미는 다음과 같다.

-url : 호스트주소<br>
-id : oracle 생성 당시 사용한 계정<br>
-pw : 비밀번호

![image](https://user-images.githubusercontent.com/102028778/186583205-1e329c17-b76a-4983-b0fa-4c1742b2ac56.png)

Try Catch 내부 코드를 차근차근 하나씩 설명하자면

![image](https://user-images.githubusercontent.com/102028778/186583890-e028316c-650e-49a9-a0d0-a5920473251b.png)

Class의 ForName()이라는 함수를 써서 오라클드라이버에 로드시키고 DriverManager에 등록함.(접근하는 동시에 객체가 생성됨)

![image](https://user-images.githubusercontent.com/102028778/186583992-a5c99abc-3476-41e6-a32c-60f57bb31506.png)

GetConnection()함수는 DriverManager에 등록된 오라클드라이버를 식별한다. jdbc드라이버의 url,id,pw를 식별한다.

![image](https://user-images.githubusercontent.com/102028778/186586085-5e484e10-bdec-4d54-bc0d-aec1dc54354c.png)

url,id,pw가 모두 일치하면 DB에 연결하고 DB test라는 문구를 띄우게 함.

![image](https://user-images.githubusercontent.com/102028778/186795547-87fcea9a-1284-4805-aef1-a8eb61cba0b6.png)

DB연결이 완료되었을 때 콘솔창

## 데이터베이스 테이블을 생성한 쿼리문
```sql
create table member_tbl_02(
 custno number(6) primary key,
 custname varchar2(20),
  phone varchar2(13),
  address varchar2(60),
  joindate date,
  grade char(1),
  city char(2));
  
  insert into member_tbl_02 values(100001,'김행복','010-1111-2222',' 서울 동대문구 휘경1동', '20151202','A','01');
  insert into member_tbl_02 values(100002,'이축복','010-1111-3333',' 서울 동대문구 휘경2동', '20151206','B','01');
  insert into member_tbl_02 values(100003,'장믿음','010-1111-4444',' 울릉군 울릉읍 독도1리', '20151001','B','30');
  insert into member_tbl_02 values(100004,'최사랑','010-1111-5555',' 울릉군 울릉읍 독도2리', '20151113','A','30');
  insert into member_tbl_02 values(100005,'진평화','010-1111-6666',' 제주도 제주시 외나무골', '20151225','B','60');
  insert into member_tbl_02 values(100006,'차공단','010-1111-7777',' 제주도 제주시 감나무골', '20151211','C','60');

```

* custno는 회원번호기 때문에 중복되지 않게 기본키(Primary Key)로 써줌.

## 회원번호 자동발생
```java
<%@ page import="DB.DBConnect"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String sql="select max(custno) from member_tbl_02";

	Connection conn = DBConnect.getConnection(); // DB 연결
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
	rs.next();
	int num = rs.getInt(1)+1;
%>
```

* PreparedStatement는 텍스트를 sql로 호출하는 클래스인데 이 클래스를 String객체에 담긴 select max(custno) from member_tbl_02라는 sql 문장을 pstmt라는 변수에 담아 ResultSet의 객체 값을 반환시킨다.(excuteQuery함수는 select구문 실행할 때만 쓰임) 그러면 num값을 불러올 때 마다  member_tbl_02 테이블에 있는 custno의 최대값을 정수형으로 받아와 +1을 해주고 반환하는 코드이다.

![image](https://user-images.githubusercontent.com/102028778/186581519-f27180f2-8b1f-4c8d-96b5-6a9cb334d645.png)

위 사진을 보면 value 값이 num인것을 볼 수 있다.

![image](https://user-images.githubusercontent.com/102028778/186795655-3769255d-5a5f-444f-b82f-75bc2443b211.png)

회원번호가 100006까지 있으므로 100007로 생성되는것을 볼 수 있다.

## 회원등록시 데이터베이스에 추가시키는 코드
```java
<%@ page import="DB.DBConnect"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sql="insert into member_tbl_02 values (?, ?, ?, ?, ?, ?, ?)";
	
	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setInt(1, Integer.parseInt(request.getParameter("custno")));
	pstmt.setString(2, request.getParameter("custname"));
	pstmt.setString(3, request.getParameter("phone"));
	pstmt.setString(4, request.getParameter("address"));
	pstmt.setString(5, request.getParameter("joindate"));
	pstmt.setString(6, request.getParameter("grade"));
	pstmt.setString(7, request.getParameter("city"));
	
	pstmt.executeUpdate();
%>

```
* 전체 코드는 이러하다.
* Connection과 PreparedStatement는 이미 위에서 설명했기 때문에 생략하곘다.

![image](https://user-images.githubusercontent.com/102028778/186589288-e5d3ee2d-beca-428f-a320-a439c7751931.png)

member_tbl_02 values 테이블에 ?값을 넣어줄거다.

값이 왜 ?로 되어있냐면  나중에  pstmt.set으로 매개변수를 가져와서 넣어주기 때문이다.

![image](https://user-images.githubusercontent.com/102028778/186589699-fa102cc5-1b30-453c-b079-6c32d0edfc31.png)

String sql에 각각의 매개변수를 받아와 값을 넣어준다.

모든 값이 String이기 때문에 setString으로 쓰이지만 custno(회원번호)는 예외이다. 매개변수를 정수로 넘기기 때문에 Integer.parseInt로 형변환을 해주어 값을 전달 받는다.

![image](https://user-images.githubusercontent.com/102028778/186590368-6270d508-d200-4f71-989a-2541dd9d3ffb.png)

값을 다 전달 받았으면 excuteUpdate함수를 통해 쿼리문이 실행됨.

* 추가로 excuteUpdate는 SELECT문을 제외한 다른 쿼리문을 실행할 때 쓰임.

![image](https://user-images.githubusercontent.com/102028778/186796223-86bdb6d0-579f-406b-9278-6a85818eb3c9.png)

넘겨줄 데이터를 적고 등록버튼을 눌러주면

![image](https://user-images.githubusercontent.com/102028778/186796551-776e0d6f-cbd2-4de0-86b1-0ba365554709.png)

테이블을 조회했을 때 

![image](https://user-images.githubusercontent.com/102028778/186796603-8bed43c7-da96-4617-ae72-365cad24d1b8.png)

제대로 등록이 되어있는것이 확인됨.

## 데이터베이스에 있는 값 회원목록에 띄우기

```java
<%@ page import="DB.DBConnect"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String sql="select custno, custname, phone, address, "
	          +"to_char(joindate,'yyyy-mm-dd') joindate, "
			  +"case when grade = 'A' then 'VIP' when grade = 'B' then '일반' else '직원' end grade, "
			  +"city from member_tbl_02 order by custno asc";

	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
%>   

```

똑같이 Connection 후  텍스트를 쿼리문으로 호출하기 위해 PreparedStatment를 써줌

우리는 반환받을 sql 변수에 담긴 내용만 보면 됨.

sql문을 보면 member_tbl_02테이블을 조회하는데  custno, custname, phone, address는 평범하지만 joindate와 grade는 조금 이상하다. 같이 보자.

![image](https://user-images.githubusercontent.com/102028778/186592939-518d8cb2-a01a-4157-b939-d59f430e758a.png)

일단 to_char함수는 날짜 혹은 숫자를 문자열로 바꾸기 위해 쓰이는데 날짜를 문자열로 바꿔 yyyy-mm-dd와 같은 형태로 바꾸기 위해 쓰였다.

![image](https://user-images.githubusercontent.com/102028778/186593515-fd35261d-dfab-406c-8634-9c2bebf82e26.png)

여기서는 case문이 쓰였다. case문은 조건에 따라 입력을 달리할 수 있다. 
회원등급에 따라 grade값이 달라진다.

```java
<table class="table_line">
				<tr>
					<th>회원번호</th>
					<th>회원성명</th>
					<th>전화번호</th>
					<th>주소</th>
					<th>가입일자</th>
					<th>고객등급</th>
					<th>거주지역</th>
					
				</tr>
				<%
					while(rs.next()) {
				%>
				<tr class="center">
					<td><%= rs.getString("custno")%></td>
					<td><%= rs.getString("custname") %></td>
					<td><%= rs.getString("phone") %></td>
					<td><%= rs.getString("address") %></td>
					<td><%= rs.getString("joindate") %></td>
					<td><%= rs.getString("grade") %></td>
					<td><%= rs.getString("city") %></td>
					<td>
						
						<input type="button" value="수정" >
						<input type="button" value="삭제" ></td>
				</tr>
				<%
					}
				%>
			</table>	

```
조회한 쿼리문을 표로 나타낸다.

![image](https://user-images.githubusercontent.com/102028778/186604672-bfbdc694-315b-496a-a9f7-387184022fad.png)

첫 행에 각각 제목을 넣어준다.

  ![image](https://user-images.githubusercontent.com/102028778/186605000-67fbe764-c476-4182-94f6-8d2362dccd7c.png)
  
결과는 이러하다.
  
![image](https://user-images.githubusercontent.com/102028778/186605378-72200128-1435-4830-9e9c-72184f9d85b1.png)

ResultSet의 next()함수는 마지막 행이 존재할 때 까지 반복한다.

한마디로 next함수를 while문으로 돌려 마지막 행이 나올 떄 까지 getString으로 가져온 쿼리문 값을 리턴하는 것이다.








