package panchayat;
import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteOfficer11
 */
public class DeleteOfficer11 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteOfficer11() {
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

		String idStr = request.getParameter("id");

		try {
			int id = Integer.parseInt(idStr);
			Connection con = DBConnection.connect();

			PreparedStatement pst = con.prepareStatement("DELETE FROM officer WHERE id=?");
			pst.setInt(1, id);
			int i = pst.executeUpdate();
			if(i>0){
				response.sendRedirect("AdminViewOfficer11.jsp");
			}else{
				response.sendRedirect("AdminViewOfficer11.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("AdminViewOfficer11.jsp"); // You can create an error page if needed
		}
	}
}
	
