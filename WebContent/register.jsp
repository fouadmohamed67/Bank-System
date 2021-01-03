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
	 
	 
	 if("POST".equals(request.getMethod())){
		 String name=request.getParameter("name");
		 String address=request.getParameter("address");
		 String mobile=request.getParameter("mobile");
		 String password=request.getParameter("password");
		 

		if(!check_user_exist(name))
		{
			add_customer(name,address,mobile,password);
			
			session.setAttribute("name",name); 
			response.sendRedirect("home.jsp");

		}
		else
		{
			response.sendRedirect("register.jsp");
		}

 	 }
	 
	
 %> <script>  
			 
					function validatlogin(){  
					var name=document.login_form.name.value;  
					var address=document.login_form.address.value; 
					var password=document.login_form.password.value; 
					var mobile=document.login_form.mobile.value; 
					  
					 
					 if(name.length < 3)
						 { 
						 document.getElementById("err1").innerHTML="<div class='alert alert-danger'>name should be more 3 letters </div>";  
					      return false;  
						 }
					 if(address.length < 3)
						 { 
						 document.getElementById("err2").innerHTML="<div class='alert alert-danger'>address should be more 3 letters </div>";  
					      return false;  
						 }
					 if(mobile.length < 11)
						 { 
						 document.getElementById("err3").innerHTML="<div class='alert alert-danger'>phone number should be 11 number </div>";  
					      return false;  
						 }
					 if(password.length < 6)
						 { 
						 document.getElementById("err4").innerHTML="<div class='alert alert-danger'>phone number should be at least 8 letters </div>";  
					      return false;  
						 }
					    return true
					 
					
						    
					}  
				</script> 
<div class="container">
                <div class="card d-flex justify-content-center" >
                        <div class="card-header">
                            <div class="h1 d-flex justify-content-center">register</div>
                        </div>
                        <div class="card-body">
                            <form action="" name="login_form" method="POST" onsubmit="return validatlogin() ">
                             
                                        <div class="form-group">
                                            <label for="name">your name : </label>
                                            <input type="text" class="form-control"   name="name" required="required" >
                                        </div>
                                      	<div id="err1"></div>
                                          
                                        <div class="form-group">
                                            <label for="address">address : </label>
                                            <input type="text" class="form-control"   name="address" required="required" >
                                        </div>
                                        <div id="err2"></div>
                                        
                                        <div class="form-group">
                                            <label for="mobile">mobile : </label>
                                            <input type="text" class="form-control"   name="mobile" required="required" >
                                        </div>
                                        <div id="err3"></div>
                                        
                                        
                                        <div class="form-group">
                                            <label for="password">password : </label>
                                            <input type="password" class="form-control"   name="password" required="required"  >
                                        </div>
                                        <div class="err4"></div>
                                        
                                          <div class="form-group">
                                            <input type="submit" class="btn btn-primary" value="register" name="submit" id="">   
                                        </div>
                                         
                            </form>
                            <a href="login.jsp">you have account ?</a>
                        </div>
                </div>
         </div>

	        
</body>
</html>