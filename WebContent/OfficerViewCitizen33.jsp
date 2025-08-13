<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="panchayat.DBConnection" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Citizens - DigiPanchayat</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --saffron: #FF9933;
            --green: #138808;
            --dark-green: #007B5E;
            --white: #ffffff;
            --danger: #dc3545;
        }

        body {
            background: linear-gradient(to right, var(--saffron), var(--white), var(--green));
            background-size: 300% 100%;
            animation: flagWave 12s ease infinite;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 40px 20px;
        }

        @keyframes flagWave {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        h1 {
            text-align: center;
            color: var(--dark-green);
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--white);
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
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

        form {
            margin: 0;
        }

        .delete-btn {
            background-color: var(--danger);
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
        }

        .delete-btn:hover {
            background-color: #b02a37;
        }

        .home-btn {
            margin-top: 30px;
            display: inline-block;
            background-color: var(--dark-green);
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-size: 15px;
            cursor: pointer;
        }

        .home-btn:hover {
            background-color: #005c44;
        }

        @media (max-width: 768px) {
            table, th, td {
                font-size: 13px;
            }

            .home-btn {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>

<h1>Citizen Records</h1>

<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Address</th>
        <th>Contact</th>
        <th>Email</th>
        <th>Action</th>
    </tr>
<%
    try {
        Connection con = DBConnection.connect();
        PreparedStatement pt1 = con.prepareStatement("SELECT * FROM citizen");
        ResultSet rs1 = pt1.executeQuery();
        while (rs1.next()) {
%>
    <tr>
        <td><%= rs1.getInt("id") %></td>
        <td><%= rs1.getString("name") %></td>
        <td><%= rs1.getString("address") %></td>
        <td><%= rs1.getString("contact") %></td>
        <td><%= rs1.getString("email") %></td>
        <td>
            <form action="OfficerDeleteCitizen33" method="post">
                <input type="hidden" name="id" value="<%= rs1.getInt("id") %>">
                <input type="submit" class="delete-btn" value="Delete">
            </form>
        </td>
    </tr>
<%
        }
        rs1.close();
        pt1.close();
        con.close();
    } catch (Exception e) {
%>
    <tr>
        <td colspan="6" style="color: red;">Error fetching records: <%= e.getMessage() %></td>
    </tr>
<%
    }
%>
</table>

<div style="text-align: center;">
    <a href="OfficerHome33.html" class="home-btn">← Back to Dashboard</a>
</div>

</body>
</html>
