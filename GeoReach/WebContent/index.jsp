<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>GeoReach</title>
</head>
<body>
<a href="signup.jsp">Sign Up</a>
<hr>

<form action="UserController" method="post">
<input type="hidden" name="pageName" value="login">
Login ID: <input type="text" name="userName" id="userNameInput" placeholder="User Name" /><br>
Password: <input type="password" name="password" id="passwordInput" placeholder="Password" /><br>
<input type="submit" value="Login">
</form>

</body>
</html>