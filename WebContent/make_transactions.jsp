<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

</head>
<body>
<%@ page import="java.io.*" %>
	<%@ page import="java.sql.*" %>
	<%@ page import="java.lang.ClassNotFoundException" %>
	<%@  include file = "fun.jsp"%>
<% 
	if(null == session.getAttribute("name")){
		response.sendRedirect("login.jsp");

	}else{
		
		 if("POST".equals(request.getMethod())){
		 
			 String from_ac=(String)session.getAttribute("id");
			 String to_ac=(String)request.getParameter("to");
			 String amount=(String)request.getParameter("amount");
			  
			 int from_int=Integer.parseInt(from_ac);
			 int to_int=Integer.parseInt(to_ac);
			 int amount_int=Integer.parseInt(amount);
			  
			 System.out.print(from_int+" "+to_int);
			 if(check_user_has_account(to_int))
			 { 
				 if(check_balance(from_int,amount_int))
				 {
					 make_trans(from_int,to_int,amount_int);
					 session.setAttribute("success_trans", "done");
					 response.sendRedirect("show_transactions.jsp");
					 
				 }
				 else
					 
				 {
					 out.println("<div class='alert alert-danger'>account right but amount less than ur balance</div>");
					 response.setIntHeader("Refresh", 2);

				 }
			 }
			 else
			 {
				 out.println("<div class='alert alert-danger'>this acc not exist</div>");
				 response.setIntHeader("Refresh", 2);

			 }

			 
			 
		 
		 }
		
	}
		%>
		
		<script>  
		 
				function validattransactions(){  
				var to=document.m_form.to.value;  
				var amount=document.m_form.amount.value;  
				console.log(to);
				console.log(amount);
				
				if (isNaN(to) ){  
					  document.getElementById("alertval1").innerHTML="<div class='alert alert-danger'>Enter Numeric id </div>";  
					  return false;  
					}
				if(isNaN(amount))
					{
					document.getElementById("alertval2").innerHTML="<div class='alert alert-danger'>Enter Numeric balance </div>";  
					  return false;  
					}
				return true
					    
				}  
			</script> 
		                <div class="card-header">
                            <div class="h1 d-flex justify-content-center">make transactions</div>
                            <a href="home.jsp">home</a>
                        </div>
                         <%
                         try{
                        	 String from_ac=(String)session.getAttribute("id");
                        	 int from_int=Integer.parseInt(from_ac);
                 			String query="SELECT * FROM accounts WHERE customer_id="+from_int+"";
                 			 
                 			Connection conn=do_conn();
                 		    Statement st=conn.createStatement();
                 			ResultSet rs = st.executeQuery(query);
                 		    rs.next();
                 		    int balance=rs.getInt("balance"); 
                 		  %>
                 		  <div class="col-md-12 alert alert-secondary">your balance : <%out.print(balance); %></div>
                 		  <%  
                 		}
                 		catch(Exception e)
                 			{
                 			 System.out.print(e); 
                 			}
                 	 
                         %>
	<form action="" method="POST" name="m_form" class="form" onsubmit="return validattransactions()">
                 <div class="form-group col-md-6">
                    <label for="to">send to : </label>
                    <input type="text" class="form-control" name="to" >
                </div>
                <div class="warning" id="alertval1"></div>
 
                <div class="form-group col-md-6">
                    <label for="amount">amount : </label>
                    <input type="text" class="form-control" name="amount" >
                </div>
                <div class="warning" id="alertval2"></div>
                   
                <div class="form-group col-md-6">
                    <input type="submit" value="send "   class="btn btn-success" name="submit" >   
                </div>
      </form>
            
	
</body>
</html>