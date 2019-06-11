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
	<a href="signup.jsp">Sign Up</a>
	<hr>
	
	<form action="UserController" method="post">
	<input type="hidden" name="pageName" value="login">
	
	  <div class="form-group">
	    <label for="exampleInputEmail1">Email address</label>
	    <input type="email" class="form-control" name="userName" id="userNameInput" aria-describedby="emailHelp" placeholder="Enter email">	    
	  </div>
	  <div class="form-group">
	    <label for="exampleInputPassword1">Password</label>
	    <input type="password" class="form-control" name="password" id="passwordInput" placeholder="Password">
	  </div>
	  <!-- div class="form-group form-check">
	    <input type="checkbox" class="form-check-input" id="exampleCheck1">
	    <label class="form-check-label" for="exampleCheck1">Check me out</label>
	  </div-->
	  <button type="submit" class="btn btn-primary">Submit</button>
	</form>
</div><!-- container-fluid -->
</body>
</html>