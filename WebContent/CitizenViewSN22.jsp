<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="panchayat.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Government Schemes & Notices - DigiPanchayat</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --saffron: #FF9933;
            --green: #138808;
            --dark-green: #007B5E;
            --white: #ffffff;
            --shadow: 0 4px 16px rgba(0,0,0,0.1);
        }

        * {
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
        }

        body {
            background: linear-gradient(to right, var(--saffron), var(--white), var(--green));
            background-size: 300% 100%;
            animation: flagWave 15s ease infinite;
            padding: 40px 20px;
            min-height: 100vh;
        }

        @keyframes flagWave {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .container {
            background: var(--white);
            padding: 30px;
            border-radius: 16px;
            box-shadow: var(--shadow);
            max-width: 1000px;
            margin: auto;
        }

        h2 {
            color: var(--dark-green);
            margin-bottom: 20px;
            border-bottom: 2px solid #eee;
            padding-bottom: 5px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 40px;
        }

        th, td {
            padding: 12px;
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

            table, th, td {
                font-size: 14px;
            }

            h2 {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>

<div class="container">
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
        } catch (Exception e) {
        %>
            <tr>
                <td colspan="4" style="color:red; font-weight: bold;">Error: <%= e.getMessage() %></td>
            </tr>
        <%
        }
        %>
    </table>

    <a href="CitizenHome.html" class="btn-back">← Back to Home</a>
</div>

</body>
</html>
