<!DOCTYPE html>
<html>
    <head>
<%@page import="java.util.Random"%>
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
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
	<script type="text/javascript">
	function check()
	{
	    var inp = document.getElementsByName('variant');
	    for (var i = 0; i < inp.length; i++) {
	        if (inp[i].type == "radio" && inp[i].checked) {
				document.getElementById("myField").value = inp[i].value;
	        }
	    }
	}
	</script>
	<%!
	public Long randomQuestion(Long lid){
		Random rnd=new Random();
		long a=(lid*4-3)+(long)(rnd.nextDouble()*(lid*5-(lid*4-3)));
		return a;
	}
	%>
	    <title>Training 1</title>
	    <meta charset="utf-8" />
		<link type="text/css" rel="stylesheet" href="css/bootstrap.css" />
		<link type="text/css" rel="stylesheet" href="css/style_main.css" />
		<link type="text/css" rel="stylesheet" href="css/style_training1.css" />
		
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
	<% 
		List<Words> all=(List<Words>)request.getAttribute("allWords"); 
		List<Translations> allTrans=(List<Translations>)request.getAttribute("allTrans"); 
		Long lid=(Long)request.getAttribute("lid"); 
		Long uid=(Long)request.getAttribute("uid"); 
		long a=randomQuestion(lid); 
		for(Words w:all){ 
			if(a==w.getId()){ 
	%>
	<div id="content_container">
       	<div id="training">
		<h2>Найди правильный перевод слова</h2>
			<div id="lleft">
				<div id="slovo"><% out.print(w.getName()); %></div>
				<img src="<% out.print(w.getUrl()); %>" height ="300px" width = "300px">
			</div>
			<div id="rright">
				<div class="radio-toolbar"> 
					<% 
					for(int i=0;i<allTrans.size();i++){ 
					%> 
					<input type="radio" onclick="check()" name="variant" id="<% out.print("v"+(i+1)); %>" value="<% out.print(allTrans.get(i).getName()); %>"><label for="<% out.print("v"+(i+1)); %>"><% out.print(allTrans.get(i).getName()); %></label><br> 
					<% 
					} 
					%>
				</div>
					<form action="action" method="post"> 
						<input type="hidden" name="lid" value="<% out.print(w.getLid()); %>"> 
						<input type="hidden" name="wid" value="<% out.print(w.getId()); %>"> 
						<input type="hidden" name="uid" value="<% out.print(uid); %>"> 
						<input type="hidden" name="page" value="answer"> 
						<input type="hidden" name="myField" id="myField"/> 
						<input type="submit" id="sub" value="Отправить"></input> 
					</form>
			</div>
		</div>
		
    </div>
	<div id="bottom_bar">
	</div>
    </body>
</html>
<%
		return;
			}
		}
	}
%>