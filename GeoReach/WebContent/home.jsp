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
<li>Home</li>
<li><a href="segments.jsp">Segments</a></li>
<li><a href="experience.jsp">Experiences</a></li>
</ul>

<!-- Body Content -->
<h1>Home</h1>
<p>Start by crating segments (of your visitors). Then you can create unique experiences for each of your segments.</p>

<a href="segments.jsp">Create Segment</a>
</body>
</html>