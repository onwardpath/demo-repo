<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1>Hello World</h1>

<form action="UserController" method="post">
<input type="hidden" name="pageName" value="login">
<input type="text" name="userName" id="userNameInput" placeholder="User Name" /><br>
<input type="password" name="password" id="passwordInput" placeholder="Password" /><br>
<input type="submit" value="Login">
</form>
</body>
</html>