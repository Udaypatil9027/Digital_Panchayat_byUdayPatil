package panchayat;
import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CitizenLogin22
 */
public class CitizenLogin22 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CitizenLogin22() {
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
		   String email = request.getParameter("email");
	        String password = request.getParameter("password");

	        try {
	            Connection con = DBConnection.connect();
	            PreparedStatement ps = con.prepareStatement("SELECT * FROM citizen WHERE email=? AND password=?");
	            ps.setString(1, email);
	            ps.setString(2, password);
	            ResultSet rs = ps.executeQuery();

	            if (rs.next()) {
	                CitizenBean.setEmail(email);
	                response.sendRedirect("CitizenHome.html"); 
	            } else {
	                response.sendRedirect("CitizenLogin22.html");
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	            response.sendRedirect("CitizenLogin22.html");
	        }
	    }
	}