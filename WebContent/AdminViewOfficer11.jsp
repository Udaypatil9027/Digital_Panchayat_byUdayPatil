<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="panchayat.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Officers - DigiPanchayat</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

    <style>
        :root {
            --saffron: #FF9933;
            --white: #FFFFFF;
            --green: #138808;
            --dark-green: #007B5E;
            --danger: #dc3545;
            --shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        body {
            background: linear-gradient(135deg, rgba(255,153,51,0.08), rgba(255,255,255,0.2), rgba(19,136,8,0.08));
            min-height: 100vh;
            padding: 40px 20px;
        }
        .container {
            max-width: 1200px;
            margin: auto;
            background: var(--white);
            border-radius: 16px;
            box-shadow: var(--shadow);
            padding: 30px;
            position: relative;
        }
        .container::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            height: 6px;
            width: 100%;
            background: linear-gradient(to right, var(--saffron), var(--green));
        }
        h2 {
            color: var(--dark-green);
            font-size: 28px;
            margin-bottom: 25px;
            text-align: center;
        }
        .search-box {
            text-align: center;
            margin-bottom: 25px;
        }
        .search-box input {
            width: 100%;
            max-width: 400px;
            padding: 10px 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
        }
        .search-box button {
            padding: 10px 20px;
            background-color: var(--dark-green);
            color: white;
            border: none;
            border-radius: 8px;
            margin-left: 10px;
            cursor: pointer;
        }
        .record-count {
            font-weight: 500;
            margin-bottom: 15px;
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
        }
        thead th {
            background-color: var(--dark-green);
            color: white;
        }
        tbody td {
            border-bottom: 1px solid #eee;
        }
        tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tbody tr:hover {
            background-color: #f1f1f1;
        }
        .btn {
            display: inline-block;
            margin-top: 30px;
            padding: 12px 30px;
            font-size: 16px;
            background-color: var(--dark-green);
            color: white;
            border: none;
            border-radius: 8px;
            text-decoration: none;
        }
        .delete-btn {
            background-color: var(--danger);
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
        }
        @media (max-width: 768px) {
            h2 {
                font-size: 22px;
            }
            .search-box input {
                width: 90%;
            }
        }
    </style>
</head>
<body>

<%
    int rowCount = 0;
    String errorMessage = null;
    String searchQuery = request.getParameter("search");
%>

<div class="container">
    <h2>Registered Officers</h2>

    <div class="search-box">
        <form method="get">
            <input type="text" name="search" value="<%= (searchQuery != null) ? searchQuery : "" %>" placeholder="🔍 Search by name, email, contact..." />
            <button type="submit">Search</button>
        </form>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Designation</th>
                <th>Contact</th>
                <th>Email</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <%
            try {
                Connection con = DBConnection.connect();
                PreparedStatement ps;
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    String sql = "SELECT * FROM officer WHERE name LIKE ? OR email LIKE ? OR contact LIKE ?";
                    ps = con.prepareStatement(sql);
                    String keyword = "%" + searchQuery.trim() + "%";
                    ps.setString(1, keyword);
                    ps.setString(2, keyword);
                    ps.setString(3, keyword);
                } else {
                    ps = con.prepareStatement("SELECT * FROM officer");
                }

                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    rowCount++;
        %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("designation") %></td>
                <td><%= rs.getString("contact") %></td>
                <td><%= rs.getString("email") %></td>
                <td>
                    <form action="DeleteOfficer11" method="post" onsubmit="return confirm('Are you sure you want to delete this officer?');">
                        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                        <button type="submit" class="delete-btn">Delete</button>
                    </form>
                </td>
            </tr>
        <%
                }
                rs.close();
                ps.close();
                con.close();
            } catch (Exception e) {
                errorMessage = "Error loading officers: " + e.getMessage();
            }
        %>
        </tbody>
    </table>

    <div class="record-count">
        Total Records: <%= rowCount %>
    </div>

    <%
        if (errorMessage != null) {
    %>
        <p style="color: red; text-align: center; margin-top: 20px;"><%= errorMessage %></p>
    <%
        }
    %>

    <div style="text-align: center;">
        <a href="AdminHome11.html" class="btn">Back to Dashboard</a>
    </div>
</div>

</body>
</html>
