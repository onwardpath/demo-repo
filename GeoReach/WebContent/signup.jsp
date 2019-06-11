<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet" id="bootstrap-css">
<title>GeoReach</title>
</head>
<body>
<div class="container-fluid">
	<a href="index.jsp">Back</a>
	<hr>
	
	<form action="UserController" method="post">
	<input type="hidden" name="pageName" value="signup">
	First Name: <input type="text" name="firstName" id="firstNameInput" placeholder="First Name" /><br>
	Last Name: <input type="text" name="lastName" id="lastNameInput" placeholder="Last Name" /><br>
	Email: <input type="text" name="emailAddress" id="emailAddressInput" placeholder="Email Address" /><br>
	Password: <input type="password" name="password" id="passwordInput" placeholder="Password" /><br>
	<button class="btn btn-default">Cancel</button>
	<button class="btn btn-primary" data-toggle="modal" data-target="#themodal">Submit</button>
	</form>
</div><!-- container-fluid -->
</body>
</html>