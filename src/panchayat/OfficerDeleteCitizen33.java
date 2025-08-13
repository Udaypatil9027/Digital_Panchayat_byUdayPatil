package panchayat;
import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class OfficerDeleteCitizen33
 */
public class OfficerDeleteCitizen33 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OfficerDeleteCitizen33() {
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
		String strid = request.getParameter("id");
		int id = Integer.parseInt(strid);
		
		PreparedStatement pt1;
		try {
			pt1 = con.prepareStatement("DELETE FROM citizen WHERE id=?");
			pt1.setInt(1, id);
			int i = pt1.executeUpdate();
			
			if(i>0){
				response.sendRedirect("OfficerViewCitizen33.jsp");
			}
			else{
				response.sendRedirect("OfficerViewCitizen33.jsp");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
