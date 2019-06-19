<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<script>
$( document ).ready(function() {
var serviceURL= "http://lab01.onwardpath.com:8080/GeoTargetService/webresources/GeoTargetService/locationBasedImage";
var geobased_elements = $('[alt="geobased"]');

$.getJSON(serviceURL,function (data) {
  var i;
  for(i=0;i<geobased_elements.length;i++)
  {
	if(geobased_elements[i].tagName == "IMG")
	{
    	var locationbasedImage_element = geobased_elements[i];
  		locationbasedImage_element.src = data.imageSrc;
		locationbasedImage_element.parentElement.href = data.imageSrc;
	}
	else if(geobased_elements[i].tagName == "SPAN")
	{
		var locationbasedSpan_element = geobased_elements[i];
    	locationbasedSpan_element.innerHTML += data.city;
	}
  }
});
</script>


<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id="></script>
<script>
window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());

gtag('config', '', { 'optimize_id': 'GTM-543MHZZ'});
</script>


<meta charset="ISO-8859-1">
<title>Insert title here</title>

<script type="text/javascript">
var myObject = {
  "ircEvent": "PRIVMSG",
  "method": "newURI",
  "regex": "^http://.*"
};

function myFunction(name) {
  //delete myObject.regex;
  delete myObject[name]
  console.log(myObject);
}
</script>
</head>
<body>

<h1>Remove Items</h1>

<button onclick="myFunction('ircEvent')">Remove</button>

</body>
</html>