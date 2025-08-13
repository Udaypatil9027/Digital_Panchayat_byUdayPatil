package panchayat;
import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdminNotices11
 */
public class AdminNotices11 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminNotices11() {
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
		  String title = request.getParameter("title");
	        String content = request.getParameter("content");
	        String publishDate = request.getParameter("publishDate");
	        String link = request.getParameter("officialLink");
	        try {
	            Connection con = DBConnection.connect();

	            PreparedStatement pst = con.prepareStatement("INSERT INTO notices(title, content, publishDate,link) VALUES (?, ?, ?, ?)");
	            pst.setString(1, title);
	            pst.setString(2, content);
	            pst.setDate(3, Date.valueOf(publishDate)); 
	            pst.setString(4, link);
	            int count = pst.executeUpdate();

	            pst.close();
	            con.close();

	            if (count > 0) {
	                response.sendRedirect("S_notice.html");
	            } else {
	                response.sendRedirect("e_notice.html");
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	            response.sendRedirect("e_notice.html");
	        }
	    }
	}
