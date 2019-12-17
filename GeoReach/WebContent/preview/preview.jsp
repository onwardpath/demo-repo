<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String html = (String) session.getAttribute("content");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<style>
/* Clear floats after the columns */
.externalpage {
	left: 0;
	width: 10%;
	height: 100%;
	position: fixed;
	top:0;
}

.sidenav {
	height: 100%;
	width: 10%;
	position: fixed;
	z-index: 1;
	top: 0;
	left: 0;
	background-color: cyan;
	overflow-x: hidden;
	padding-top: 20px;
}

.sidenav a:hover {
	color: #f1f1f1;
}

.main {
	margin-left: 170px;

	/* Same as the width of the sidenav */
}

#ifrm {
	width: 89%;
	right: 0;
	height: 100%;
	position: fixed;
	top:0;
}
</style>
<script>
	 var iframe;
         window.addEventListener('load', (event) => {
        	 var iframe = document.getElementById('ifrm');
        	 var content = document.getElementById("content").innerHTML;
        	
        	
        	 var frameDoc = iframe.document;
        	 if (iframe.contentWindow)
        			frameDoc = iframe.contentWindow.document;
        	
             	frameDoc.open();
        		frameDoc.writeln(content);
        		 
           	    frameDoc.close();
        		document.getElementById("content").remove();
        		
        		iframe.contentWindow.document.designMode = "on"; 
        		
     	});
            
     </script>

<body>
	<div class="sidenav">
		<iframe class="externalpage" src="/GeoReach/preview/leftside-iframe-treeview.jsp"></iframe>
	</div>
	<div class="main">
		<div id="content" style="display: none">
			<%=html%>
		</div>
		<iframe id="ifrm"></iframe>
	</div>
	
</body>
</html>