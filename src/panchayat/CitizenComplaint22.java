package panchayat;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig(maxFileSize = 16177215) // 16MB max file size
public class CitizenComplaint22 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("citizenEmail") == null) {
            response.sendRedirect("CitizenLogin22.html");
            return;
        }
        
        String citizenEmail = (String) session.getAttribute("citizenEmail");
        String complaintText = request.getParameter("complainText");
        String status = "Pending";
        String reportDate = LocalDate.now().toString();
        
        Part filePart = request.getPart("image");
        InputStream inputStream = null;
        
        if (filePart != null && filePart.getSize() > 0) {
            inputStream = filePart.getInputStream();
        }
        
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = DBConnection.connect();
            
            String sql = "INSERT INTO complaints (citizenid, complainText, date, status, image_path) VALUES (?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            
            ps.setString(1, citizenEmail);
            ps.setString(2, complaintText);
            ps.setString(3, reportDate);
            ps.setString(4, status);
            
            if (inputStream != null) {
                ps.setBlob(5, inputStream);
            } else {
                ps.setNull(5, java.sql.Types.BLOB);
            }
            
            int row = ps.executeUpdate();
            
            if (row > 0) {
                response.sendRedirect("ViewComplaints.jsp"); // Redirect to view page after successful submission
            } else {
                response.sendRedirect("ComplaintError.html");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("ComplaintError.html");
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
                if (inputStream != null) inputStream.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("CitizenComplaintForm.html"); // Redirect to complaint form for GET requests
    }
}