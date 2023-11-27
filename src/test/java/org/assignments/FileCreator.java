package org.assignments;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class FileCreator {
    public static void createJsonFile(List<Map<String, Object>> jsonData) throws IOException {
        Path filePath = Paths.get("files" + File.separator + "response.json");
        Files.createDirectories(filePath.getParent());
        if (Files.exists(filePath)) {
            Files.delete(filePath);
        }
        Files.createFile(filePath);
        Files.write(filePath, jsonData.toString().getBytes(), StandardOpenOption.CREATE);
    }

    public static void createCsvFile(List<Map<String, Object>> jsonData) throws IOException {
        StringBuilder csvContent = new StringBuilder();
        if (!jsonData.isEmpty()) {
            Map<String, Object> firstRow = jsonData.get(0);
            csvContent.append(firstRow.keySet().stream().collect(Collectors.joining(","))).append("\n");
        }
        for (Map<String, Object> dataRow : jsonData) {
            String row = dataRow.values().stream()
                    .map(value -> value.toString())
                    .collect(Collectors.joining(","));
            csvContent.append(row).append("\n");
        }

        byte[] bytes = csvContent.toString().getBytes();
        Path filePath = Paths.get("files" + File.separator + "response.csv");
        Files.createDirectories(filePath.getParent());
        if (Files.exists(filePath)) {
            Files.delete(filePath);
        }
        Files.createFile(filePath);
        Files.write(filePath, bytes, StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
    }

}
