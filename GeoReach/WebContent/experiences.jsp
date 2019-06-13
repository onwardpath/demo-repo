<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	<li>Experiences</li>
	</ul>
	
	<!-- Body Content -->
	<!-- https://www.associatedbank.com/content/image/mobile_upgrade_img_banking -->
	<!-- https://www.associatedbank.com/content/image/mobile_upgrade_img_mobile -->
	<!-- https://cdn.oectours.com/media/cds/banks/5231/59750.png -->
	<!-- https://cdn.oectours.com/media/cds/banks/5231/81461.png -->
	<!-- https://www.associatedbank.com/content/image/OLB_LP_Image -->
	<!-- https://x7i5t7v9.ssl.hwcdn.net/cds/banks/5231/81626.png -->
	<h1>Experiences</h1>
		
		<h3>Team Affinity Image</h3>
		<strong><mark>Image Experience</mark></strong>
		<br>
		<a href="#">ON/OFF</a>&nbsp;|&nbsp;<a href="#">Edit</a>&nbsp;|&nbsp;<a href="#">Delete</a>&nbsp;|&nbsp;<a href="#">Add Segment</a>&nbsp;|&nbsp;<a href="#">View Code</a>										
		<div><!-- Cards Container Start -->
			<!-- 1st card start -->
			<div class="d-inline-block">	
				<div class="card" style="width: 18rem;">
					<div class="card-body">
						<h5 class="card-title">Segment: Minnesota</h5>
						<!--h6 class="card-subtitle mb-2 text-muted">Image</h6-->			    		
			    		<img src="https://www.associatedbank.com/content/image/wild-cc-slide-btn" alt="wild card" class="rounded">			    					    	
			  		</div>
			  		<div class="card-footer">
				      <small class="text-muted">Last updated 3 mins ago</small>
				    </div>
				</div>		
		  	</div><!-- 1st card end -->
		  	<!-- 2nd card start -->
		  	<div class="d-inline-block" style="background-color: rgba(0,0,255,.1)">  		
		  		<div class="card" style="width: 18rem;">
		  			<div class="card-body">
		    			<h5 class="card-title">Segment: Wisconsin</h5>
		    			<!--h6 class="card-subtitle mb-2 text-muted">Image</h6-->		    			
		    			<img src="https://www.associatedbank.com/content/image/brewers-cc-slide-btn" alt="brewers card" class="rounded">		    					    				  
		  			</div>
		  			<div class="card-footer">
				      <small class="text-muted">Last updated 5 mins ago</small>
				    </div>
				</div>    		
		  	</div><!-- 2nd card end -->  		  	
		  	<!-- 3rd card start -->
		  	<div class="d-inline-block" style="background-color: rgba(0,0,255,.1)">  		
		  		<div class="card" style="width: 18rem;">
		  			<div class="card-body">
		    			<h5 class="card-title">Others</h5>
		    			<!--h6 class="card-subtitle mb-2 text-muted">Image</h6-->		    			
		    			<img src="https://www.associatedbank.com/content/image/visa-platinum-credit-card" alt="default card" class="img-thumbnail">		    					    				  
		  			</div>
		  			<div class="card-footer">
				      <small class="text-muted">Last updated 5 mins ago</small>
				    </div>
				</div>    		
		  	</div><!-- 3rd card end -->
		</div><!-- Cards Container End -->		
		
		<hr>
		<h3>Team Affinity Text</h3>	
		<strong><mark>Text Experience</mark></strong>
		<br>
		<a href="#">ON/OFF</a>&nbsp;|&nbsp;<a href="#">Edit</a>&nbsp;|&nbsp;<a href="#">Delete</a>&nbsp;|&nbsp;<a href="#">Add Segment</a>&nbsp;|&nbsp;<a href="#">View Code</a>									
		<div><!-- Cards Container Start -->
			<!-- first card start -->
			<div class="d-inline-block" style="background-color: rgba(0,0,255,.1)">	
				<div class="card" style="width: 18rem;">
					<div class="card-body">
						<h5 class="card-title">Segment: Minnesota</h5>
						<!--h6 class="card-subtitle mb-2 text-muted">Text</h6-->
			    		<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>			    		
			  		</div>
			  		<div class="card-footer">
				      <small class="text-muted">Last updated 10 mins ago</small>
				    </div>
				</div>		
		  	</div><!-- first card end -->
		  	<!-- second card start -->
		  	<div class="d-inline-block" style="background-color: rgba(0,0,255,.1)">  		
		  		<div class="card" style="width: 18rem;">
		  			<div class="card-body">
		    			<h5 class="card-title">Segment: Wisconsin</h5>
		    			<!--h6 class="card-subtitle mb-2 text-muted">Text</h6-->
		    			<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>		    					    		   
		  			</div>
		  			<div class="card-footer">
				      <small class="text-muted">Last updated 10 mins ago</small>
				    </div>
				</div>    		
		  	</div><!-- second card end -->  
		</div><!-- Cards Container End -->
		
		

</div><!-- container-fluid -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>