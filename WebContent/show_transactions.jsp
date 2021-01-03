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
						<div class="card-header">
                            <div class="h1 d-flex justify-content-center"> my transactions</div>
                            <a href="home.jsp">home</a>
                        </div>
                        
                        <%
                        if(null != session.getAttribute("success_trans"))
                        {
                        	%>
                        	<div class="alert alert-success">transaction is don successfully </div>
                        	<% 	
                        	session.removeAttribute("success_trans");
                        }
                         		%>
                        
<%@page   import="java.util.Date" %>
<%@page   import="java.util.Date" %>
<%@page   import="java.text.SimpleDateFormat" %>
	<%@ page import="java.io.*" %>
		<%@ page import="java.sql.*" %>
		<%@ page import="java.lang.ClassNotFoundException" %>
		<%@  include file = "fun.jsp"%>
	<% 
		if(null == session.getAttribute("name")){
			response.sendRedirect("login.jsp");
	
		}else{
			String id= (String)session.getAttribute("id");
	 		int id_user=Integer.parseInt(id);
	 		
	 		Connection conn=do_conn();
	 		String query="select id from accounts where customer_id="+id_user;
   		    Statement st=conn.createStatement();
   			ResultSet rs = st.executeQuery(query);
   			int id_ac=0;
   			while(rs.next())
   			{
   				id_ac=rs.getInt("id");
   				
   			}
   			System.out.println(id_ac);
	 		
	 		
			if(check_user_has_trans(id_ac))
			{
				  conn=do_conn();
				  query="SELECT * FROM transaction WHERE from_a="+id_ac+"";
				  st=conn.createStatement();
		        ResultSet re=st.executeQuery(query);
				%>
					 <div class="container">
			          <div class="table-responsive">
					           <table class="table ">
						            <thead>
						                <tr>
						                    <th>id</th>
						                    <th>from</th>
						                    <th>to</th>
						                    <th>amount</th>
						                    <th>date</th>
						                    <th>action</th>
						                </tr>
						            </thead>
						            <tbody>
						            <% while(re.next())
       								 {%>
       								 <tr>
       								 	<td><% out.print(re.getInt("id")); %></td>
       								 	<td><% out.print(re.getInt("from_a")); %></td>
       								 	<td><% out.print(re.getInt("to_a")); %></td>
       								 	<td><% out.print(re.getInt("amount")); %></td>
       								 	<td><% out.print(re.getTimestamp("create_date")); %></td>
       								 	
       								 	<%
       								 	Date old=re.getTimestamp("create_date");
         								Date current= new Timestamp(System.currentTimeMillis());
         								 
         								long  diff  = current.getTime() - old.getTime();
         					            long diffHours = (diff / (60*60*1000)); 

       								 	%>
       								 	<td><%  if(diffHours > 23 )
       								 				{out.print("no actions");} 
       								 			else
       								 			{
       								 				%>
       								 				<form action="cancel.jsp?id_trans=<%out.print(re.getInt("id"));%>" method="POST">
       								 					<button class="btn btn-danger">cancel</button>
       								 				</form>
       								 				<%
       								 			}
       								 	%></td>
       								 	
       								 </tr>
       								 <%} %>
						            </tbody>
					           </table>
			          </div>
	                </div>
				<% 
			}
			else
			{
				out.println("u do not have any transacrion");
				%>
				<a href="home.jsp">home</a>
				<br>
				<a href="make_transactions.jsp">make transactions</a>
				<% 
			}
		}
	%>
</body>
</html>