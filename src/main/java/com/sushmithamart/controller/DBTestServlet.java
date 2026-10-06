package com.sushmithamart.controller;

import com.sushmithamart.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;

@WebServlet("/db-test")
public class DBTestServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (Connection con = DBConnection.getConnection()) {

            if (con != null && !con.isClosed()) {

                DatabaseMetaData metaData = con.getMetaData();

                String databaseName =
                        metaData.getDatabaseProductName();

                String databaseVersion =
                        metaData.getDatabaseProductVersion();

                String url =
                        metaData.getURL();

                response.getWriter().println("""
                    <!DOCTYPE html>
                    <html>
                    <head>
                        <meta charset="UTF-8">
                        <title>SushmithaMart - Database</title>

                        <style>
                            body {
                                font-family: Arial, sans-serif;
                                background: #f5f7fb;
                                padding: 50px;
                                color: #17233f;
                            }

                            .box {
                                max-width: 700px;
                                margin: auto;
                                background: white;
                                padding: 35px;
                                border-radius: 15px;
                                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                            }

                            h1 {
                                color: #16833b;
                            }

                            .success {
                                background: #e8f7ed;
                                padding: 15px;
                                border-radius: 8px;
                                color: #16833b;
                                font-weight: bold;
                            }

                            .row {
                                padding: 12px 0;
                                border-bottom: 1px solid #ddd;
                            }

                            .label {
                                font-weight: bold;
                            }
                        </style>
                    </head>

                    <body>

                    <div class="box">

                        <h1>Database Connected Successfully</h1>

                        <div class="success">
                            MySQL Connection: SUCCESS
                        </div>

                        <div class="row">
                            <span class="label">Database:</span>
                            SushmithaMart
                        </div>

                        <div class="row">
                            <span class="label">Database Type:</span>
                            %s
                        </div>

                        <div class="row">
                            <span class="label">Database Version:</span>
                            %s
                        </div>

                        <div class="row">
                            <span class="label">Connection URL:</span>
                            %s
                        </div>

                    </div>

                    </body>
                    </html>
                    """.formatted(
                        databaseName,
                        databaseVersion,
                        url
                ));

            } else {

                response.getWriter().println("""
                    <h1>Database Connection Failed</h1>
                    <p>Connection is null or closed.</p>
                    """);
            }

        } catch (Exception e) {

            response.getWriter().println("""
                <html>
                <body>
                    <h1>Database Connection Failed</h1>
                    <pre>%s</pre>
                </body>
                </html>
                """.formatted(e.getMessage()));
        }
    }
}