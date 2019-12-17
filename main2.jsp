<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
    	
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title></title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
  

</head>
<body>

  <!-- Trigger the modal with a button -->
  <button type="button" class="btn btn-info btn-md" id="add_std" data-toggle="modal" data-target="#student" >Add Student</button>

  <!-- add  Modal -->
  <div class="modal fade" id="student" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Add student detail</h4>
        </div>
        <div class="modal-body">
			<form id="adduser" method="post" action="">
		        Name: <input type="text" name="sname" id="sname">
				Mobile: <input type="text" name="smob" id="smob">
				<input type="button" id="btnsave" name="submit" value="Save">
			</form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  
  
  <!-- edit   Modal -->
  <div class="modal fade" id="edit_detail" role="dialog" >
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Edit student detail</h4>
        </div>
        <div class="modal-body">
			<form method="post" action="/main" id="edit_form">
			<input type="hidden" name="sid" id="sid1">
		        Name: <input type="text" name="sname" id="sname1">
				Mobile: <input type="text" name="smob" id="smob1">
				<input type="button" name="submit" value="submit" class="submit1">
			</form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>

<hr>
<table border="1px" id="data">
    <thead>

<tr id="t_head">
	<th>ID.</th>
	<th>Student Name</th>
	<th>Number</th>
	<th>Action</th>
</tr>

<tbody class="t_body">
<%-- <c:forEach var="student" items="${students}">  
<tr id="user_id_${student.sid}">
	<td >${student.sid}</td>
	<td id="name">${student.sname}</td>
	<td id="mob">${student.smob}</td>
	<td><button class="edit" data-toggle="modal" data-id="${student.sid}" data-target="#edit_detail" >Edit</button> | <button class="btn btn-danger delete-user"  data-id="${student.sid}">Delete</button></td>
</tr>
</c:forEach> --%>
</tbody>  
</table>

<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="/js/jquery.spring-friendly.js"></script>
<script type="text/javascript"> 
$(document).ready(function()
{
	console.log("Doc is Ready........");

	 var table = $('#data').DataTable(
	{
		    'ajax' : {
		    	'contentType': 'application/json',
		        'url': '/std/data',
		        'type': 'POST',
		        'data': function(d) {
		            return JSON.stringify(d);
		          }
		    },
		    'serverSide' : true,
		    columns :  
		    [
		    {
		      data : 'sid'
		    },
		    {
			      data : 'sname',
			      /* render: function (data, type, row) 
			      {
			        return '<a href="/std/'+row.sid+'">'+data+'</a>'; //data || '';
			      } */
			}, 
			{
		      data : 'smob'
		    },
		    {
			      data : 'sid',
			      render: function (data, type, row) 
			      {
			        return '<button class="edit" data-toggle="modal" data-id="'+row.sid +'" data-target="#edit_detail" >Edit</button> | <button class="btn btn-danger delete-user"  data-id="'+row.sid+'">Delete</button>'; 
			      }
			}
		   
			]
		  });
	
	


	// for delete----------------------------------------------

	$('body').on('click', '.delete-user', function () 
	{
        var user_id = $(this).data("id");
        confirm("Are You sure want to delete !");
 
        $.ajax(
        {
            type: "GET",
            url: "/student/delete"+'/'+user_id,
            success: function (data) 
            {
                //$("#user_id_" + user_id).remove();
				var table = $('#data').DataTable();
				table.row('.selected').remove().draw( false );
                
            },
            error: function (data) {
                console.log('Error:', data);
            }
        });
    });   
	
	
	//for add user--------------------------------------
	
	$('#btnsave').on('click', function () 
	{
	    var values = $("#adduser").serialize();
	    
//	    alert(values);
	    $.ajax({
	    	  url: "/student/add",
	    	  type: "post",
	    	  data: values ,
	    	  success: function (res) 
	    	  {
	    		   $('#student').modal('toggle');
	    		   var value1='';
	    		   $.ajax({
				    	  url: "/students",
				    	  type: "get",
				    	  success: function (data) 
	    		   {
				    		  
				    		  console.log(data);
				    		  $.each(data , function(key,value){
				    			  
				    		 
				    		 value1 += '<tr id="user_id_'+ value.sid+'">';
				    		 value1 += '<td >'+ value.sid+'</td>';
				    		 value1 += '<td id="name">'+ value.sname+'</td>';						    			
				    		 value1 += '<td id="mob">'+ value.smob+'</td>';
				    		 value1 += '<td><button class="edit" data-toggle="modal" data-id="'+ value.sid+'" data-target="#edit_detail" >Edit</button> | <button class="btn btn-danger delete-user"  data-id="'+ value.sid+'">Delete</button></td></tr>';
				    		
				    		 $(".t_body").html(value1);
				    		  });
	    		   },
	    		   error: function(xhr, status, error) 
			    	  {
			    	    console.log(xhr.responseText);
			    	  }
	    		   });
	    	  },
	    	  error: function(xhr, status, error) 
	    	  {
	    	    console.log(xhr.responseText);
	    	  }
	    	});
	    		   
				/*alert('Form submitted successfully...')
				 document.getElementById("adduser").reset();
				 var id=res.sid;
				 var name=res.sname;
				 var mob=res.smob;
				 var row ='<tr  id="user_id_'+id+'"><td>' + id + '</td><td>' + name + '</td><td>' + mob + '</td><td><button class="edit" data-id="'+id+'" data-toggle="modal" data-target="#edit_detail">Edit</button> | <button class="btn btn-danger delete-user" data-id="'+id+'">Delete</button></td></tr>';
				 $('table tr:first').after(row);
	    		console.log(res);*/
	    	  
	});
	

	// for edit ------------------------------
	
	$('body').on('click', '.edit', (function()
			{
			        var user_id = $(this).data("id");
			        //confirm("Are You sure want to delete !");
			 
			        $.ajax(
			        {
			            type: "GET",
			            url: "/edit"+'/'+user_id,
			            success: function (data) 
			            {
			                console.log(data);
			                $("#sid1").val(data.sid);
			                $("#sname1").val(data.sname);
			                $("#smob1").val(data.smob);
			                
			            },
			            error: function (data) {
			                console.log('Error:', data);
			            }
			        });
			       
			}));
				
	$('.submit1').on('click', function () 
			{
			    var values = $("#edit_form").serialize();
			    
//			    alert(values);
			    $.ajax({
			    	  url: "/student/add",
			    	  type: "post",
			    	  data: values ,
			    	  success: function (res) 
			    	  {
			    		   $('#edit_detail').modal('toggle');
			    		   var value1='';
			    		   $.ajax({
						    	  url: "/students",
						    	  type: "get",
						    	  success: function (data) 
			    		   {
						    		  
						    		  console.log(data);
						    		  $.each(data , function(key,value){
						    			  
						    		 
						    		 value1 += '<tr id="user_id_'+ value.sid+'">';
						    		 value1 += '<td >'+ value.sid+'</td>';
						    		 value1 += '<td id="name">'+ value.sname+'</td>';						    			
						    		 value1 += '<td id="mob">'+ value.smob+'</td>';
						    		 value1 += '<td><button class="edit" data-toggle="modal" data-id="'+ value.sid+'" data-target="#edit_detail" >Edit</button> | <button class="btn btn-danger delete-user"  data-id="'+ value.sid+'">Delete</button></td></tr>';
						    		
						    		 $(".t_body").html(value1);
						    		  });
			    		   },
			    		   error: function(xhr, status, error) 
					    	  {
					    	    console.log(xhr.responseText);
					    	  }
			    		   });
			    	  },
			    	  error: function(xhr, status, error) 
			    	  {
			    	    console.log(xhr.responseText);
			    	  }
			    	});
});   
			
				
});
	
	

</script>
</body>
</html>