package com.sushmithamart.util;

import java.sql.Connection;

public class DBTest {

    public static void main(String[] args) {

        try (Connection con = DBConnection.getConnection()) {

            if (con != null && !con.isClosed()) {
                System.out.println("================================");
                System.out.println("DATABASE CONNECTION SUCCESSFUL");
                System.out.println("Database: sushmithamart");
                System.out.println("MySQL: CONNECTED");
                System.out.println("================================");
            } else {
                System.out.println("DATABASE CONNECTION FAILED");
            }

        } catch (Exception e) {
            System.out.println("DATABASE CONNECTION FAILED");
            e.printStackTrace();
        }
    }
}