<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="panchayat.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Schemes & Notices - DigiPanchayat</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --saffron: #FF9933;
            --green: #138808;
            --dark-green: #007B5E;
            --white: #ffffff;
            --shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
        }
        body {
            background: linear-gradient(135deg, rgba(255,153,51,0.05), rgba(255,255,255,0.2), rgba(19,136,8,0.05));
            padding: 40px 20px;
        }
        h2 {
            text-align: center;
            color: var(--dark-green);
            margin: 30px 0 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 40px;
            background-color: var(--white);
            box-shadow: var(--shadow);
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
        }
        th {
            background-color: var(--dark-green);
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .action-form {
            display: inline;
        }
        .delete-btn {
            background-color: #dc3545;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .delete-btn:hover {
            background-color: #c82333;
        }
        .back-btn {
            display: block;
            margin: 30px auto;
            padding: 12px 30px;
            background-color: var(--dark-green);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            transition: background-color 0.3s ease;
        }
        .back-btn:hover {
            background-color: #005c44;
        }
        a.view-link {
            color: var(--dark-green);
            text-decoration: underline;
            font-weight: 500;
        }
        @media (max-width: 768px) {
            table, th, td {
                font-size: 14px;
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
            <th>Link</th>
            <th>Action</th>
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
            <td>
                <%
                    String link = rs.getString("link");
                    if (link != null && !link.trim().isEmpty()) {
                %>
                    <a class="view-link" href="<%= link %>" target="_blank">View</a>
                <%
                    } else {
                        out.print("N/A");
                    }
                %>
            </td>
            <td>
                <form class="action-form" action="AdminDeleteScheme11" method="post" onsubmit="return confirm('Are you sure you want to delete this scheme?');">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <input type="submit" class="delete-btn" value="Delete">
                </form>
            </td>
        </tr>
        <%
            }
            rs.close(); ps.close();
        %>
    </table>

    <h2>Published Notices</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Content</th>
            <th>Publish Date</th>
            <th>Link</th>
            <th>Action</th>
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
            <td>
                <%
                    String noticeLink = rs2.getString("link");
                    if (noticeLink != null && !noticeLink.trim().isEmpty()) {
                %>
                    <a class="view-link" href="<%= noticeLink %>" target="_blank">View</a>
                <%
                    } else {
                        out.print("N/A");
                    }
                %>
            </td>
            <td>
                <form class="action-form" action="AdminDeleteNotice11" method="post" onsubmit="return confirm('Are you sure you want to delete this notice?');">
                    <input type="hidden" name="id" value="<%= rs2.getInt("id") %>">
                    <input type="submit" class="delete-btn" value="Delete">
                </form>
            </td>
        </tr>
        <%
            }
            rs2.close(); ps2.close(); con.close();
        } catch (Exception e) {
        %>
        <tr><td colspan="6" style="color:red;text-align:center;">Error: <%= e.getMessage() %></td></tr>
        <% } %>
    </table>

    <a href="AdminHome11.html" class="back-btn">← Back to Dashboard</a>

</body>
</html>
