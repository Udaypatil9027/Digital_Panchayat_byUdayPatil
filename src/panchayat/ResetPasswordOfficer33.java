package panchayat;
import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ResetPasswordOfficer
 */
public class ResetPasswordOfficer33 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResetPasswordOfficer33() {
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
		String oldpass = request.getParameter("oldPassword");
		String  newpass = request.getParameter("newPassword");
		String email = GetSet.getEmail();
		
		PreparedStatement pt1;
		try {
			pt1 = con.prepareStatement("SELECT * FROM officer WHERE email=? AND password=?");
			pt1.setString(1, email);
			pt1.setString(2, oldpass);
			
			ResultSet rs1 = pt1.executeQuery();
			
			if(rs1.next()){
				PreparedStatement pt2 = con.prepareStatement("UPDATE officer SET password=? WHERE email=?");
				pt2.setString(1, newpass);
				pt2.setString(2, email);
				
				int i=pt2.executeUpdate();
				if(i>0){
					response.sendRedirect("S_offpassres.html");
				}
				else{
					response.sendRedirect("eo_resetpass.html");
				}
			}else{
				response.sendRedirect("eo_resetpass.html");
			}
			
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
