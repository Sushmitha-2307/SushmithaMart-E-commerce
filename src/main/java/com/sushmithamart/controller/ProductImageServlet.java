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
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@WebServlet("/product-image")
public class ProductImageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private String getImageDirectory() {
        String configuredPath = System.getenv("PRODUCT_UPLOAD_DIR");

        if (configuredPath != null && !configuredPath.trim().isEmpty()) {
            return configuredPath.trim();
        }

        if (System.getProperty("os.name").toLowerCase().contains("win")) {
            return "C:" + File.separator
                    + "sushmithamart" + File.separator
                    + "uploads" + File.separator
                    + "products";
        }

        return "/app/uploads/products";
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
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

        fileName = fileName.trim();

        // Accept only a filename, not a directory path.
        if (fileName.contains("/") || fileName.contains("\\")
                || fileName.equals(".") || fileName.equals("..")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        Path imageDirectory = Paths.get(getImageDirectory())
                .toAbsolutePath().normalize();

        Path imagePath = imageDirectory.resolve(fileName).normalize();

        if (!imagePath.startsWith(imageDirectory)
                || !Files.isRegularFile(imagePath)
                || !Files.isReadable(imagePath)) {
            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Image not found."
            );
            return;
        }

        File imageFile = imagePath.toFile();

        String contentType =
                getServletContext().getMimeType(imageFile.getName());

        if (contentType == null ||
                !contentType.startsWith("image/")) {
            response.sendError(
                    HttpServletResponse.SC_UNSUPPORTED_MEDIA_TYPE
            );
            return;
        }

        response.setContentType(contentType);
        response.setContentLengthLong(imageFile.length());
        response.setHeader("Cache-Control", "public, max-age=86400");
        response.setHeader("X-Content-Type-Options", "nosniff");

        try (
                InputStream inputStream = new FileInputStream(imageFile);
                OutputStream outputStream = response.getOutputStream()
        ) {
            byte[] buffer = new byte[8192];
            int bytesRead;

            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        }
    }
}