package panchayat;
import java.sql.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class StatusOfficer
 */
public class StatusOfficer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StatusOfficer() {
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
		int id = Integer.parseInt(request.getParameter("id"));
		String newStatus = request.getParameter("status");

		try {
			Connection con = DBConnection.connect();
			PreparedStatement ps = con.prepareStatement("UPDATE complaints SET status = ? WHERE id = ?");
			ps.setString(1, newStatus);
			ps.setInt(2, id);

			ps.executeUpdate();
			ps.close();
			con.close();

			response.sendRedirect("OfficerViewComplaints33.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("OfficerViewComplaints33.jsp");
		}
	}
}
	
