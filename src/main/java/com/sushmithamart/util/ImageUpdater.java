package com.sushmithamart.util;

import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ImageUpdater {

    public static void main(String[] args) {

        HttpClient client = HttpClient.newBuilder()
                .followRedirects(HttpClient.Redirect.NORMAL)
                .build();

        String selectSql = "SELECT id, name FROM products";
        String updateSql = "UPDATE products SET image = ? WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement select = con.prepareStatement(selectSql);
             ResultSet rs = select.executeQuery();
             PreparedStatement update = con.prepareStatement(updateSql)) {

            while (rs.next()) {

                int id = rs.getInt("id");
                String name = rs.getString("name");

                String imageUrl = findImage(client, name);

                if (imageUrl != null) {

                    update.setString(1, imageUrl);
                    update.setInt(2, id);
                    update.executeUpdate();

                    System.out.println(
                            id + " - " + name + " - IMAGE FOUND"
                    );

                } else {

                    System.out.println(
                            id + " - " + name + " - IMAGE NOT FOUND"
                    );
                }

                Thread.sleep(500);
            }

            System.out.println("Image update completed.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static String findImage(HttpClient client, String productName) {

        String[] searches = {
                productName,
                productName + " product",
                productName + " item",
                productName.replace("Set", ""),
                productName.replace("Pack", ""),
                productName.replace("64GB", "")
        };

        for (String searchText : searches) {

            try {

                String encoded =
                        URLEncoder.encode(
                                searchText.trim(),
                                StandardCharsets.UTF_8
                        );

                String apiUrl =
                        "https://commons.wikimedia.org/w/api.php" +
                        "?action=query" +
                        "&generator=search" +
                        "&gsrsearch=" + encoded +
                        "&gsrnamespace=6" +
                        "&gsrlimit=5" +
                        "&prop=imageinfo" +
                        "&iiprop=url" +
                        "&iiurlwidth=600" +
                        "&format=json";

                HttpRequest request =
                        HttpRequest.newBuilder()
                                .uri(URI.create(apiUrl))
                                .header(
                                        "User-Agent",
                                        "SushmithaMart/1.0"
                                )
                                .GET()
                                .build();

                HttpResponse<String> response =
                        client.send(
                                request,
                                HttpResponse.BodyHandlers.ofString()
                        );

                String imageUrl =
                        extractThumbUrl(response.body());

                if (imageUrl != null &&
                        isValidImage(imageUrl)) {

                    return imageUrl;
                }

                Thread.sleep(200);

            } catch (Exception e) {
            }
        }

        return null;
    }

    private static String extractThumbUrl(String json) {

        String key = "\"thumburl\":\"";

        int start = json.indexOf(key);

        if (start == -1) {
            return null;
        }

        start += key.length();

        int end = json.indexOf("\"", start);

        if (end == -1) {
            return null;
        }

        return json.substring(start, end)
                .replace("\\/", "/")
                .replace("\\u0026", "&")
                .replace("\\\"", "\"");
    }

    private static boolean isValidImage(String url) {

        String lower = url.toLowerCase();

        return lower.contains(".jpg")
                || lower.contains(".jpeg")
                || lower.contains(".png")
                || lower.contains(".webp");
    }
}