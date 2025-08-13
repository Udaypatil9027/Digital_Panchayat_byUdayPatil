package panchayat;
import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdminAddOfficer11
 */
public class AdminAddOfficer11 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminAddOfficer11() {
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

		Connection con = DBConnection.connect();

		String name = request.getParameter("name");
		String designation = request.getParameter("designation");
		String contact = request.getParameter("contact");
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		try {
			PreparedStatement pt1 = con.prepareStatement("SELECT * FROM officer WHERE contact=? AND email=?");
			pt1.setString(1, contact);
			pt1.setString(2, email);

			ResultSet rs = pt1.executeQuery();

			if (rs.next()) {
				
				response.sendRedirect("e_offadd.html");
			} else {
				
				PreparedStatement pt2 = con.prepareStatement(
					"INSERT INTO officer(name, designation, contact, email, password) VALUES (?, ?, ?, ?, ?)");
				pt2.setString(1, name);
				pt2.setString(2, designation);
				pt2.setString(3, contact);
				pt2.setString(4, email);
				pt2.setString(5, password);

				int count = pt2.executeUpdate();

				if (count > 0) {
					response.sendRedirect("S_offadd.html"); 
				} else {
					response.sendRedirect("e_offadd.html");
				}
				pt2.close();
			}
			rs.close();
			pt1.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
			response.sendRedirect("e_offadd.html");
		}
	}
}