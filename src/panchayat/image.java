package panchayat;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class image extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Connection conn = DBConnection.connect();
            PreparedStatement stmt = conn.prepareStatement("SELECT image_path FROM complaints WHERE id=?");
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Blob blob = rs.getBlob("image_path");
                if (blob != null) {
                    byte[] imageBytes = blob.getBytes(1, (int) blob.length());
                    response.setContentType("image/jpeg/png");
                    OutputStream out = response.getOutputStream();
                    out.write(imageBytes);
                    out.close();
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
