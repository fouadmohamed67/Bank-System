
<!		fouad mohamed fouad
		is g1
		20180198
-->
 
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

 
	 
  <div class="card d-flex justify-content-center" >
        <div class="card-header">
             <div class="h1 d-flex justify-content-center">login now</div>
        </div>
        <div class="card-body">

            <form action="validate" method="POST" class="form">
                <div class="form-group">
                    <label for="name">email : </label>
                    <input type="text" class="form-control" name="name" >
                </div>
 
                <div class="form-group">
                    <label for="password">password : </label>
                    <input type="password" class="form-control" name="pass" >
                </div>
                 


                <div class="form-group">
                    <input type="submit" value="login" class="btn btn-primary" name="submit" >   
                </div>
            </form>
            <a href="register.jsp">register ? </a>

        </div>
    </div>
</div>
</body>
</html>