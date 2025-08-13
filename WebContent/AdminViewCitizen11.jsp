<%@ page import="java.sql.*" %>
<%@ page import="panchayat.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Citizens - DigiPanchayat</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --saffron: #FF9933;
            --white: #FFFFFF;
            --green: #138808;
            --dark-green: #007B5E;
            --shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: linear-gradient(135deg, rgba(255, 153, 51, 0.05), rgba(255, 255, 255, 0.2), rgba(19, 136, 8, 0.05));
            min-height: 100vh;
            padding: 40px 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: var(--white);
            border-radius: 16px;
            box-shadow: var(--shadow);
            padding: 30px;
            position: relative;
            overflow: hidden;
        }

        .container::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 6px;
            background: linear-gradient(to right, var(--saffron), var(--green));
        }

        h2 {
            color: var(--dark-green);
            font-size: 28px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: 600;
        }

        .search-form {
            text-align: center;
            margin-bottom: 25px;
        }

        .search-form input[type="text"] {
            padding: 10px 15px;
            width: 300px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
            margin-right: 10px;
        }

        .search-form input[type="submit"] {
            padding: 10px 25px;
            background-color: var(--dark-green);
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }

        .search-form input[type="submit"]:hover {
            background-color: #005c44;
        }

        .citizens-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            overflow-x: auto;
        }

        .citizens-table th {
            background-color: var(--dark-green);
            color: white;
            padding: 12px 15px;
            text-align: left;
        }

        .citizens-table td {
            padding: 10px 15px;
            border-bottom: 1px solid #eee;
        }

        .citizens-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .citizens-table tr:hover {
            background-color: #f1f1f1;
        }

        .btn {
            display: inline-block;
            padding: 12px 30px;
            background-color: var(--dark-green);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            text-align: center;
        }

        .btn:hover {
            background-color: #005c44;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 123, 94, 0.2);
        }

        .action-buttons {
            text-align: center;
            margin-top: 30px;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px 15px;
            }

            h2 {
                font-size: 24px;
            }

            .citizens-table {
                display: block;
                overflow-x: auto;
            }

            .search-form input[type="text"] {
                width: 90%;
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Registered Citizens</h2>

        <!-- Search Form -->
        <form method="get" class="search-form">
            <input type="text" name="search" placeholder="Search by name" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
            <input type="submit" value="Search">
        </form>

        <table class="citizens-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Address</th>
                    <th>Contact</th>
                    <th>Email</th>
                </tr>
            </thead>
            <tbody>
            <%
            try {
                Connection con = DBConnection.connect();
                String search = request.getParameter("search");
                PreparedStatement pt;

                if (search != null && !search.trim().equals("")) {
                    pt = con.prepareStatement("SELECT * FROM citizen WHERE name LIKE ?");
                    pt.setString(1, "%" + search + "%");
                } else {
                    pt = con.prepareStatement("SELECT * FROM citizen");
                }

                ResultSet rs = pt.executeQuery();

                boolean found = false;
                while (rs.next()) {
                    found = true;
            %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("address") %></td>
                    <td><%= rs.getString("contact") %></td>
                    <td><%= rs.getString("email") %></td>
                </tr>
            <%
                }
                if (!found) {
                    out.println("<tr><td colspan='5' style='text-align:center;color:#777;'>No citizens found.</td></tr>");
                }

                con.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='5' style='color:red;text-align:center;'>Error loading citizen data: " + e.getMessage() + "</td></tr>");
            }
            %>
            </tbody>
        </table>

        <div class="action-buttons">
            <a href="AdminHome11.html" class="btn">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
