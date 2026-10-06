<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SushmithaMart - Reset Password</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #f8f1ff, #eee4ff, #ffffff);
        }

        .reset-box {
            width: 390px;
            padding: 40px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 24px;
            box-shadow: 0 15px 45px rgba(80, 40, 120, 0.18);
        }

        .logo {
            text-align: center;
            font-size: 30px;
            font-weight: bold;
            color: #6c3bb8;
            margin-bottom: 8px;
        }

        .tagline {
            text-align: center;
            color: #777;
            font-size: 14px;
            margin-bottom: 28px;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 25px;
        }

        .input-box {
            margin-bottom: 18px;
        }

        .input-box label {
            display: block;
            margin-bottom: 7px;
            color: #444;
            font-size: 14px;
        }

        .input-box input {
            width: 100%;
            height: 46px;
            padding: 13px;
            border: 1px solid #ddd;
            border-radius: 11px;
            outline: none;
            font-size: 14px;
            background: white;
        }

        .input-box input:focus {
            border-color: #6c3bb8;
            box-shadow: 0 0 0 3px rgba(108, 59, 184, 0.1);
        }

        .reset-btn {
            width: 100%;
            height: 48px;
            padding: 14px;
            border: none;
            border-radius: 12px;
            background: #6c3bb8;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 5px;
        }

        .reset-btn:hover {
            background: #542596;
        }

        .back-login {
            text-align: center;
            margin-top: 22px;
            font-size: 14px;
        }

        .back-login a {
            color: #6c3bb8;
            font-weight: bold;
            text-decoration: none;
        }

        .back-login a:hover {
            text-decoration: underline;
        }

        @media (max-width: 500px) {

            .reset-box {
                width: 92%;
                padding: 30px 22px;
            }

            .logo {
                font-size: 27px;
            }

        }

    </style>

</head>

<body>

<div class="reset-box">

    <div class="logo">
        SushmithaMart
    </div>

    <div class="tagline">
        Shop Smart. Live Better.
    </div>

    <h2>Reset Password</h2>

    <form action="reset-password" method="post">

        <div class="input-box">

            <label>New Password</label>

            <input
                type="password"
                name="newPassword"
                placeholder="Enter new password"
                required>

        </div>

        <div class="input-box">

            <label>Confirm Password</label>

            <input
                type="password"
                name="confirmPassword"
                placeholder="Confirm new password"
                required>

        </div>

        <button
            type="submit"
            class="reset-btn">

            Reset Password

        </button>

    </form>

    <div class="back-login">

        <a href="login.jsp">
            Back to Login
        </a>

    </div>

</div>

</body>

</html>