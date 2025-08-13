package panchayat;

import java.io.InputStream;
import java.sql.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.*;
import javax.servlet.http.*;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

@MultipartConfig(maxFileSize = 16177215)  // 16MB
public class Citi_comp extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = CitizenBean.getEmail();
        String complaintText = request.getParameter("complainText");
        String date = request.getParameter("date");
        String status = "Pending";

        InputStream imageStream = null;
        byte[] imageBytes = null;

        try {
            Part filePart = request.getPart("photo");
            if (filePart != null && filePart.getSize() > 0) {
                imageStream = filePart.getInputStream();

                // Convert InputStream to byte array
                ByteArrayOutputStream buffer = new ByteArrayOutputStream();
                byte[] temp = new byte[4096];
                int bytesRead;
                while ((bytesRead = imageStream.read(temp)) != -1) {
                    buffer.write(temp, 0, bytesRead);
                }
                imageBytes = buffer.toByteArray();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            Connection con = DBConnection.connect();
            PreparedStatement pst = con.prepareStatement("INSERT INTO complaints VALUES (?, ?, ?, ?, ?, ?)");
            pst.setInt(1, 0);
            pst.setString(2, email);
            pst.setString(3, complaintText);
            pst.setString(4, date);
            pst.setString(5, status);
            if (imageBytes != null) {
                pst.setBytes(6, imageBytes);
            } else {
                pst.setNull(6, java.sql.Types.BLOB);
            }

            int result = pst.executeUpdate();
            pst.close();
            con.close();

            if (result > 0) {
                response.sendRedirect("S_complaint.html");
            } else {
                response.sendRedirect("CitizenComplaint22.jsp?error=fail");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("CitizenComplaint22.jsp?error=exception");
        }
    }
}