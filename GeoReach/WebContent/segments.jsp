<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<!-- bootstrap cdn -->
<!-- link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" -->
<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet" id="bootstrap-css">
<script type="text/javascript">
function submitform()
{
  document.logout.submit();
}

function addOption(){
	var geotype = document.getElementById("geotype").value;
	var rule = document.getElementById("rule").value;
	var geolocation = document.getElementById("geolocation").value;	
	var geocondition = rule+":"+geotype+":"+geolocation;
		
	var select = document.getElementById("dynamic-select");
	select.options[select.options.length] = new Option(geocondition, geocondition);
	document.getElementById("geolocation").value = "";
	
	var x = document.getElementById("geobucket");	
	x.style.display = "block";	
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

function  saveSegment() {		
	document.getElementById("segment-form").method = "post";
	document.getElementById("segment-form").action = "SegmentController";
	document.getElementById("segment-form").submit();
}

</script>
<title>GeoReach</title>
</head>
<body>

<div class="container-fluid">	
      	<!-- Side Menu -->
      	<form name="logout" action="UserController" method="post">
		<input type="hidden" name="pageName" value="logout">
	   	</form>
			
		<ul>
			<li><a href="settings.jsp">Settings</a></li>
			<li><a href="javascript:submitform()">Logout</a></li>
		</ul>
		<hr>
		
		<ul>
			<li><a href="home.jsp">Home</a></li>
			<li>Segments</li>
			<li><a href="experiences.jsp">Experiences</a></li>
		</ul>
	
		<!-- Content -->
		<h1>Segments</h1>
		<p>Creating Segments is the first step to delivering unique experiences to your visitors. You can segment your visitors based on their Country, State or City here.</p>
		<h3>Steps:</h3>
		<ol>
			<li>Select the geography of your visitor segment</li>
			<li>Name the Segment and Save it</li>
		</ol>
		<hr>	
		<select id="geotype"><option>City</option><option>State</option><option>Country</option></select>&nbsp;
		<select id="rule"><option value="include">Equals</option><option value="exclude">Not Equals</option></select>&nbsp;
		<input type="text" id="geolocation">&nbsp;<button class="btn btn-outline-secondary btn-sm" onclick="addOption()">add</button>		
		<br>					
		
		<div id="geobucket" style="display: none;">
			<form id="segment-form">
				<input type="hidden" name="pageName" value="segments">
				<select id="dynamic-select" name="segment-rules" size="2"></select>
				<button class="btn btn-outline-secondary btn-sm" onclick="removeOption()">remove</button>&nbsp;<button class="btn btn-outline-secondary btn-sm" onclick="removeAllOptions()">remove all</button>
				<br><br>
				Segment Name: <input id="segment-name" type="text">&nbsp;
				<button class="btn btn-primary" onclick="saveSegment();">Save</button>							
			</form>
		</div>
																					       	
</div><!--Container-->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script -->
</body>
</html>