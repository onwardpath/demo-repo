<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<title>GeoReach</title>
</head>
<body>
<div class="container">
	<a href="index.jsp">Back</a>
	<hr>	
	<form action="UserController" method="post" class="needs-validation" novalidate >
	<input type="hidden" name="pageName" value="signup">
	<input type="hidden" name="role" value="1">
	<!-- ORGANIZATION DETAILS -->
	<div class="form-group">
	    <label for="companyName">Company Name</label>
	    <input type="text" class="form-control" name="orgName" id="orgNameInput" aria-describedby="emailHelp" placeholder="Enter Company Name">	    
	</div>
	<div class="form-group">
	    <label for="companyName">Domain</label>
	    <input type="text" class="form-control" name="domain" id="domainInput" aria-describedby="emailHelp" placeholder="Enter Domain">	    
	</div>
	<div class="form-group">
	    <label for="companyName">Logo</label>
	    <input type="text" class="form-control" name="logoUrl" id="logoInput" aria-describedby="emailHelp" placeholder="Logo URL">	    
	</div>	
	<!-- USER DETAILS -->
	<div class="form-group">
	    <label for="firstName">First Name</label>
	    <input type="text" class="form-control" name="firstName" id="firstnameInput" aria-describedby="emailHelp" placeholder="First Name">	    
	</div>
	
	<div class="form-group">
	    <label for="lastName">Last Name</label>
	    <input type="text" class="form-control" name="lastName" id="lastnameInput" aria-describedby="emailHelp" placeholder="Last Name">	    
	</div>
	
	<div class="form-group">
	    <label for="phone">Phone</label>
	    <input type="text" class="form-control" name="phone" id="phoneInput" aria-describedby="emailHelp" placeholder="Phone">	    
	</div>
	
	<div class="form-group">
	    <label for="email">Email</label>
	    <input type="text" class="form-control" name="email" id="emailInput" aria-describedby="emailHelp" placeholder="Email ID">	    
	</div>
		
	<div class="form-group">
	    <label for="password">Password</label>
	    <input type="password" class="form-control" name="password" id="passwordInput" placeholder="Password">
	</div>
	  
	<button type="submit" class="btn btn-primary">Submit</button>	   
	</form>
</div><!-- container-fluid -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>