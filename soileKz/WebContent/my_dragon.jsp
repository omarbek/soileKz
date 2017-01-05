<%@page import="entities.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
	
	if(request.getSession().getAttribute("user")!=null){
		Users user=(Users) request.getSession().getAttribute("user");
		int points=(int) request.getAttribute("points");
%>
    <!DOCTYPE html>
<html>
    <head>
	    <title>Training 3</title>
	    <meta charset="utf-8" />
		<link type="text/css" rel="stylesheet" href="css/bootstrap.css" />
		<link type="text/css" rel="stylesheet" href="css/style_main.css" />
		<link type="text/css" rel="stylesheet" href="css/style_training3.css" />
		
    </head>
    <body>
	<div id="top_bar"> <div id="nav_block"> 
		<ul>
		  <li><a href="action?page=lessons">Главная</a></li>
		  <li><a href="action?page=my_profile"><nobr>Мой профиль</nobr></a></li>
		  <li><a href="action?page=my_dragon">Мой дракон</a></li>
		  <li><a href="action?page=logout">Выйти</a></li>
		</ul>
	</div></div>
		<div id="content_container">
	       	<div id="training">
			<h2>Число набранных очков <% out.print(points); %></h2>
				<center><img height ="300px" width = "300px" src="img/dragon.png" /></center>
			</div>
		</div>
    </body>
</html>
<%
}
%>