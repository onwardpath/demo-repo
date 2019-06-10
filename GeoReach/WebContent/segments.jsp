<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/raphael.js"></script>
<script src="js/jquery.usmap.js"></script>
  
<script type="text/javascript">
function submitform()
{
  document.logout.submit();
}

var selected_states = "";

$(document).ready(function() {
    $('#map').usmap({
    	// The click action
  	  	click: function(event, data) {
  	  	selected_states = selected_states+" "+data.name;  	  	
  	    $('#clicked-state')
  	      .text('Your selections: '+selected_states)
  	      .parent().effect('highlight', {color: '#C7F464'}, 2000);
  	    
  	  }
    });       
});

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
<li>Segments</li>
<li><a href="experience.jsp">Experiences</a></li>
</ul>

<!-- Body Content -->
<h1>Segments</h1>
<p>Creating Segments is the first step to delivering unique experiences to your visitors. You can segment your visitors based on their Country, State or City here.</p>
<h2>Steps:</h2>
<ol>
<li>Select the geography of your visitors you wish to create a unique experience</li>
<li>Name the Segment and Save it</li>
</ol>
<hr>

<!-- https://newsignature.github.io/us-map/#demo -->
<div id="map" style="width: 500px; height: 500px;"></div>
<div id="clicked-state"></div>
</body>
</html>