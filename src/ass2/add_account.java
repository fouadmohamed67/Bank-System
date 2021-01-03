package ass2;
 
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.Timestamp;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;
import com.sun.jdi.connect.spi.Connection;
@WebServlet("/add_account")
public class add_account extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id=Integer.valueOf(request.getParameter("id"));
	 
		try
		{
			Class.forName("com.mysql.jdbc.Driver"); 
			java.sql.Connection conn = null; 
			 String url="jdbc:mysql://localhost:1234/web_2";
			 conn= DriverManager.getConnection(url,"root","1234"); 
	        String query="INSERT INTO accounts (balance,customer_id,create_date) VALUES(?, ?, ? ) ";
	        PreparedStatement preparedStmt = (PreparedStatement) conn.prepareStatement(query);
	        preparedStmt.setInt(1,1000);
	        preparedStmt.setInt(2,id);
	        preparedStmt.setTimestamp(3, new Timestamp(System.currentTimeMillis())); 
	        preparedStmt.execute();
	        RequestDispatcher rd=request.getRequestDispatcher("home.jsp");
	        rd.forward(request,response);
	        
	        
		}
		catch(Exception e)
			{
			 System.out.print(e); 
			}
		
	}
		
	 
		
		
	 
}
	
