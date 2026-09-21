<%@ page import="com.sushmithamart.model.User" %>
<%@ page import="com.sushmithamart.util.DBConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    User admin = (User) session.getAttribute("user");

    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    if (!"ADMIN".equalsIgnoreCase(admin.getRole())) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SushmithaMart - User Management</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            color: #17233f;
        }

        .navbar {
            background: #16233f;
            color: white;
            padding: 16px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 25px;
            font-weight: bold;
        }

        .logo span {
            color: #e8a33d;
        }

        .back {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        .back:hover {
            color: #e8a33d;
        }

        .container {
            width: 92%;
            max-width: 1100px;
            margin: 45px auto;
        }

        .header {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            margin-bottom: 25px;
        }

        .header h1 {
            margin: 0 0 10px;
            color: #16233f;
        }

        .header p {
            margin: 0;
            color: #68738a;
        }

        .table-box {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 18px rgba(0,0,0,0.08);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #16233f;
            color: white;
            padding: 14px;
            text-align: left;
        }

        td {
            padding: 14px;
            border-bottom: 1px solid #e5e8ee;
        }

        tr:hover {
            background: #f8f9fc;
        }

        .role {
            font-weight: bold;
        }

        .buyer {
            color: #2563eb;
        }

        .seller {
            color: #d97706;
        }

        .admin {
            color: #7c3aed;
        }

        .empty {
            text-align: center;
            padding: 40px;
            color: #68738a;
        }

        @media (max-width: 700px) {

            .navbar {
                padding: 15px;
            }

            .container {
                width: 95%;
            }

        }

    </style>

</head>

<body>

<div class="navbar">

    <div class="logo">
        Sushmitha<span>Mart</span>
    </div>

    <a href="admin-dashboard.jsp" class="back">
        Back to Dashboard
    </a>

</div>


<div class="container">

    <div class="header">

        <h1>User Management</h1>

        <p>
            View all registered users of SushmithaMart.
        </p>

    </div>


    <div class="table-box">

        <table>

            <thead>

                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                </tr>

            </thead>

            <tbody>

<%
    boolean found = false;

    String sql =
        "SELECT id, name, email, role " +
        "FROM users " +
        "ORDER BY id DESC";

    try (
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()
    ) {

        while (rs.next()) {

            found = true;

            String role = rs.getString("role");
%>

                <tr>

                    <td>
                        <%= rs.getInt("id") %>
                    </td>

                    <td>
                        <%= rs.getString("name") %>
                    </td>

                    <td>
                        <%= rs.getString("email") %>
                    </td>

                    <td class="role
                        <%= role.equalsIgnoreCase("BUYER") ? "buyer" :
                            role.equalsIgnoreCase("SELLER") ? "seller" :
                            "admin" %>">

                        <%= role %>

                    </td>

                </tr>

<%
        }

        if (!found) {
%>

                <tr>
                    <td colspan="4" class="empty">
                        No users found.
                    </td>
                </tr>

<%
        }

    } catch (Exception e) {

        e.printStackTrace();
%>

                <tr>
                    <td colspan="4" class="empty">
                        Unable to load users.
                    </td>
                </tr>

<%
    }
%>

            </tbody>

        </table>

    </div>

</div>

</body>

</html>