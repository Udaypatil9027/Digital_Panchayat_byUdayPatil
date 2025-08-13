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
    <title>Submit Complaint - DigiPanchayat</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --saffron: #FF9933;
            --green: #138808;
            --dark-green: #007B5E;
            --danger: #dc3545;
            --shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        * {
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: linear-gradient(135deg, rgba(255, 153, 51, 0.05), rgba(255, 255, 255, 0.2), rgba(19, 136, 8, 0.05));
            margin: 0;
            padding: 40px 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .form-card {
            background-color: white;
            max-width: 600px;
            width: 100%;
            padding: 40px;
            border-radius: 16px;
            box-shadow: var(--shadow);
            position: relative;
        }

        .form-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            height: 6px;
            width: 100%;
            background: linear-gradient(to right, var(--saffron), var(--green));
        }

        h2, h3 {
            text-align: center;
            color: var(--dark-green);
        }

        .form-group {
            margin: 20px 0;
        }

        label {
            display: block;
            font-weight: 500;
            margin-bottom: 6px;
            color: #444;
        }

        textarea,
        input[type="date"] {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            resize: vertical;
            transition: 0.3s ease;
        }

        textarea:focus,
        input[type="date"]:focus {
            border-color: var(--dark-green);
            box-shadow: 0 0 0 3px rgba(0, 123, 94, 0.1);
            outline: none;
        }

        .btn-submit {
            width: 100%;
            padding: 14px;
            background-color: var(--dark-green);
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            background-color: #005c44;
            transform: translateY(-1px);
        }

        .home-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #555;
            text-decoration: none;
        }

        .home-link:hover {
            text-decoration: underline;
        }

        @media (max-width: 600px) {
            .form-card {
                padding: 25px 20px;
            }
        }
    </style>
</head>
<body>

<div class="form-card">
    <h2>Welcome, <%= email %></h2>
    <h3>Submit Your Complaint</h3>

    <form action="Citi_comp" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="complainText">Complaint:</label>
            <textarea name="complainText" id="complainText" rows="5" required></textarea>
        </div>

        <div class="form-group">
            <label for="date">Date:</label>
            <input type="date" name="date" id="date" required>
        </div>

        <div class="form-group">
            <label for="photo">Upload Image (optional):</label>
            <input type="file" name="photo" id="photo" accept="image/*">
        </div>
		
        <button type="submit" class="btn-submit">Submit Complaint</button>
      <a href="CitizenHome.html" class="home-link">← Back to Home</a>
    
    
    </form>
</div>

</body>
</html>
