<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="panchayat.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Schemes & Notices - Officer | DigiPanchayat</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --saffron: #FF9933;
            --green: #138808;
            --dark-green: #007B5E;
            --white: #ffffff;
        }

        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 40px 20px;
            background: linear-gradient(to right, var(--saffron), var(--white), var(--green));
            background-size: 300% 100%;
            animation: flagWave 12s ease infinite;
            min-height: 100vh;
        }

        @keyframes flagWave {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        h2 {
            color: var(--dark-green);
            text-align: center;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--white);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            margin-bottom: 40px;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ccc;
            text-align: center;
            font-size: 14px;
        }

        th {
            background-color: var(--dark-green);
            color: white;
        }

        .back-btn {
            display: block;
            width: fit-content;
            margin: auto;
            background-color: var(--dark-green);
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            text-decoration: none;
            text-align: center;
        }

        .back-btn:hover {
            background-color: #005c44;
        }

        @media (max-width: 768px) {
            th, td {
                font-size: 12px;
                padding: 10px;
            }

            .back-btn {
                width: 100%;
                margin-top: 20px;
            }
        }
    </style>
</head>
<body>

<h2>Government Schemes</h2>
<table>
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Description</th>
        <th>Launch Date</th>
        <th>Official Link</th>
    </tr>
<%
    try {
        Connection con = DBConnection.connect();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM schemes");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("title") %></td>
        <td><%= rs.getString("description") %></td>
        <td><%= rs.getDate("launchDate") %></td>
        <td><%=rs.getString("link") %></td>
    </tr>
<%
        }
        rs.close();
        ps.close();
%>
</table>

<h2>Published Notices</h2>
<table>
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Content</th>
        <th>Publish Date</th>
        <th>Official Link</th>
    </tr>
<%
        PreparedStatement ps2 = con.prepareStatement("SELECT * FROM notices");
        ResultSet rs2 = ps2.executeQuery();
        while (rs2.next()) {
%>
    <tr>
        <td><%= rs2.getInt("id") %></td>
        <td><%= rs2.getString("title") %></td>
        <td><%= rs2.getString("content") %></td>
        <td><%= rs2.getDate("publishDate") %></td>
        <td><%=rs2.getString("link") %></td>
    </tr>
<%
        }
        rs2.close();
        ps2.close();
        con.close();
    } catch (Exception e) {
%>
    <tr><td colspan="4" style="color:red;">Error: <%= e.getMessage() %></td></tr>
<%
    }
%>
</table>

<a href="OfficerHome33.html" class="back-btn">← Back to Dashboard</a>

</body>
</html>
