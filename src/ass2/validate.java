package ass2;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;

import java.io.*;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.Statement;
import com.sun.jdi.connect.spi.Connection;
@WebServlet("/validate")
public class validate extends HttpServlet {
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		String name=request.getParameter("name");
		String pass=request.getParameter("pass");
		
	
			try
			{    	Class.forName("com.mysql.jdbc.Driver"); 
				java.sql.Connection conn = null; 
				 String url="jdbc:mysql://localhost:1234/web_2";
				 conn= DriverManager.getConnection(url,"root","1234"); 
			   	String query="SELECT COUNT(*) FROM customer WHERE name='"+name+"' and pass='"+pass+"'";
				 
			    Statement st=(Statement) ((java.sql.Connection) conn).createStatement();
				ResultSet rs = st.executeQuery(query);
				  rs.next();
			     int count = rs.getInt(1);
			       if(count>0)
			    	{
			    	    HttpSession session=request.getSession(true);
	                    session.setAttribute("name",name);
	                    RequestDispatcher rd=request.getRequestDispatcher("home.jsp");
	                    rd.forward(request,response);
			    	}
					else
					{
						 RequestDispatcher rd=request.getRequestDispatcher("login.jsp");
		                    rd.forward(request,response);
					}
			}
			catch(Exception e)
            {
                System.out.print(e);
            }
			
				 
	}
}
