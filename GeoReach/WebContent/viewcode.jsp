<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GeoReach</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<%
String experience_name = request.getParameter("n");
String experience_id = request.getParameter("e");
String org_id = request.getParameter("o");
%>
<div class="container">
<h1>Header Code</h1>
<table border="1" cellspacing="10" cellpadding="10"><tr><td>
<pre><code>
&lt;!-- GeoSmart --&gt;
&lt;script&gt;
(function(i,s,o,g,r,a,m){i['GeoSmartObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://lab01.onwardpath.com/geoservice?e=<%=experience_id%>&o=<%=org_id%>','ga');

ga('create', 'UA-XXXXX-Y', 'auto');
ga('send', 'pageview');
&lt;/script&gt;
&lt;!-- End GeoSmart --&gt;
</code></pre>
</td></tr></table>
<h1>Body Code</h1>
<table border="1" cellspacing="10" cellpadding="10"><tr><td>
<pre><code>
&lt;!-- GeoSmart --&gt;
&lt;div id="Geo-<%=experience_name%>-<%=experience_id%>"&gt;&lt;/div&gt;
&lt;!-- End GeoSmart --&gt;
</code></pre>
</td></tr></table>
</div><!-- container-fluid -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>