<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>customer</title>
</head>
<body><form action="/customer/save" method="post">
<table>
<tr>
<td> first name:</td>
<td> <input type="text" name="fname"></td>
</tr>
<tr>
<td> last name:</td>
<td> <input type="text" name="lname"></td>
</tr>
<tr>
<td> contact number</td>
<td> <input type="text" name="number"></td>
</tr>
<tr>
<td> <input type="submit" name="submit"></td>
</tr>
</table>
</form>
</body>
</html>