<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

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

        .error-message {
            background: #ffe8e8;
            color: #c62828;
            border: 1px solid #f5b5b5;
            padding: 10px;
            border-radius: 10px;
            text-align: center;
            font-size: 14px;
            margin-bottom: 18px;
        }

        .success-message {
            background: #e8f8ed;
            color: #218838;
            border: 1px solid #a8dfb8;
            padding: 10px;
            border-radius: 10px;
            text-align: center;
            font-size: 14px;
            margin-bottom: 18px;
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

        .input-box > input {
            width: 100%;
            height: 46px;
            padding: 13px;
            border: 1px solid #ddd;
            border-radius: 11px;
            outline: none;
            font-size: 14px;
            display: block;
            background: white;
        }

        .input-box > input:focus {
            border-color: #6c3bb8;
            box-shadow: 0 0 0 3px rgba(108, 59, 184, 0.1);
        }

        .password-wrapper {
            position: relative;
            width: 100%;
        }

        .password-wrapper input {
            width: 100%;
            height: 46px;
            padding: 13px 45px 13px 13px;
            border: 1px solid #ddd;
            border-radius: 11px;
            outline: none;
            font-size: 14px;
            display: block;
            background: white;
        }

        .password-wrapper input:focus {
            border-color: #6c3bb8;
            box-shadow: 0 0 0 3px rgba(108, 59, 184, 0.1);
        }

        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            width: 30px;
            height: 30px;
            border: none;
            background: transparent;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #777;
        }

        .password-toggle:hover {
            color: #6c3bb8;
        }

        .eye-icon {
            width: 19px;
            height: 13px;
            border: 2px solid currentColor;
            border-radius: 50% / 65%;
            position: relative;
            display: block;
        }

        .eye-icon::after {
            content: "";
            position: absolute;
            width: 5px;
            height: 5px;
            border: 2px solid currentColor;
            border-radius: 50%;
            left: 5px;
            top: 2px;
        }

        .password-toggle.show .eye-icon {
            opacity: 0.45;
        }

        .login-btn {
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

        .login-btn:hover {
            background: #542596;
        }

        .forgot-password {
            text-align: right;
            margin-top: -8px;
            margin-bottom: 18px;
            font-size: 13px;
        }

        .forgot-password a {
            color: #6c3bb8;
            font-weight: bold;
            text-decoration: none;
        }

        .forgot-password a:hover {
            text-decoration: underline;
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

        .register a:hover {
            text-decoration: underline;
        }

        @media (max-width: 500px) {

            .login-box {
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

<div class="login-box">

    <div class="logo">
        SushmithaMart
    </div>

    <div class="tagline">
        Shop Smart. Live Better.
    </div>

    <h2>Welcome Back</h2>

    <%
        String error = request.getParameter("error");
        String success = request.getParameter("success");

        if (error != null && !error.isEmpty()) {
    %>

        <div class="error-message">
            <%= error %>
        </div>

    <%
        }

        if (success != null && !success.isEmpty()) {
    %>

        <div class="success-message">
            <%= success %>
        </div>

    <%
        }
    %>

    <form action="login" method="post">

        <div class="roles">

            <label>
                <input
                    type="radio"
                    name="role"
                    value="BUYER"
                    checked>
                Buyer
            </label>

            <label>
                <input
                    type="radio"
                    name="role"
                    value="SELLER">
                Seller
            </label>

            <label>
                <input
                    type="radio"
                    name="role"
                    value="ADMIN">
                Admin
            </label>

        </div>

        <div class="input-box">

            <label>Email</label>

            <input
                type="email"
                name="email"
                placeholder="Enter your email"
                required>

        </div>

        <div class="input-box">

            <label>Password</label>

            <div class="password-wrapper">

                <input
                    type="password"
                    name="password"
                    id="password"
                    placeholder="Enter your password"
                    required>

                <button
                    type="button"
                    class="password-toggle"
                    id="passwordToggle"
                    onclick="togglePassword()"
                    aria-label="Show password">

                    <span class="eye-icon"></span>

                </button>

            </div>

        </div>

        <div class="forgot-password">
            <a href="forgot-password.jsp">
                Forgot Password?
            </a>
        </div>

        <button
            type="submit"
            class="login-btn">

            Login

        </button>

    </form>

    <div class="register">

        Don't have an account?

        <a href="register.jsp">
            Create Account
        </a>

    </div>

</div>

<script>

function togglePassword() {

    const password =
        document.getElementById("password");

    const toggle =
        document.getElementById("passwordToggle");

    if (password.type === "password") {

        password.type = "text";

        toggle.classList.add("show");

        toggle.setAttribute(
            "aria-label",
            "Hide password"
        );

    } else {

        password.type = "password";

        toggle.classList.remove("show");

        toggle.setAttribute(
            "aria-label",
            "Show password"
        );

    }

}

</script>

</body>

</html>