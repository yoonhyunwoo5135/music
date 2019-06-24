<%@page import="bean.MusicDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.MusicDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF8"
	pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>음악을 태우다 낙타</title>

	<link rel="stylesheet" type="text/css" href="stylerank.css">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
		integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>

</head>

<body>
	<html id="top">
		<div id="top">
			<div id="title">
				<a href="main.jsp"><img src="images/Title.png" style="border-radius: 10px 10px 10px 10px"></a>
			</div>

			<div id="search">
				<form action="">
					<input type="text" id="searchbox" style="width: 400px; height: 45px;" placeholder="검색어를 입력해주세요.">
					<button type="submit" class="btn btn-primary btn-lg">검색</button>
				</form>
			</div>

			<div id = "login">
	            <table>
	               <tr>
	                  <td>
	                     <img src = "images/Camel.png">
	                  </td>
	                  <td width="150px">
	                     <%
	                        Object userId = session.getAttribute("InputId");
	                        if(userId != null){
	                     %>
	                     <b><%=session.getAttribute("InputId") %></b>님<br>안녕하세요 :)
	                     
	                     <form action="logout.jsp">
	                        <button type="submit" id="logout" class="btn btn-dark">로그아웃</button>
	                     </form>
	                     
	                     <%}else{%>
	                     <form action="login.jsp">
	                        <button type="submit" id = "loginbutton" class="btn btn-info">로그인</button>
	                     </form>
	                     <%} %>
	                  </td>
	               </tr>
	            </table>
        	</div>
		</div>
		<div id="menu">
			<table>
				<ul>
					<li class="menuselect"><a href="rank.jsp">음원차트</a>
					<li class="menuselect"><a href="newmusic.jsp">최신음악</a>
					<li class="menuselect"><a href="magazine.jsp">뉴스토픽</a>
					<li class="menuselect"><a href="">공지사항</a>
					<li class="menuselect"><a href="">통계</a>
				</ul>
			</table>
		</div>
		<hr class="hr">
		<!-- Example single danger button -->
		<div>
			<!-- 세션(음악번호: numList / 제목: titleList -->
			<h2 style="padding-left: 475px;">TOP50</h2>
			최근 재생한 음악 :
			<%
				ArrayList<Integer> numList = (ArrayList<Integer>) session.getAttribute("mnum");
				ArrayList<String> titleList = (ArrayList<String>) session.getAttribute("title");
				if (numList == null) {
				} else if (numList.size() == 1) { //세션에 저장된 내용이 한 개 이하일 때
			%><br>
			<table>
				<tbody>

					<td><a href="">현재 <%=numList.get(0) + 1%>위
						</a> <a href=""><%=titleList.get(0)%></a></td>

					<%
						} else { // 두 개 이상일 때
							for (int i = 1; i < numList.size(); i++) {
					%>
					<br>
					<td><a
							href="player.jsp?mnum=<%=numList.get(numList.size() - i)%>"><%=titleList.get(titleList.size() - i)%></a>
					</td>
					<%
						}
						}
					%>
				</tbody>
			</table>
		</div>
		<!---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
		<div id="middle">
			<!-- TOP 50 차트 -->
			<div class = "newmusicchart1" style="width: 450; float: left">
				<table border="5">
						<tr>

							<td align="center">IMAGE</td>
							<td align="center">RANK</td>
							<td align="center" width=50 style="word-break:break-all">TITLE</td>

						</tr>
						<%
							MusicDAO dao = new MusicDAO();
							dao.drop(); /* DB에 있는 자료 모두 버리고 순번 초기화 */
							dao.top50(); /* top50개 음원 제목, 가수명 DB입력 */
							String[] cover = dao.image(); /* 앨범사진 URL을 배열로 만듦 */
							ArrayList listAll = new ArrayList();
							listAll = dao.selectAll();
							for (int i = 40; i < 50; i++) {
								MusicDTO dto = (MusicDTO) listAll.get(i);
								String album = cover[i];
						%>
						<tr>

							<td width="100px" height="100px;" align="center"><img alt="이미지 없음" src=<%=album%>></td>
							<td width="50px" height="100px;" align="center"><%=dto.getNum() + "위"%></td>
							<td width="250px" height="100px;" align="center"><a href="search.jsp?search=<%=dto.getTitle()%>" style="word-break:break-all"><%=dto.getTitle()%></a>
								<br> <a href="search.jsp?search=<%=dto.getArtist()%>" style="word-break:break-all"><%=dto.getArtist()%></a><br> <br>
								
								<a href="player.jsp?mnum=<%=i%>&title=<%=dto.getTitle()%>&artist=<%=dto.getArtist()%>" target="_blank" class="btn btn-primary">PLAY▶</a><!-- 새 창으로 띄움 -->
								</td>
						</tr>
						<%
							}
						%>
				</table>

			</div>
			<!---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
		</div>
		<div style="margin-top: 1500px; position: absolute; left: 900px; float: left; text-decoration: none; font: 20px bold;">
			<a style = "font: black" href = "rank.jsp">1</a>
			<a style = "font: black" href = "rank2.jsp">2</a>
			<a style = "font: black" href = "rank3.jsp">3</a>
		</div>
		<div id="under" style="margin-top: 1600px; position: absolute; left: 475px; float: left;">
			회사소개 | 이용약관 | 개인정보처리방침 | 청소년보호정책 | 이메일주소무단수집거부 | 서비스 이용문의
				<div id="under2">
				</div>
			</div>
</body>

</html>