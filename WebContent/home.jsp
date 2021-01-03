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
	   String name = (String)session.getAttribute("name");
	 
	  String query="SELECT * FROM customer WHERE name='"+name+"'";
		Connection conn=do_conn();
	    Statement st=conn.createStatement();
		ResultSet rs = st.executeQuery(query);
		while(rs.next())
        {
			session.setAttribute("id",rs.getString("id"));
			session.setAttribute("address",rs.getString("address"));
			session.setAttribute("mobile",rs.getString("mobile"));
			 
        } 
 		String id= (String)session.getAttribute("id");
 		int id_user=Integer.parseInt(id);  
 		
 		%>
 			 <div class="card d-flex justify-content-center" >
                        <div class="card-header">
                            <div class="h1 d-flex justify-content-center">bank home</div>
                        </div>
                        <div class="card-body">
                       	<a href="logout.jsp">logout</a>
                           <div>name : <% out.println(session.getAttribute("name")); %></div>
                           <div>address : <% out.println(session.getAttribute("address")); %></div>
                           <div>mobile : <% out.println(session.getAttribute("mobile")); %></div>
                           
                
 		<% 
		if(!check_user_has_account(id_user) )
		{
			%>
			<a class="btn btn-primary" href="add_account?id=<% out.print(id_user);%>"><% out.println("create an account"); %></a>
			<% 
		}
		else
		{
			 
            try{
           	 String from_ac=(String)session.getAttribute("id");
           	 int from_int=Integer.parseInt(from_ac);
    			  query="SELECT * FROM accounts WHERE customer_id="+from_int+"";
    			 
    			  conn=do_conn();
    		      st=conn.createStatement();
    			  rs = st.executeQuery(query);
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
			 
			<a href="show_transactions.jsp"><% out.println("show transactions "); %></a>
			<br>
			<a href="make_transactions.jsp"><% out.println("make transaction "); %></a>
			<% 
		}
		
	  
	}
%>

                   </div>
                </div>
	
</body>
</html>