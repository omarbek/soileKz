<%@page import="entities.Lessons"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="entities.Translations"%>
<%@page import="entities.Words"%>
<%@page import="entities.Users"%>
<%@page import="java.util.List"%>
<%
if(request.getSession().getAttribute("user")!=null){
	Users user=(Users) request.getSession().getAttribute("user");
	if(user.getRemoved()==0&&user.getRole()==1){
	      List<Lessons> lessons=(List<Lessons>)request.getAttribute("lessons");
	      for(Lessons l:lessons){
	      	out.print(l.getName());
	      %>
	      	<a href="action?page=adding_task">Добавить функциональность этому уроку</a>
	        <br>
	      <% 
	      }
	      %>
      	<table>
      		<form action="action" method="post">
      			<tr>
      				<td>Введите номер урока: <input type="text" name="lesson"></td>
      			</tr>
      			<tr>
      				<td><input type="hidden" name="page" value="add_lesson"></td>
      			</tr>
      			<tr>
      				<td><input type="submit" value="Добавить урок"></td>
      			</tr>
      		</form>
      	</table>	
          <%
	}
}
%>