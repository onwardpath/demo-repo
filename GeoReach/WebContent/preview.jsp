<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%String html = (String) session.getAttribute("content");%>
<div style="float: left;">
<style>
h1:hover, h2:hover, p:hover, img:hover {		
	background: #05f;
	opacity: 0.25;
}
</style>
<script src="./assets/js/jquery-3.4.1.min.js"></script>
<script>
function close() {	
	window.history.back();
}
function add(){		
	var mousePosition;
	var offset = [0,0];
	var isDown = false;
		
	var dDiv = document.createElement('div');
	dDiv.id = 'block';
	dDiv.className = 'block';
	dDiv.innerHTML = "<h1>Hi I am your new Experience</h1><p>Coming to your page soon</p>";	
	document.getElementsByTagName('body')[0].appendChild(dDiv);
	
	dDiv.style.display = "block";
	dDiv.style.cursor = "move";
	dDiv.style.right = "300px";
	dDiv.style.top = "300px";
	dDiv.style.width = "500px";
	dDiv.style.height = "100px";	
	dDiv.style.position = "fixed";
	
	dDiv.addEventListener('mousedown', function(e) {
	    isDown = true;
	    offset = [
	    	dDiv.offsetLeft - e.clientX,
	    	dDiv.offsetTop - e.clientY
	    ];
	}, true);
	
	document.addEventListener('mouseup', function() {
	    isDown = false;		    
	    var parentPositionLeft = dDiv.getBoundingClientRect().left;
	    var parentPositionTop = dDiv.getBoundingClientRect().top;
	    //alert("parentPositionLeft: "+parentPositionLeft);
	    //alert("parentPositionTop: "+parentPositionTop);
	    dDiv.style.left = parentPositionLeft+'px';
	    dDiv.style.top = parentPositionTop+'px';
	    dDiv.style.position = "absolute";
        console.log(dDiv.style.left);      	
	    
	}, true);
	
	document.addEventListener('mousemove', function(event) {
	    event.preventDefault();
	    if (isDown) {
	        mousePosition = {	    
	            x : event.clientX,
	            y : event.clientY	    
	        };
	        dDiv.style.left = (mousePosition.x + offset[0]) + 'px';
	        dDiv.style.top  = (mousePosition.y + offset[1]) + 'px';	        
	    }	    	    	   
	}, true);	
}

function getStyle(el, styleProp) {
  var value, defaultView = (el.ownerDocument || document).defaultView;
  // W3C standard way:
  if (defaultView && defaultView.getComputedStyle) {
    // sanitize property name to css notation
    // (hypen separated words eg. font-Size)
    styleProp = styleProp.replace(/([A-Z])/g, "-$1").toLowerCase();
    return defaultView.getComputedStyle(el, null).getPropertyValue(styleProp);
  } else if (el.currentStyle) { // IE
    // sanitize property name to camelCase
    styleProp = styleProp.replace(/\-(\w)/g, function(str, letter) {
      return letter.toUpperCase();
    });
    value = el.currentStyle[styleProp];
    // convert other units to pixels on IE
    if (/^\d+(em|pt|%|ex)?$/i.test(value)) { 
      return (function(value) {
        var oldLeft = el.style.left, oldRsLeft = el.runtimeStyle.left;
        el.runtimeStyle.left = el.currentStyle.left;
        el.style.left = value || 0;
        value = el.style.pixelLeft + "px";
        el.style.left = oldLeft;
        el.runtimeStyle.left = oldRsLeft;
        return value;
      })(value);
    }
    return value;
  }
}
</script>

<body>
<a href="javascript:close();">Close</a>&nbsp;
<button onclick="javascript:add()">Add Experience</button>

</div>
<%=html%>