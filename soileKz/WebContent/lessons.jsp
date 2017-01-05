<%@page import="entities.Lessons"%>
<%@page import="entities.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.Format"%>
<%@page import="entities.Words"%>
<%@page import="java.util.List"%>
<%

if(request.getSession().getAttribute("user")!=null){
	Users user=(Users) request.getSession().getAttribute("user");
%>
<!DOCTYPE html>
<html>
    <head>
	    <title>Lessons</title>
	    <meta charset="utf-8" />
		<link type="text/css" rel="stylesheet" href="css/bootstrap.css" />
		<link type="text/css" rel="stylesheet" href="css/style_main.css" />
		<link type="text/css" rel="stylesheet" href="css/style_training.css" />
		
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
		<div id="list_of_trainings">
		<%
	if(user.getRemoved()==0){
      		List<Words> allWords=(List<Words>)request.getAttribute("allWords");
      		List<Lessons> allLessons=(List<Lessons>)request.getAttribute("allLessons");
      		for(Lessons l:allLessons){%>
				<h3><%out.print(l.getName()+"<br>"); %></h3><%
      			for(Words w:allWords){
      				if(l.getId()==w.getLid()){ 
      					out.print(w.getName()+";"); 
      				}
      			}
      			%>
				<h2><a href="action?page=profile&lid=<% out.print(l.getId()); %>&uid=<%out.print(user.getId());%>">Начать</a></h2>
				<%
      			out.print("<br>");
      		}
	}
}
%>
		</div>
    </div>
	<div id="bottom_bar">
	</div>
    </body>
</html>
