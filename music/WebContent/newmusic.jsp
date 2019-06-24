<%@page import="bean.MusicDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.MusicDAO"%>
<%@page import="bean.Mp3DTO"%>
<%@page import="bean.Mp3DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>음악을 태우다 낙타</title>
		<link rel="stylesheet" type="text/css" href= "stylenew.css">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
		integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
		crossorigin="anonymous">
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>
	</head>
	<body>
		<div id = "top">
			<div id = "title">
				<a href="main.jsp"><img src="images/Title.png" style="border-radius: 10px 10px 10px 10px"></a>
			</div>
			
			<div id = "search">
				<form action="">
					<input type="text" id = "searchbox" style = "width: 400px; height: 45px;" placeholder="검색어를 입력해주세요.">
					<button type="submit" class="btn btn-primary btn-lg">검색</button>
				</form>
			</div>
			
			<div id = "login">
				<table>
					<tr>
						<td>
							<img src = "images/Camel.png">
						</td>
						<td>
							<form action="">
								<button type="submit" id = "loginbutton" class="btn btn-info">로그인</button>
							</form>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div id = "menu">
			<table>
				<ul>
					<li class = "menuselect"><a href = "rank.jsp">음원차트</a>
					<li class = "menuselect"><a href = "newmusic.jsp">최신음악</a>
					<li class = "menuselect"><a href = "">뉴스토픽</a>
					<li class = "menuselect"><a href = "">에디터추천</a>
					<li class = "menuselect"><a href = "">공지사항</a>
				</ul>
			</table>
		</div>
		<hr class = "hr">
		<h2 style="padding-left: 475px;">최신음악</h2>
		<div id = "middle">
			<div class = "newmusicchart1" style="width: 450; float: left">
				<table border="5">
					<tr>

						<td align="center">IMAGE</td>
						<td align="center">RANK</td>
						<td align="center">TITLE</td>

					</tr>
						<%
							MusicDAO dao = new MusicDAO();
							dao.drop2(); /* DB에 있는 자료 모두 버리고 순번 초기화 */
							dao.newmusic(); /* top50개 음원 제목, 가수명 DB입력 */
							String[] cover = dao.newimage(); /* 앨범사진 URL을 배열로 만듦 */
							ArrayList listAllNew = new ArrayList();
							listAllNew = dao.selectAllNew();
							for (int i = 0; i < 10; i++) {
								MusicDTO dto = (MusicDTO) listAllNew.get(i);
								String album = cover[i];
						%>
					<tr>
						<td width="100px" height="100px;" align="center"><img alt="이미지 없음" src=<%=album%>></td>
						<td width="50px" height="100px;" align="center"><%=dto.getNum() + "위"%></td>
						<td width="250px" height="100px;" align="center"><%=dto.getTitle()%> <br> <%=dto.getArtist()%>
						<br>
						<br>
							<button type="button" name="num1"
								class="btn btn-sm btn-block blue"
								onclick="javascript:location.href='player.jsp?mnum=<%=i%>'">재생</button></td>
					</tr>
						<%
							}
						%>
				</table>
			</div>
			<div class = "newmusicchart2" style="width: 450; float: left">
				<table border="5">
					<tr>

						<td align="center">IMAGE</td>
						<td align="center">NUM</td>
						<td align="center">TITLE</td>

					</tr>
						<%
							MusicDAO dao2 = new MusicDAO();
							dao.drop2(); /* DB에 있는 자료 모두 버리고 순번 초기화 */
							dao.newmusic(); /* top50개 음원 제목, 가수명 DB입력 */
							String[] cover2 = dao.newimage(); /* 앨범사진 URL을 배열로 만듦 */
							ArrayList listAllNew2 = new ArrayList();
							listAllNew2 = dao.selectAllNew();
							for (int i = 10; i < 20; i++) {
								MusicDTO dto2 = (MusicDTO) listAllNew2.get(i);
								String album = cover2[i];
						%>
					<tr>
						<td width="100px" height="100px;" align="center"><img alt="이미지 없음" src=<%=album%>></td>
						<td width="50px" height="100px;" align="center"><%=dto2.getNum()%></td>
						<td width="250px" height="100px;" align="center"><%=dto2.getTitle()%> <br> <%=dto2.getArtist()%>
						<br>
						<br>
							<button type="button" name="num1"
								class="btn btn-sm btn-block blue"
								onclick="javascript:location.href='player.jsp?mnum=<%=i%>'">재생</button></td>
					</tr>
						<%
							}
						%>
				</table>
			</div>
		</div>
		<div id = "under" style="margin-top: 1500px; position: absolute; float: left;">
				회사소개 | 이용약관 | 개인정보처리방침 | 청소년보호정책 | 이메일주소무단수집거부 | 서비스 이용문의
			<div id = "under2">
			</div>
		</div>
	</body>
</html>