package com.sushmithamart.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

@WebServlet("/product-image")
public class ProductImageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String IMAGE_DIR =
            "C:" + File.separator +
            "sushmithamart" + File.separator +
            "uploads" + File.separator +
            "products";

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String fileName = request.getParameter("file");

        if (fileName == null || fileName.trim().isEmpty()) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Image file name is missing."
            );
            return;
        }

        // Security: filename மட்டும் எடுத்துக்கொள்கிறது
        fileName = new File(fileName).getName();

        File imageFile = new File(IMAGE_DIR, fileName);

        if (!imageFile.exists() || !imageFile.isFile()) {
            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Image not found."
            );
            return;
        }

        String contentType =
                getServletContext().getMimeType(imageFile.getName());

        if (contentType == null) {
            contentType = "application/octet-stream";
        }

        response.setContentType(contentType);
        response.setContentLengthLong(imageFile.length());

        try (
            InputStream inputStream =
                    new FileInputStream(imageFile);

            OutputStream outputStream =
                    response.getOutputStream()
        ) {

            byte[] buffer = new byte[8192];
            int bytesRead;

            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        }
    }
}