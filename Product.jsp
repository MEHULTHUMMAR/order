<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>products</title>
</head>
<body>
<form action="/product/save" method="post">
<table>
<tr>
<td> product name:</td>
<td> <input type="text" name="pname"></td>
</tr>
<tr>
<td> amount</td>
<td> <input type="text" name="amount"></td>
</tr>
<tr>
<td> <input type="submit" name="submit"></td>
</tr>

</table>
</form>


</body>
</html>