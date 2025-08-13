package panchayat;
import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class OfficerLogin33
 */
public class OfficerLogin33 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OfficerLogin33() {
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
		Connection con = DBConnection.connect();

		String email = request.getParameter("email");
		String contact = request.getParameter("contact");
		String password = request.getParameter("password");

		try {
			PreparedStatement pt1 = con.prepareStatement(
				"SELECT * FROM officer WHERE email=? AND contact=? AND password=?"
			);
			pt1.setString(1, email);
			pt1.setString(2, contact);
			pt1.setString(3, password);
			ResultSet rs1 = pt1.executeQuery();

			if (rs1.next()) {
				
				GetSet.setEmail(email);
			
				response.sendRedirect("OfficerHome33.html");
			} else {
				response.sendRedirect("eo_login.html");
			}

			rs1.close();
			pt1.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
			response.sendRedirect("eo_login.html");
		}
	}
}