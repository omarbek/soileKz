<%@page import="entities.FourImages"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="javax.swing.ButtonGroup"%>
<%@page import="entities.Translations"%>
<%@page import="entities.Words"%>
<%@page import="entities.Users"%>
<%@page import="java.util.List"%>
 <%
	
	if(request.getSession().getAttribute("user")!=null){
		Users user=(Users) request.getSession().getAttribute("user");
%>
<!DOCTYPE html>
<html>
    <head>
	    <title>Training 4</title>
	    <meta charset="utf-8" />
		<link type="text/css" rel="stylesheet" href="css/bootstrap.css" />
		<link type="text/css" rel="stylesheet" href="css/style_main.css" />
		<link type="text/css" rel="stylesheet" href="css/style_training4.css" />
		
    </head>
    <body>
	<div id="top_bar"> <div id="nav_block"> 
		<ul>
		  <li><a href="action?page=lessons">Главная</a></li>
		  <li><a href="action?page=my_profile"><nobr>Мой профиль</nobr></a></li>
		  <li><a href="action?page=my_dragon&uid=<% out.print(user.getId()); %>">Мой дракон</a></li>
		  <li><a href="action?page=logout">Выйти</a></li>
		</ul>
	</div></div>
	<div id="content_container">
       	<div id="training">
		<h2>Угадай слово по картинкам</h2>
			<div id="uup">
				<center><table>
				<%
	List<FourImages> list=(List<FourImages>)request.getAttribute("images");
	Long wid=null;
	Long uid=(Long)request.getAttribute("uid");
	Long lid=(Long)request.getAttribute("lid");
	for(int i=0;i<list.size();i++){
		wid=list.get(i).getWid();
		if(i%2==0){
%>
			<tr>
	<%
		}
		%>
<td><img height ="300px" width = "300px" src="<% out.print(list.get(i).getUrl()); %>" /></td>
	<%
	if(i%2==1){
%>
		</tr>
		<%
	}
	}
	 %>
				</table></center>
			</div>
			<div id="ddown">
			<form action="action" method="post">
	<input type="text" id="slovo" name="four">
	<input type="hidden" name="uid" value="<% out.print(uid); %>">
	<input type="hidden" name="wid" value="<% out.print(wid); %>">
	<input type="hidden" name="lid" value="<% out.print(lid); %>">
	<input type="hidden" name="page" value="four">
	<input type="submit" id="sub" value="Ответить">
</form>
			</div>
		</div>
    </div>
	<div id="bottom_bar">
	</div>
    </body>
</html>
<%}%>