<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.Format"%>
<%@page import="java.util.List"%>

<form action="action" method="post">
	<table>
		<tr>
			<td>Login:</td>
			<td><input type="text" name="login" placeholder="Your Login"></td>
		</tr>
		<tr>
			<td>Password:</td>
			<td><input type="password" name="password" placeholder="Your Password"></td>
		</tr>
		<tr>
			<td>Name:</td>
			<td><input type="text" name="name" placeholder="Your Name"></td>
		</tr>
		<tr>
			<td>Surname:</td>
			<td><input type="text" name="surname" placeholder="Your Surname"></td>
		</tr>
		<tr>
			<td><input type="hidden" name="page" value="register"></td>
			<td><input type="submit" value="Sign up"></td>
		</tr>
		<a href="action?page=index">Back</a>
	</table>
</form>
