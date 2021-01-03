<%@ page import="java.io.*" %>
	<%@ page import="java.sql.*" %>
	
	<%@ page import="java.lang.ClassNotFoundException" %>
<%! 
   public Connection do_conn()
     {
		Connection conn = null; 
		 String url="jdbc:mysql://localhost:1234/web_2";
	
 			try
 			{    	Class.forName("com.mysql.jdbc.Driver"); 

 			   	conn= DriverManager.getConnection(url,"root","1234"); 
 				 

 			}
 			catch(Exception e)
 			{
				 System.out.print(e); 
 			}
 		 return conn;
     }
	public void increament_balance(int to_ac,int amount)
	{
		try{
			Connection conn=do_conn();
	        String query="UPDATE accounts SET balance=balance+?  where  id=? ";
	        PreparedStatement preparedStmt = conn.prepareStatement(query);
	        preparedStmt.setInt(1,amount);
	        preparedStmt.setInt(2,to_ac); 
	        preparedStmt.execute();
        
			}
			catch(Exception e)
			{
			 System.out.print(e); 
			}

	}
	public void decreament_balance(int from_ac,int amount)
	{
		try{
			Connection conn=do_conn();
	        String query="UPDATE accounts SET balance=balance-?  where  id=? ";
	        PreparedStatement preparedStmt = conn.prepareStatement(query);
	        preparedStmt.setInt(1,amount);
	        preparedStmt.setInt(2,from_ac); 
	        preparedStmt.execute();
	        System.out.println(from_ac+" dec");
        
			}
			catch(Exception e)
			{
			 System.out.print(e); 
			}
	}
	public void delete_trans(int id)
	{
		try{
			Connection conn=do_conn();
			String query = "delete from transaction where id = ?";
	        PreparedStatement preparedStmt = conn.prepareStatement(query);
	        preparedStmt.setInt(1,id);
	        
	        preparedStmt.execute();
        
			}
			catch(Exception e)
			{
			 System.out.print(e); 
			}
	     
 	}
	public void cancel_trans(int id)
	{
			try{
				String query="SELECT * FROM transaction WHERE id="+id+"";
				 
				Connection conn=do_conn();
			    Statement st=conn.createStatement();
				ResultSet rs = st.executeQuery(query);
			    rs.next();
			    int amount=rs.getInt("amount");
			    int from_a=rs.getInt("from_a");
			    int to_a=rs.getInt("to_a");
			    
			    increament_balance(from_a,amount);
			    decreament_balance(to_a,amount);
			    delete_trans(id);
			    
			     
					
			}
			catch(Exception e)
				{
				 System.out.print(e); 
				}
		}
    public void make_trans(int from_customer,int to_customer,int amount)
    {
    	try
    	{
    		
    		Connection conn=do_conn();
    		 String query="select id from accounts where customer_id="+from_customer;
    		 Statement st=conn.createStatement();
    			ResultSet rs = st.executeQuery(query);
    			int from_ac=0;
    			while(rs.next())
    			{
    				from_ac=rs.getInt("id");
    				
    			}
    			System.out.println("from accc"+from_ac);
    			
    			
	    	   	    query="select id from accounts where customer_id="+to_customer;
	       	        st=conn.createStatement();
	       		    rs = st.executeQuery(query);
	       			int to_ac=0;
	       			while(rs.next())
	       			{
	       				to_ac=rs.getInt("id");
	       				
	       			}
	       			System.out.println("from accc"+to_ac);
     			
    			
    			
    			
              query="INSERT INTO transaction (from_a,to_a,amount,create_date) VALUES(?, ?, ? ,?) ";
            PreparedStatement preparedStmt = conn.prepareStatement(query);
            preparedStmt.setInt(1,from_ac);
            preparedStmt.setInt(2,to_ac); 
            preparedStmt.setInt(3, amount);
            preparedStmt.setTimestamp(4, new Timestamp(System.currentTimeMillis())); 
            preparedStmt.execute();
            increament_balance(to_ac,amount);
            decreament_balance(from_ac,amount);
    	}
    	catch(Exception e)
		{
		 System.out.print(e); 
		}
    }
	public void add_acc(int id)
	{
		try
		{
			Connection conn=do_conn();
	        String query="INSERT INTO accounts (balance,customer_id,create_date) VALUES(?, ?, ? ) ";
	        PreparedStatement preparedStmt = conn.prepareStatement(query);
	        preparedStmt.setInt(1,1000);
	        preparedStmt.setInt(2,id);
	        preparedStmt.setTimestamp(3, new Timestamp(System.currentTimeMillis())); 
	        preparedStmt.execute();
	        
	        
		}
		catch(Exception e)
			{
			 System.out.print(e); 
			}
	}
	public void add_customer(String name,String address,String mobile,String password)
	{
		try
		{
			Connection conn=do_conn();
	        String query="INSERT INTO customer (name,address,mobile,pass) VALUES(?, ?, ?, ?) ";
	        PreparedStatement preparedStmt = conn.prepareStatement(query);
	        preparedStmt.setString(1,name);
	        preparedStmt.setString(2,address);
	        preparedStmt.setString(3,mobile);
	        preparedStmt.setString(4,password); 
	        preparedStmt.execute();
	        
	        
		}
		catch(Exception e)
			{
			 System.out.print(e); 
			}
		
	}
	public boolean check_balance(int customer_id,int amount)
	{
		try{
			String query="SELECT COUNT(*) FROM accounts WHERE customer_id="+customer_id+" and balance>="+amount+"";
			 
			Connection conn=do_conn();
		    Statement st=conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			  rs.next();
		     int count = rs.getInt(1);
 			if(count>0)
		    	return true;
			else
				return false;

				
		}
		catch(Exception e)
			{
			 System.out.print(e);
				return false;
			 

			}
	}
	public boolean check_user_has_trans(int customer_id)
	{
		try{
			String query="SELECT COUNT(*) FROM transaction WHERE from_a="+customer_id+"";
			Connection conn=do_conn();
		    Statement st=conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			  rs.next();
		     int count = rs.getInt(1);
 			if(count>0)
		    	return true;
			else
				return false;

				
		}
		catch(Exception e)
			{
			 System.out.print(e);
				return false;
			 

			}
	}
	public boolean check_user_has_account(int customer_id)
	{
		try{
			String query="SELECT COUNT(*) FROM accounts WHERE customer_id="+customer_id+"";
			Connection conn=do_conn();
		    Statement st=conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			  rs.next();
		     int count = rs.getInt(1);
 			if(count>0)
		    	return true;
			else
				return false;

				
		}
		catch(Exception e)
			{
			 System.out.print(e);
				return false;
			 

			}
	}
	public boolean validate_login(String name,String pass)
	{
		try{
			String query="SELECT COUNT(*) FROM customer WHERE name='"+name+"' and pass='"+pass+"'";
			Connection conn=do_conn();
		    Statement st=conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			  rs.next();
		     int count = rs.getInt(1);
 			if(count>0)
		    	return true;
			else
				return false;

				
		}
		catch(Exception e)
			{
			 System.out.print(e);
				return false;
			 

			}
	}
	public boolean check_user_exist(String name )
	{
		try{
			String query="SELECT COUNT(*) FROM customer WHERE name='"+name+"'";
			Connection conn=do_conn();
		    Statement st=conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			  rs.next();
		     int count = rs.getInt(1);
 			if(count>0)
		    	return true;
			else
				return false;

				
		}
		catch(Exception e)
			{
			 System.out.print(e);
				return false;
			 

			}
	}
%>