<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SushmithaMart - Login</title>

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

        .login-box {
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
            margin-bottom: 22px;
        }

        .roles {
            display: flex;
            gap: 8px;
            margin-bottom: 20px;
        }

        .roles label {
            flex: 1;
            text-align: center;
            padding: 10px 5px;
            border: 1px solid #ddd;
            border-radius: 10px;
            cursor: pointer;
            font-size: 13px;
            color: #555;
        }

        .roles input {
            display: none;
        }

        .roles label:has(input:checked) {
            background: #6c3bb8;
            color: white;
            border-color: #6c3bb8;
        }

        .input-box {
            margin-bottom: 17px;
        }

        .input-box label {
            display: block;
            margin-bottom: 7px;
            color: #444;
            font-size: 14px;
        }

        .input-box input {
            width: 100%;
            padding: 13px;
            border: 1px solid #ddd;
            border-radius: 11px;
            outline: none;
            font-size: 14px;
        }

        .input-box input:focus {
            border-color: #6c3bb8;
            box-shadow: 0 0 0 3px rgba(108, 59, 184, 0.1);
        }

        .login-btn {
            width: 100%;
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

        .login-btn:hover {
            background: #542596;
        }

        .register {
            text-align: center;
            margin-top: 22px;
            color: #777;
            font-size: 14px;
        }

        .register a {
            color: #6c3bb8;
            font-weight: bold;
            text-decoration: none;
        }
    </style>
</head>

<body>

    <div class="login-box">

        <div class="logo">SushmithaMart</div>

        <div class="tagline">
            Shop Smart. Live Better.
        </div>

        <h2>Welcome Back 👋</h2>

        <form action="login" method="post">

            <div class="roles">
                <label>
                    <input type="radio" name="role" value="BUYER" checked>
                    Buyer
                </label>

                <label>
                    <input type="radio" name="role" value="SELLER">
                    Seller
                </label>

                <label>
                    <input type="radio" name="role" value="ADMIN">
                    Admin
                </label>
            </div>

            <div class="input-box">
                <label>Email</label>
                <input type="email"
                       name="email"
                       placeholder="Enter your email"
                       required>
            </div>

            <div class="input-box">
                <label>Password</label>
                <input type="password"
                       name="password"
                       placeholder="Enter your password"
                       required>
            </div>

            <button type="submit" class="login-btn">
                Login
            </button>

        </form>

        <div class="register">
            Don't have an account?
            <a href="register.jsp">Create Account</a>
        </div>

    </div>

</body>
</html>