<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collections"%>
<%@page import="javax.swing.event.ListSelectionEvent"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.List"%>
<%@page import="entities.Words"%>
<%@page import="entities.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%
	
	if(request.getSession().getAttribute("user")!=null){
		Users user=(Users) request.getSession().getAttribute("user");
%>
	<!DOCTYPE html>
<html>
    <head>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
	<script type="text/javascript">
	var fruits = [];
	var buttons=[];
	var checkAnswer="";
	function myFunction(id,a) {
	    checkAnswer += a;
	    document.getElementById("demo").innerHTML = checkAnswer;
	    document.getElementById(id).style.visibility="hidden";
	    buttons.push(id);
	    document.getElementById("postData").value = checkAnswer;
	}
	function myClear(){
		checkAnswer="";
	    document.getElementById("demo").innerHTML = "";
	    for (var i = 0; i < buttons.length; i++) { 
	       document.getElementById(buttons[i]).style.visibility = 'visible';
	     }
	}
	</script>
<%!
	public Long randomQuestion(Long lid){
		Random rnd=new Random();
		long a=lid*4-3+(long)(rnd.nextDouble()*(lid*5-(lid*4-3)));
		return a;
	}
	public List<Integer> shuffle(Integer a){
		List<Integer> list=new ArrayList<Integer>();
		for(int i=0;i<a;i++){
			list.add(i);
		}
		Collections.shuffle(list);
		return list;
	}
	%>
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
		  <li><a href="action?page=my_dragon&uid=<% out.print(user.getId()); %>">Мой дракон</a></li>
		  <li><a href="action?page=logout">Выйти</a></li>
		</ul>
	</div></div>
	<div id="content_container">
       	<div id="training">
		<h2>Собери слово из данных букв</h2>
		
				<div id="inputs" align="center">
					<h1><p name="input_letter" id="demo"></p></h1>
				</div>
			<div id="ddown">
				
			<div id="letters" align="center">
				<%
	List<Words> allWords=(List<Words>)request.getAttribute("allWords");
	Long uid=(Long)request.getAttribute("uid");
	String word="";
	Long lid=(Long)request.getAttribute("lid");
	long a=randomQuestion(lid);
	Random randomGenerator = new Random();
	
	for(Words w: allWords){
		if(a==w.getId()){
			List<Integer> list=shuffle(w.getName().length());
			for(Integer i:list){
				char ch=w.getName().charAt(i);
				word+=ch;
			}
		for(int i=0;i<word.length();i++){
			%>	
<button id=<% out.print(i); %> onclick="myFunction(this.id,'<% out.print(word.charAt(i)); %>')">
			<% out.print(word.charAt(i)); %></button>
				<%	
	} 
		%>
			</div>
			
	<button id="sub" onclick="myClear()">Заново</button>
			<form action="action" method="post">
		<input type="hidden" name="demo" id="postData" value="">
		<input type="hidden" name="wid" value="<% out.print(w.getId()); %>">
		<input type="hidden" name="uid" value="<% out.print(uid); %>">
		<input type="hidden" name="lid" value="<% out.print(lid); %>">
		<input type="hidden" name="page" value="usach">
		<input type="submit" id="sub" value="Ответить">
	</form> 
			</div>
		</div>
		
    </div>
	<div id="bottom_bar">
	</div>
    </body>
</html>
<% 
		}
	}
	}
%>