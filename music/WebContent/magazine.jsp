<%@page import="java.util.ArrayList"%>
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
		
		<div id = "top">
			<div id = "title">
				<a href="main.jsp"><img src="images/Title.png" style="border-radius: 10px 10px 10px 10px"></a>
			</div>
			
			<div id = "search">
				<form action="지니.jsp">
					<input type="text" id = "searchbox" style = "width: 400px; height: 45px;" placeholder="검색어를 입력해주세요." name="search">
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
				<div id="current">
					<ul>
						<li><a href="search.jsp">통합검색</a></li>
						<li>곡</li>
						<li>앨범</li>
						<li>동영상</li>
						<li><a href="#">매거진</a></li>
					</ul>
				</div>
		<hr class="hr" color="blue">
		
				<table border="2" style="width: 900px; height: 500px;">
				<%
					String url = "https://www.genie.co.kr/magazine?ctid=1";
					Document doc = null;
					String title=null;
					ArrayList list = new ArrayList();
					int cnt=0;
					try {
						doc = Jsoup.connect(url).get();
					} catch (IOException e) {
						e.printStackTrace();
					}
					Elements element = doc.select("div.list-normal");
					for(Element p : element.select("div.info > p")){ //타이틀
						list.add(p.text());
					}
					for(Element img : element.select("div.cover > img")){//뉴스 이미지
						title = (String)list.get(cnt);
						cnt++;
				%>
			 		<tr>
			 			<td><%= img %></td>
			 			<td><%= title %></td>
			 		</tr>
				<%
						
					}
				%>
					
				</table>
				
			</div>
			
		</div>
		
		<div id="bottom">
			
		</div>
		<div id = "under"  style="margin-bottom: 0px;">
			회사소개 | 이용약관 | 개인정보처리방침 | 청소년보호정책 | 이메일주소무단수집거부 | 서비스 이용문의
		<div id = "under2">
		</div> 
	</body>
</html>