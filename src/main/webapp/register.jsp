<!DOCTYPE html>
<html>
<head>
    <title>SushmithaMart - Register</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #16002b, #4b1678, #7b2cbf);
        }

        .register-container {
            width: 420px;
            background: white;
            padding: 40px;
            border-radius: 22px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }

        .logo {
            text-align: center;
            font-size: 30px;
            font-weight: bold;
            color: #5b1a91;
            margin-bottom: 8px;
        }

        .tagline {
            text-align: center;
            color: #777;
            margin-bottom: 30px;
        }

        h2 {
            text-align: center;
            color: #222;
            margin-bottom: 25px;
        }

        .input-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
            color: #444;
        }

        input,
        select {
            width: 100%;
            padding: 13px;
            border: 1px solid #ddd;
            border-radius: 10px;
            font-size: 15px;
            outline: none;
        }

        input:focus,
        select:focus {
            border-color: #7b2cbf;
        }

        button {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 8px;
        }

        button:hover {
            opacity: 0.9;
        }

        .login-link {
            text-align: center;
            margin-top: 22px;
            color: #666;
        }

        .login-link a {
            color: #6a11cb;
            font-weight: bold;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="register-container">

    <div class="logo">🛍️ SushmithaMart</div>

    <div class="tagline">
        Shop Smart. Live Better.
    </div>

    <h2>Create Your Account</h2>

    <form action="register" method="post">

        <div class="input-group">
            <label>Name</label>
            <input type="text"
                   name="name"
                   placeholder="Enter your name"
                   required>
        </div>

        <div class="input-group">
            <label>Email</label>
            <input type="email"
                   name="email"
                   placeholder="Enter your email"
                   required>
        </div>

        <div class="input-group">
            <label>Password</label>
            <input type="password"
                   name="password"
                   placeholder="Create a password"
                   required>
        </div>

        <div class="input-group">
            <label>Account Type</label>

            <select name="role" required>
                <option value="">Select Account Type</option>
                <option value="BUYER">Buyer</option>
                <option value="SELLER">Seller</option>
            </select>
        </div>

        <button type="submit">
            Create Account
        </button>

    </form>

    <div class="login-link">
        Already have an account?
        <a href="login.jsp">Login</a>
    </div>

</div>

</body>
</html>