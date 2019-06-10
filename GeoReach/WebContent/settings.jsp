<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<script type="text/javascript">
function submitform()
{
  document.logout.submit();
}
</script>

<title>GeoReach</title>
</head>
<body>

<form name="logout" action="UserController" method="post">
<input type="hidden" name="pageName" value="logout">
</form>

<!-- Top Menu -->
<ul>
<li>Settings</li>
<li><a href="javascript:submitform()">Logout</a></li>
</ul>
<hr>
<!-- Side Menu -->
<ul>
<li><a href="home.jsp">Home</a></li>
<li><a href="segments.jsp">Segments</a></li>
<li><a href="experiences.jsp">Experiences<a></li>
</ul>

<!-- Body Content -->
<h1>Settings</h1>

</body>
</html>