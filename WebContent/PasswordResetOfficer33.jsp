<%@ page import="panchayat.GetSet" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String email = GetSet.getEmail();
    if (email == null || email.equals("")) {
        response.sendRedirect("OfficerLogin33.html");
        return;
    }
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset Password - Officer | DigiPanchayat</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --dark-green: #007B5E;
            --danger: #dc3545;
            --saffron: #FF9933;
            --green: #138808;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, var(--saffron), var(--white), var(--green));
            background-size: 300% 100%;
            animation: flagWave 12s ease infinite;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
            min-height: 100vh;
        }

        @keyframes flagWave {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .card {
            background: white;
            padding: 30px 40px;
            border-radius: 16px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            max-width: 450px;
            width: 100%;
        }

        h2 {
            margin-bottom: 20px;
            color: var(--dark-green);
            text-align: center;
            font-size: 22px;
        }

        label {
            font-weight: 500;
        }

        input[type="password"],
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            margin-bottom: 20px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        input[type="submit"] {
            background-color: var(--dark-green);
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #005c44;
        }

        .error-msg {
            color: var(--danger);
            font-size: 14px;
            text-align: center;
            margin-bottom: 15px;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 10px;
            text-decoration: none;
            color: #333;
            font-weight: 500;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        @media (max-width: 480px) {
            .card {
                padding: 25px 20px;
            }
        }
    </style>
</head>
<body>

<div class="card">
    <h2>Reset Password for <%= email %></h2>

    <% if ("invalid".equals(error)) { %>
        <div class="error-msg">Old password is incorrect.</div>
    <% } else if ("exception".equals(error)) { %>
        <div class="error-msg">Something went wrong. Please try again.</div>
    <% } %>

    <form action="ResetPasswordOfficer33" method="post">
        <label for="oldPassword">Old Password:</label>
        <input type="password" name="oldPassword" id="oldPassword" required>

        <label for="newPassword">New Password:</label>
        <input type="password" name="newPassword" id="newPassword" required>

        <input type="submit" value="Change Password">
    </form>

    <a href="OfficerHome33.html" class="back-link">← Back to Dashboard</a>
</div>

</body>
</html>
