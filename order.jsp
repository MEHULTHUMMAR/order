<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
	<style type="text/css" >
	.hide{
	display:none;
	}
	</style>
</head>
<body>



<form action="/order/save" method="post" >
<div class="col-sm-4" style="margin-top: 35px;">
 <select id="customer" name="customer.cid">
  <option value="0">customer</option>
 </select>
 <span id="dt">
 &ensp;
    <label for="date">Date:</label>
    <input type="date" id="date" name="orderDate">
    </span>
</div>    
<table  class="table tbale-striped" id="product_table">
<thead>
<tr>
<td>No.</td>
<td> Product</td>
<td> Quantity</td>
<td> Amount</td>
<td> Total</td>
</tr>
</thead>
<tbody data-jobwork-list="">
<tr id="Aitem" data-jobwork-item="template" class="hide">
<td data-item-index="">	</td>
<td> <select id="product{index}"  name="orderitem[{index}].product.pid" class="Product">
<option value="0">product</option>
</select></td>
<td><input type="text" id="quantity{index}" name="orderitem[{index}].quantity" ></td>
<td><input type="text" id="amount{index}" name=""></td>
<td><input type="text" id="total{index}"  name="orderitem[{index}].amount" class="Amount" value="0"> </td>
<td><button class="btn btn-danger delete-row" data-item-remove="">delete</button></td>
</tr>
</tbody>
<tr>
<td></td>
<td></td>
<td></td>

<td>total Amount</td>
<td><div class="col-sm-4"><input type="text" id="tot_amt" name="tAmount"></div> </td>
</tr>

<tr>
<!-- <td><input type="text" id="op_val"></td>
<td><input type="button"  id="add-all-item" value="add many item"></td>-->

<td><input type="button"  id="add-item" value="add item"></td>
<td><input type="submit"></td>
</tr>
</table>
</form>

<script type="text/javascript">
var productId=0, index=0;
$(document).ready(function()
{

	console.log("Doc is Ready........");
	//customer dropdown
	 $.get("/allcustomer", function(customer, status)
		  {
				 $.each(customer, function(i,c) 
				 {
					  $('#customer').append('<option value="' + c.cid + '">' + c.fname + '</option>');
				 });
		  });
	 
	
	 
	/*  $("#add-all-item" ).click(function() 
				{
					var rows=$("#op_val").val();
					for (i = 0; i < rows; i++) 
					{
						addProduct();
					}
					$("#op_val").val("");
				});
				
				 $('#op_val').keypress(function(e)
				{
				      if(e.keyCode==13)
			          {
				    	  e.preventDefault();
					      $('#add-all-item').click();
			          }

				}); */
				 
	 $('#add-item').on('click',function(e)
			  {
		 		e.preventDefault();
		 		addProduct();
		 		index=productId;
		 		
		 		 $.get("/allproduct", function(product, status)
		 				  {
		 						 $.each(product, function(i,p) 
		 						 {
		 							  $("#product"+index).append('<option value="' + p.pid + '">' + p.pname + '</option>');
		 						 });
		 				  });
		 		//price selection
		 		 $("#product"+index).change(function(){
		 			 $("#amount"+index).empty();
		 			 var id=$('option:selected', this).val();
		 			 $.get("/allproduct/"+id, function(product, status)
		 					  { 
		 				      $("#amount"+index).val(product.amount)
		 					  });
		 		 });
		 		 
		 		 //total price calculation
		 		 $("#quantity"+index).keyup(function(){
		 			 $("#total"+index).empty();
		 		 var amount=$("#amount"+index).val();
		 		 var qty=$("#quantity"+index).val();
		 		 $("#total"+index).val(amount*qty);
		 		 });
		 		 
		 		$("#quantity"+index).keyup(function(){
					var tm=0;
					$(".Amount").each(function(){
					var	sum=parseFloat($(this).val());
						tm=tm+sum;
					});
					
					console.log("tm"+tm)
					$("#tot_amt").val(tm);
					
				});
		 	     
		 		
/* 					$("#amount"+index).each(function(){
					
					});
					console.log("tm"+tm)
					$("#tot_amt").val(tm);
				});
		 		 table.find('tr').each(function (i, el) {
		 	        var $tds = $(this).find('td'),
		 	            productId = $tds.eq(0).text(),
 */		 		/*  $("#quantity").keyup(function(){
		 			 $("#tot_amt").empty();
		 		 var amount=$("#total").val();
		 		 $("#tot_amt").val(amount);
		 		 });	
		 		 */
		 		 productId++; 
			  });
			  function addProduct() {
				  $row = $('#product_table').find("[data-jobwork-item='template']").clone();
				  $row.removeClass("hide").attr("data-jobwork-item",productId);
				  $row.find("input[type='text'],input[type='hidden'],select,textarea,span").each(function ()
						  {
						  var n=$(this).attr("id");
						  n ? $(this).attr("id",n.replace(/{index}/,productId)) : "";
						  var n=$(this).attr("name");
						  n ? $(this).attr("name",n.replace(/{index}/,productId)) : "";
						  //$(this).attr("onchange") ? $(this).attr("onchange",$(this).attr("onchange").replace(/{index}/g,productId)) : "";
						  });
				  console.log($row);
				  $("#product_table").find("[data-jobwork-list]").append($row);
						
						setProductSrNo();
			  }
			  
			  function setProductSrNo() 
			  {
			  var $productItem=$("#product_table").find("[data-jobwork-item]").not(".hide");
			  var i = 0;
			  $productItem.each(function (){
			  $(this).find("[data-item-index]").html(++i);
			  });
			  }
			  
			  
			  $("#product_table").on("click",'button[data-item-remove]',function(e) {
					e.preventDefault();
					var i=$(this).closest("[data-jobwork-item]").attr("data-jobwork-item");
					console.log(i);
					$(this).closest("[data-jobwork-item]").remove();
					setProductSrNo();
					console.info(i)
					});
			  /* 
			  $("#tbody").change(function(){
					var tm=0;
					$("#amount"+index).each(function(){
						var	sum=parseFloat($(this).val());
							tm+=sum;
						});
					console.log("tm"+tm)
					$("#tot_amt").val(tm);
					}); */
}); 

</script>
</body>
</html>