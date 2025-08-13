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
    <title>Officer Reset Password - DigiPanchayat</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --saffron: #FF9933;
            --green: #138808;
            --dark-green: #007B5E;
            --white: #fff;
            --danger: #dc3545;
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
            animation: flagWave 12s ease infinite;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        @keyframes flagWave {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .container {
            background: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: var(--shadow);
            max-width: 500px;
            width: 100%;
        }

        h2 {
            color: var(--dark-green);
            margin-bottom: 20px;
            font-size: 22px;
        }

        label {
            font-weight: 600;
            display: block;
            margin-top: 15px;
        }

        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        input[type="submit"] {
            background-color: var(--dark-green);
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            margin-top: 20px;
            width: 100%;
            cursor: pointer;
            transition: 0.3s ease;
            font-size: 16px;
        }

        input[type="submit"]:hover {
            background-color: #005c44;
        }

        .error {
            margin-top: 20px;
            color: var(--danger);
            font-weight: 500;
        }

        .back-link {
            display: block;
            margin-top: 25px;
            text-align: center;
            color: var(--dark-green);
            text-decoration: none;
            font-weight: 500;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        @media (max-width: 600px) {
            .container {
                padding: 30px 20px;
            }

            h2 {
                font-size: 20px;
            }

            input[type="submit"] {
                font-size: 15px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Reset Password for <%= email %></h2>

        <form action="ResetPassword22" method="post">
            <label>Old Password:</label>
            <input type="password" name="oldPassword" required>

            <label>New Password:</label>
            <input type="password" name="newPassword" required>

            <input type="submit" value="Change Password">
        </form>

        <a href="CitizenHome.html" class="back-link">← Back to Home</a>

        <% String error = request.getParameter("error");
           if ("invalid".equals(error)) { %>
            <div class="error">❌ Old password is incorrect.</div>
        <% } else if ("exception".equals(error)) { %>
            <div class="error">⚠️ Something went wrong. Please try again.</div>
        <% } %>
    </div>

</body>
</html>
