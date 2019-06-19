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
<!-- test comment -->
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
	<li>Home</li>
	<li><a href="segments.jsp">Segments</a></li>
	<li><a href="experience-view.jsp">Experiences</a></li>
	<li><a href="#">Assets</a></li>
	<li><a href="#">Insights</a></li>
	<li><a href="#">Team</a></li>
	</ul>
	
	<!-- Body Content -->
	<h1>Associated Bank Image Gallery</h1><br>
	<h2>Select an image from the gallery</h2>
	<h4>Image URL: <input type="text" id="url" size="100"value=""></h4>
</div><!-- container-fluid -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>




<div class="container">
	<h1 class="font-weight-light text-center text-lg-left mt-4 mb-0">Thumbnail Gallery</h1>
	<hr class="mt-2 mb-5">
	<div class="row text-center text-lg-left">
		<div class="col-lg-3 col-md-4 col-6">
			<a href="#" class="d-block mb-4 h-100">
				<img id="image1" onclick="getImageURL('image1')" src="http://www.moneysmylife.com/wp-content/uploads/2016/08/Associated-Bank.jpg" class="img-fluid  img-thumbnail" />
			</a>
		</div>  
	    <div class="col-lg-3 col-md-4 col-6">
	      	<a href="#" class="d-block mb-4 h-100">
				<img id="image2" onclick="getImageURL('image2')" src="http://cms.ipressroom.com.s3.amazonaws.com/231/files/20150/Assoc._Bank_Sanderson_Photography_GB_WI_08.jpg" class="img-fluid img-thumbnail"/>
	    	</a>
	    </div>
		<div class="col-lg-3 col-md-4 col-6">
	      <a href="#" class="d-block mb-4 h-100">
			<img id="image3" onclick="getImageURL('image3')" src="https://www.poblocki.com/wp-content/uploads/2017/04/associated-bank-exterior-sign-main.jpg" class="img-fluid  img-thumbnail" />
		  </a>
		</div>
		<div class="col-lg-3 col-md-4 col-6">
			<a href="#" class="d-block mb-4 h-100">
				<img id="image4" onclick="getImageURL('image4')" src="http://madisonregion.org/wp-content/uploads/2015/03/University-Express-Branch-e1426797585930.jpg" class="img-fluid  img-thumbnail" />
			</a>
		</div>
		<div class="col-lg-3 col-md-4 col-6">
			<a href="#" class="d-block mb-4 h-100">
				<img id="image5" onclick="getImageURL('image5')" src="https://www.poblocki.com/wp-content/uploads/2017/04/associated-bank-exterior-sign-1.jpg" class="img-fluid  img-thumbnail" />
			</a>
		</div>
		<div class="col-lg-3 col-md-4 col-6">
			<a href="#" class="d-block mb-4 h-100">
				<img id="image6" onclick="getImageURL('image6')" src="https://pbs.twimg.com/media/DNL5E-DXcAIXaB3.jpg" class="img-fluid  img-thumbnail" />
			</a>
		</div>
		
		<div class="col-lg-3 col-md-4 col-6">
	      <a href="#" class="d-block mb-4 h-100">
			<img id="image7" onclick="getImageURL('image7')" src="https://www.bankcheckingsavings.com/wp-content/uploads/2016/06/Associated-Bank-Logo-B.png" class="img-fluid  img-thumbnail" />
		  </a>
		</div>
		<div class="col-lg-3 col-md-4 col-6">
			<a href="#" class="d-block mb-4 h-100">
				<img id="image8" onclick="getImageURL('image8')" src="http://www.billburmaster.com/lecentre/bank/images/assocmontgomeryil0113.jpg" class="img-fluid  img-thumbnail" />
			</a>
		</div>
		<div class="col-lg-3 col-md-4 col-6">
			<a href="#" class="d-block mb-4 h-100">
				<img id="image9" onclick="getImageURL('image9')" src="https://s3-media4.fl.yelpcdn.com/bphoto/7IagS1cUCXC1nGrA8niOFQ/o.jpg" class="img-fluid  img-thumbnail" />
			</a>
		</div>
		<div class="col-lg-3 col-md-4 col-6">
			<a href="#" class="d-block mb-4 h-100">
				<img id="image10" onclick="getImageURL('image10')" src="https://media.nbcchicago.com/images/1200*675/associated-bank-richmond-1.jpg" class="img-fluid  img-thumbnail" />
			</a>
		</div>
		<div class="col-lg-3 col-md-4 col-6">
			<a href="#" class="d-block mb-4 h-100">
				<img id="image11" onclick="getImageURL('image11')" src="https://www.associatedbank.com/content/image/Packers_Debit_MasterCard_PPC" class="img-fluid  img-thumbnail" />
			</a>
		</div>
		<div class="col-lg-3 col-md-4 col-6">
			<a href="#" class="d-block mb-4 h-100">
				<img id="image12" onclick="getImageURL('image12')"  src="https://www.associatedbank.com/content/image/brewers-checking-debit-card-tilt" class="img-fluid  img-thumbnail" />
			<a href="#" class="d-block mb-4 h-100">
		</div>		
	</div>
</div>
	
<script>
function getImageURL(x){
    var imageID=x;
	var imageUrl=document.getElementById(imageID).src;
	document.getElementById("url").value = imageUrl;
}
</script>



</body>
</html>