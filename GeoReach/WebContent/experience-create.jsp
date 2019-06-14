<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.onwardpath.georeach.repository.SegmentRepository" %>
    <%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script type="text/javascript">
function submitform()
{
  document.logout.submit();
}
function addOption(){
	alert("1");
	var segment = document.getElementById("segment").value;
	var url = document.getElementById("url").value;
		
	var select = document.getElementById("dynamic-select");
	
	select.options[select.options.length] = new Option(segment, url);
	document.getElementById("url").value = "";
	
	alert("2");
	var x = document.getElementById("geobucket");	
	x.style.display = "block";
	alert("3");
}
function removeOption(){
	var select = document.getElementById("dynamic-select");
	select.options[select.options.length - 1] = null;
	if (select.options.length == 0) {
		var x = document.getElementById("geobucket");
		x.style.display = "none";		
	}	
}
function removeAllOptions(){
	var select = document.getElementById("dynamic-select");
	select.options.length = 0;
	var x = document.getElementById("geobucket");
	x.style.display = "none";	
}
function saveExperience() {	
	document.getElementById("experience-form").method = "post";
	document.getElementById("experience-form").action = "ExperienceController";
	document.getElementById("experience-form").submit();
}
</script>

<title>GeoReach</title>
</head>
<body>

<div class="container-fluid">
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
	<li>
		<a href="experience-view.jsp">Experiences</a>
		<ul>
			<li>New</li>
		</ul>
	</li>
	</ul>
	
	<h1>Experiences</h1>		
		
	<h2>Create New</h2>
		
	<form id = "experience-form">
	<input type="hidden" name="pageName" value="create-experience">
	<table>	
	<tr><td>Name</td><td><input type="text" id="name" name="name"></td></tr>
	<tr><td>Type</td><td><select name="type" id="type"><option value="image">Image</option><option value="content">Content</option></select></td></tr>		
	<tr><td>Segment</td><td><select name="segment" id="segment">	
	<%
	SegmentRepository segmentRepository = new SegmentRepository();
	int org_id = (Integer)session.getAttribute("org_id");
	Map<Integer,String> segments = segmentRepository.getOrgSegments(org_id);
	for ( Map.Entry<Integer, String> entry : segments.entrySet()) {
		Integer key = entry.getKey();
	    String val = entry.getValue();	     	   
	    out.println("<option value="+key+">"+val+"</option>");
	}	
	%>
	</select>		
	</td></tr>
	<tr><td>URL</td><td><input type="text" id="url" name="url"></td></tr>		
	<tr><td colspan="2" align="right"><button class="btn btn-outline-secondary btn-sm" onclick="addOption()">Add</button></td></tr>
	
	<tr><td colspan="2">
		<div id="geobucket" style="display: none;">
			<select id="dynamic-select" size="2"></select>
			<button class="btn btn-outline-secondary btn-sm" onclick="removeOption()">Remove</button>&nbsp;
			<button class="btn btn-outline-secondary btn-sm" onclick="removeAllOptions()">Remove All</button>		
		</div>
	</td>
	
	<tr><td>Schedule Start</td><td><input type="text" name="schedule_start"></td></tr>
	<tr><td>Schedule End</td><td><input type="text" name="schedule_end"></td></tr>	
	<tr><td>Status</td><td><input type="text" name="status"></td></tr>		
	</table>
					
	<input type="button" value="Save" onclick="saveExperience();">
	</form>
		
	<!-- Message Display Area -->
	<div id="messages">
		<p style="color:red;">
			<%
			String message = (String) session.getAttribute("message");
			if (message != null) {
				out.print(message);
				session.setAttribute("message", "");
			}																
			%>	
		</p>
	</div>
</div><!-- container-fluid -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>