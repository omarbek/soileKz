<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.Format"%>
<%@page import="entities.Words"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
    <head>
	    <title>login</title>
	    <meta charset="utf-8" />
		<link type="text/css" rel="stylesheet" href="css/bootstrap.css" />
		<link type="text/css" rel="stylesheet" href="css/style_main.css" />
		<link type="text/css" rel="stylesheet" href="css/style_login.css" />
    </head>
    <body>
	<div id="content_container">
       	<div id="training">
		<center><label id="vhod">Форма входа</label></center>
			<form action="action" method="post">
				<label id="form_label">Логин: </label> <input type="text" name="login" placeholder="Your Login"><br>
				<label id="form_label">Пароль: </label> <input type="password" name="password" placeholder="Your Password"><br>
				<input type="hidden" name="page" value="check">
				<input type="submit" name="submit" value="Войти" id="submt">
			</form>
			<center><table id="hr2">
			</table></center>
		</div>
    </div>

    </body>
</html>