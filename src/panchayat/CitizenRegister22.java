package panchayat;
import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CitizenRegister22
 */
public class CitizenRegister22 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CitizenRegister22() {
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
		try {
            Connection con = DBConnection.connect();

            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String contact = request.getParameter("contact");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            PreparedStatement check = con.prepareStatement("SELECT * FROM citizen WHERE email = ? OR contact = ?");
            check.setString(1, email);
            check.setString(2, contact);
            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                response.sendRedirect("ec_regester.html");
            } else {
                PreparedStatement ps = con.prepareStatement("INSERT INTO citizen(name, address, contact, email, password) VALUES (?, ?, ?, ?, ?)");
                ps.setString(1, name);
                ps.setString(2, address);
                ps.setString(3, contact);
                ps.setString(4, email);
                ps.setString(5, password);

                int i = ps.executeUpdate();
                if (i > 0) {
                    response.sendRedirect("S_register.html");
                } else {
                    response.sendRedirect("CitizenRegister22.html");
                }
            }


        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("CitizenRegister22.html");
        }
    }
}
