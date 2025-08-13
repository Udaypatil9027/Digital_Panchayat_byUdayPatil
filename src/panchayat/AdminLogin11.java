package panchayat;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdminLogin11
 */
public class AdminLogin11 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminLogin11() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String Email = request.getParameter("email");
		String Password = request.getParameter("password");

		String aemail = "admin@gmail.com";
		String apass = "admin123";
		
		try{
			Connection con = DBConnection.connect();
		
		if(Email.equals(aemail) && Password.equals(apass)){
			
			response.sendRedirect("AdminHome11.html");
			
		}
		else{
			response.sendRedirect("e_addlog.html");
		}
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
	
		
	}

}
