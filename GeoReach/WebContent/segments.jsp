<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<!--link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"-->
<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<style>
* {
  .border-radius(0) !important;
}

#field {
    margin-bottom:20px;
}
</style>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script type="text/javascript">
$(document).ready(function(){
    var next = 1;
    $(".add-more").click(function(e){
    	
        e.preventDefault();
        var addto = "#field" + next;
        var addRemove = "#field" + (next);
        next = next + 1;
        var newIn = '<input autocomplete="off" class="input form-control" id="field' + next + '" name="field' + next + '" type="text">';
        var newInput = $(newIn);
        alert("you clicked add: "+newInput);
        var removeBtn = '<button id="remove' + (next - 1) + '" class="btn btn-danger remove-me" >-</button></div><div id="field">';
        var removeButton = $(removeBtn);
        $(addto).after(newInput);
        $(addRemove).after(removeButton);
        $("#field" + next).attr('data-source',$(addto).attr('data-source'));
        $("#count").val(next);  
        
	$('.remove-me').click(function(e){
		alert("you clicked remove");
	    e.preventDefault();
	    var fieldNum = this.id.charAt(this.id.length-1);
	    var fieldID = "#field" + fieldNum;
	    $(this).remove();
	    $(fieldID).remove();
	});
});
    

    
});

function submitform()
{
  document.logout.submit();
}

var geo = "";

function addGeo() 
{		
	geo = geo + document.getElementById("geolocality").value+"\<button\>Remove\<\/button\>";	
	document.getElementById("selected-geo").innerHTML = escape(geo);
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
			 							
			<input type="hidden" name="count" value="1" />
	        <div class="control-group" id="fields">
	            <label class="control-label" for="field1">Enter Country/State/City</label>
	            <div class="controls" id="profs"> 
	                <form class="input-append">
	                    <div id="field"><input autocomplete="off" class="input" id="field1" name="prof1" type="text" placeholder="Type here" data-items="8"/><button id="b1" class="btn add-more" type="button">+</button></div>
	                </form>	            
	            <!-- small>Press + to add another form field :)</small-->
	            <br>
	            </div>
	        </div>
	        Segment Name <br>
	        <input type="text"/><br>
	        <button type="button" class="btn btn-primary">Save</button>	        	        
</div><!--Container-->
</body>
</html>