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
//https://developer.mozilla.org/en-US/docs/Web/API/Element/insertAdjacentHTML
function addRow () 
{
	var el = document.getElementById('segment');	
	var segment_id = el.value;
	var segment_name = el.options[el.selectedIndex].innerHTML;	
	var url = document.getElementById("url").value;		
  	document.querySelector('#content').insertAdjacentHTML(
    	'afterbegin',
    	`<div class="row">\	    
    		<div class="card-body">\
				<h5 class="card-title">`+segment_name+`</h5>\					    	
				<img src="`+url+`" alt="wild card" class="rounded">\
				<input type="button" value="-" onclick="removeRow(this)">\
			</div>\						
    	</div>`        
  )  	  		
}
function removeRow (input) 
{
  input.parentNode.remove()
}
function saveExperience() 
{	
	var name = document.getElementById('name').value;
	var type = document.getElementById('type').value;
	var el = document.getElementById('segment');	
	var segment_id = el.value;
	//var segment_name = el.options[el.selectedIndex].innerHTML;		
	var url = document.getElementById("url").value;	
	//alert("name: "+name);
	//alert("type: "+type);
	//alert("segment_id: "+segment_id);
	//alert("segment_name: "+segment_name);
	//alert("url: "+url);
	
	document.getElementById("experience-form").name.value=name;
	document.getElementById("experience-form").type.value=type;
	document.getElementById("experience-form").segment_id.value=segment_id;
	document.getElementById("experience-form").url.value=url;	
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
		
	
	
	<table>	
	<tr><td>Name</td><td><input type="text" id="name"></td></tr>
	<tr><td>Type</td><td><select id="type"><option value="image">Image</option><option value="content">Content</option></select></td></tr>		
	<tr><td>Segment</td><td><select id="segment">	
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
	<tr><td>URL</td><td><input type="text" id="url""></td></tr>		
	<tr><td colspan="2" align="right"><button class="btn btn-outline-secondary btn-sm" onclick="addRow();">Add</button></td></tr>	
	<tr><td colspan="2">
	<div id="content"></div>
	</td>	
	<tr><td>Schedule Start</td><td><input type="text"></td></tr>
	<tr><td>Schedule End</td><td><input type="text"></td></tr>	
	<tr><td>Status</td><td><input type="text"></td></tr>		
	</table>
					
	<input type="button" value="Save" onclick="saveExperience();">
	
	<form id = "experience-form">
	<input type="hidden" name="pageName" value="create-experience">
	<input type="hidden" name="name">
	<input type="hidden" name="type">
	<input type="hidden" name="segment_id">
	<input type="hidden" name="url">
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