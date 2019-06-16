<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
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