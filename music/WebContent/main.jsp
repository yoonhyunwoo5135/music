<%@page import="java.io.Console"%>
<%@page import="bean.MusicDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.MusicDAO"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>음악을 태우다 낙타</title>
		<link rel="stylesheet" type="text/css" href= "style.css">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
		integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
		crossorigin="anonymous">
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>
	</head>
	<body>
		<%
			String query = request.getParameter("search");
			String url = "https://www.genie.co.kr/search/searchMain?query="+query;
			Document doc = null;
			try {
				doc = Jsoup.connect(url).get();
			} catch (IOException e) {
				e.printStackTrace();
			}
			Elements element = doc.select("span.cover-img");
		
			Elements img = element.select("img");//아티스트 이미지
		%>
		<div id = "top">
			<div id = "title">
				<a href = "main.jsp"><img src="images/Title.png" style="border-radius: 10px 10px 10px 10px"></a>
			</div>
			
			<div id = "search">
				<form action="search.jsp">
					<input type="text" name = "search" id = "searchbox" style = "width: 400px; height: 45px;" placeholder="검색어를 입력해주세요.">
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
		<div id = "menu">
			<table>
				<ul>
					<li class = "menuselect"><a href = "rank.jsp">음원차트</a>
					<li class = "menuselect"><a href = "newmusic.jsp">최신음악</a>
					<li class = "menuselect"><a href = "magazine.jsp">뉴스토픽</a>
					<li class = "menuselect"><a href = "">공지사항</a>
					<li class = "menuselect"><a href = "">통계</a>
				</ul>
			</table>
		</div>
		<hr class = "hr">
		<div id = "middle">
			<div id = "album">
				<h5 style="font-weight: bold">최신음악</h5>
				<table>
					<tbody>
						<%
							//메인의 앨범사진 1~4 / 4~8번 url 을 끌어옴
							MusicDAO dao = new MusicDAO();
							ArrayList<String> cover = dao.mainImage();
						%>
						<tr>
							<%
								for (int i = 0; i < 4; i++) {
									String x = cover.get(i);
							%>
							<td><a href="newmusic.jsp"><img alt="이미지 없음" src=<%=x%> width=173px,
									height=173px id="mainimage"></a></td>
							<%
								}
							%>
	
						</tr>
						<tr>
							<%
								for (int i = 4; i < 8; i++) {
									String x = cover.get(i);
							%>
							<td><a href="newmusic.jsp"><img alt="이미지 없음" src=<%=x%> width=173px,
									height=173px id="mainimage"></a></td>
							<%
								}
							%>
	
						</tr>
					</tbody>
				</table>
			</div>
			<div id = "hotsearch">
			<h5 class = "hot" style="font-weight: bold">인기 검색어</h5>
				<br>
				<ol>
					<% 
						String rank = null;
						element = doc.select("div.aside_realtime");//인기 검색어
						
						for(Element el : element.select("li > a")){
							rank = el.text();
							
					%>
						<li><a href="search.jsp?search=<%= rank %>"><%= rank %></a></li>
					<% 
						}
					%>
				</ol>
			</div>
		</div>
		
		<div id="bottom">
			<div id = "chart">
				<h6>실시간 차트</h6>
					<table>
						<tbody>
							<hr>
							<%
								dao.drop(); /* DB에 있는 자료 모두 버리고 순번 초기화 */
								dao.top50(); /* top50개 음원 제목, 가수명 DB입력 */
								String[] cover1 = dao.image(); /* 앨범사진 URL을 배열로 만듦 */
								ArrayList listAll = new ArrayList();
								listAll = dao.selectAll();
								for (int i = 0; i < 10; i++) {
									MusicDTO dto1 = (MusicDTO) listAll.get(i);
									String album = cover1[i];
							%>
							<tr id="list">
								<td class = "list" align="center" width=40;><%=dto1.getNum() + "위"%></td>
								<td class = "list" align="left"><a class = "list" href="search.jsp?search=<%=dto1.getTitle()%>"><%=dto1.getTitle()%></a></td>
								<td class = "list" align="left"><a class = "list" href="search.jsp?search=<%=dto1.getArtist()%>"><%=dto1.getArtist()%></a></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</div>		
			<div id = "container">
				<div id = "notice">
					<h6>공지사항</h6>
					<hr>
					<ul>
						<li><a href="">낙타 version 2.5 업데이트</a></li>
						<li><a href="">낙타 version 2.2 업데이트</a></li>
						<li><a href="">낙타 version 2.0 업데이트</a></li>
						<li><a href="">낙타 version 1.71 업데이트</a></li>
					</ul>
				</div>
				<br>
				<div id = "news">
					<h6>뉴스토픽</h6>
					<hr>
					<table style="width: 450px; height: 220px;">
						<%
							String url2 = "https://www.genie.co.kr/magazine?ctid=1";
							Document doc2 = null;
							String title = null;
							ArrayList list2 = new ArrayList();
							int cnt=0;
							try {
								doc2 = Jsoup.connect(url2).get();
							} catch (IOException e) {
								e.printStackTrace();
							}
							Elements element2 = doc2.select("div.list-normal");
							for(Element p : element2.select("div.info > p")){ //타이틀
								list2.add(p.text());
							}
							for(Element img2 : element2.select("div.cover > img")){//뉴스 이미지
								title = (String)list2.get(cnt);
								cnt++;
						%>
						<tr>
				 			<td style="font-size: 14px;"><a href = "magazine.jsp"><%= title %></a></td>
				 		</tr>
					 	<%
					 		}
					 	%>
			 		</table>
				</div>
			</div>
		</div>
		<div id = "under" style="margin-top: 900px;
		position: absolute; left: 475px; width: 900px; height: 200px; font-size: 12px;">
				회사소개 | 이용약관 | 개인정보처리방침 | 청소년보호정책 | 이메일주소무단수집거부 | 서비스 이용문의
			<div id = "under2">
			</div>
		</div>
	</body>
</html>