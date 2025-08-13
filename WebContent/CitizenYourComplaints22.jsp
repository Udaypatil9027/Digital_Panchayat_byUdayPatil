<%@ page import="java.sql.*" %>
<%@ page import="panchayat.DBConnection" %>
<%@ page import="panchayat.CitizenBean" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String email = CitizenBean.getEmail();
    if (email == null || email.equals("")) {
        response.sendRedirect("CitizenLogin22.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Complaints - DigiPanchayat</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --saffron: #FF9933;
            --green: #138808;
            --dark-green: #007B5E;
            --white: #ffffff;
            --shadow: 0 4px 16px rgba(0,0,0,0.1);
            --danger: #dc3545;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: linear-gradient(to right, var(--saffron), var(--white), var(--green));
            background-size: 300% 100%;
            animation: flagWave 12s ease infinite;
            min-height: 100vh;
            padding: 40px 20px;
        }

        @keyframes flagWave {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .container {
            background-color: white;
            padding: 30px;
            max-width: 1000px;
            margin: auto;
            border-radius: 16px;
            box-shadow: var(--shadow);
        }

        h2 {
            color: var(--dark-green);
            margin-bottom: 20px;
            font-size: 24px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        th, td {
            padding: 12px 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: var(--dark-green);
            color: white;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .btn-back {
            display: inline-block;
            padding: 10px 20px;
            background-color: var(--dark-green);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 15px;
            transition: 0.3s;
        }

        .btn-back:hover {
            background-color: #005c44;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            h2 {
                font-size: 20px;
            }

            table, th, td {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Your Complaints, <%= email %></h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Complaint Text</th>
            <th>Date</th>
            <th>Status</th>
            <th>Images</th>
        </tr>

        <%
            try {
                Connection con = DBConnection.connect();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM complaints WHERE citizenid = ?");
                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
        %>
       <tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("complainText") %></td>
    <td><%= rs.getString("date") %></td>
    <td><%= rs.getString("status") %></td>
    <td>
<%
    Blob blob = rs.getBlob("image_path");
    if (blob != null) {
%>
  <img src="image?id=<%= rs.getInt("id") %>" width="350" height="400">
<%
    } else {
%>
    No Image
<%
    }
%>
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
            <td colspan="4" style="color: var(--danger); font-weight: 500;">
                Error: <%= e.getMessage() %>
            </td>
        </tr>
        <%
            }
        %>
    </table>

    <a href="CitizenHome.html" class="btn-back">← Back to Home</a>
</div>

</body>
</html>
