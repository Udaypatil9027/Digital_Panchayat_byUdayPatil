package panchayat;
import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ResetPassword22
 */
public class ResetPassword22 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResetPassword22() {
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

		String email = CitizenBean.getEmail();  // Logged-in citizen only
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");

        try {
            Connection con = DBConnection.connect();

            PreparedStatement check = con.prepareStatement("SELECT * FROM citizen WHERE email=? AND password=?");
            check.setString(1, email);
            check.setString(2, oldPassword);
            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                PreparedStatement update = con.prepareStatement("UPDATE citizen SET password=? WHERE email=?");
                update.setString(1, newPassword);
                update.setString(2, email);
                int i = update.executeUpdate();

                if (i > 0) {
                    response.sendRedirect("S_Password.html");
                } else {
                    response.sendRedirect("CitizenResetPassword.jsp");
                }

                update.close();
            } else {
                response.sendRedirect("CitizenResetPassword.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("CitizenResetPassword.jsp");
        }
    }
}