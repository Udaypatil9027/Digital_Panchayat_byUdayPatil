<%@ page import="java.sql.*" %>
<%@ page import="panchayat.DBConnection" %>
<%@ page import="panchayat.GetSet" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String email = GetSet.getEmail();
    if (email == null || email.equals("")) {
        response.sendRedirect("OfficerLogin33.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Complaints - Officer | DigiPanchayat</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --saffron: #FF9933;
            --green: #138808;
            --dark-green: #007B5E;
            --danger: #dc3545;
            --white: #ffffff;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, var(--saffron), var(--white), var(--green));
            background-size: 300% 100%;
            animation: flagWave 12s ease infinite;
            padding: 40px 20px;
            min-height: 100vh;
        }

        @keyframes flagWave {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        h2 {
            text-align: center;
            color: var(--dark-green);
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--white);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            font-size: 14px;
            text-align: center;
        }

        th {
            background-color: var(--dark-green);
            color: white;
        }

        select, input[type="submit"] {
            padding: 6px 10px;
            font-size: 14px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            background-color: var(--dark-green);
            color: white;
            border: none;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #005c44;
        }

        .btn-back {
            margin-top: 30px;
            display: inline-block;
            background-color: var(--dark-green);
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-size: 15px;
            text-align: center;
        }

        .btn-back:hover {
            background-color: #005c44;
        }

        @media (max-width: 768px) {
            table, th, td {
                font-size: 13px;
            }

            select, input[type="submit"] {
                width: 100%;
                margin-top: 5px;
            }
        }
    </style>
</head>
<body>

<h2>All Complaints - Logged in as: <%= email %></h2>

<table>
    <tr>
        <th>ID</th>
        <th>Citizen Email</th>
        <th>Complaint Text</th>
        <th>Date</th>
        <th>Status</th>
        <th>Image</th>
        <th>Update</th>
    </tr>

<%
    try {
        Connection con = DBConnection.connect();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM complaints ORDER BY id DESC");
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            int id = rs.getInt("id");
            String citizenid = rs.getString("citizenid");
            String complainText = rs.getString("complainText");
            String date = rs.getString("date");
            String status = rs.getString("status");
            Blob imgBlob = rs.getBlob("image_path");
%>
    <tr>
        <td><%= id %></td>
        <td><%= citizenid %></td>
        <td><%= complainText %></td>
        <td><%= date %></td>
        <td><%= status %></td>
        <td>
            <%
                if (imgBlob != null && imgBlob.length() > 0) {
            %>
                <img src="image?id=<%= id %>" width="400" height="320" style="object-fit: cover; border-radius: 6px;" />
            <%
                } else {
            %>
                No Image
            <%
                }
            %>
        </td>
        <td>
            <form action="StatusOfficer" method="post">
                <input type="hidden" name="id" value="<%= id %>">
                <select name="status" required>
                    <option value="Pending" <%= "Pending".equals(status) ? "selected" : "" %>>Pending</option>
                    <option value="Review" <%= "Review".equals(status) ? "selected" : "" %>>Review</option>
                    <option value="Approved" <%= "Approved".equals(status) ? "selected" : "" %>>Approved</option>
                </select>
                <input type="submit" value="Update">
            </form>
        </td>
    </tr>
<%
        }
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
%>
    <tr>
        <td colspan="7" style="color: red;">Error: <%= e.getMessage() %></td>
    </tr>
<%
    }
%>
</table>

<div style="text-align: center;">
    <a href="OfficerHome33.html" class="btn-back">← Back to Dashboard</a>
</div>

</body>
</html>
