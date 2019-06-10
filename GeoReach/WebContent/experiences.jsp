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
<li><a href="settings.jsp">Settings</a></li>
<li><a href="javascript:submitform()">Logout</a></li>
</ul>
<hr>
<!-- Side Menu -->
<ul>
<li><a href="home.jsp">Home</a></li>
<li><a href="segments.jsp">Segments</a></li>
<li>Experiences</li>
</ul>

<!-- Body Content -->
<h1>Experiences</h1>
<p>You can build unique experiences to your segments here.</p>
<h2>Steps:</h2>
<ol>
<li>Select the segments for which you wish to create unique experience</li>
<li>Create and save the experience</li>
</ol>
<hr>


</body>
</html>