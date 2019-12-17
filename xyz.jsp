<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</head>
<body>
<h1>Student Form</h1>
<form action="/xyz" method="post" >
Name: <input type="text" name="sname" id="sname">
Mobile: <input type="text" name="smob" id="smob">
<input type="submit">

</form>
<hr>

<select id="slist">
<option value="0">Select ID</option>
</select>

<script type="text/javascript">
$(document).ready(function()
{
	console.log("Doc is Ready........");
	 $.get("/students", function(studs, status)
		  {
		    //alert("Data: " + stud[0].smob + "\nStatus: " + status);
				 $.each(studs, function(i,s) 
				 {
					  $('#slist').append('<option value="' + s.sid + '">' + s.sid + '</option>');
				 });
				 
		  
		  });
	 
	 $("#slist").change(function() 
	 {
		 var sid=$('option:selected', this).val();
		 
		 		  $.get("/students/"+sid, function(stud, status)
				  {
				    //alert("Data: " + stud.smob + "\nStatus: " + status);
						
				    $("#sname").val(stud.sname);
				    $("#smob").val(stud.smob);
				  });
		 
		 
//	        alert( $('option:selected', this).text() );
	 });
	 

});   ///ready complete
</script>
</body>
</html>