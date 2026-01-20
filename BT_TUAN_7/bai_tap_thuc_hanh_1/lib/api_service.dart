import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models.dart';

class ApiService {
  static const String baseUrl = 'https://amock.io/api/researchUTH';

  // Lấy danh sách
  static Future<List<Task>> fetchTasks() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tasks'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse is List) {
          return jsonResponse.map((e) => Task.fromJson(e)).toList();
        } else if (jsonResponse['data'] != null) {
          final List data = jsonResponse['data'];
          return data.map((e) => Task.fromJson(e)).toList();
        }
      }
    } catch (e) {
      debugPrint("Error fetching tasks: $e");
    }
    return [];
  }

  // Lấy chi tiết (Hardcode ID = 1 theo đề)
  static Future<TaskDetail> fetchTaskDetail(int id) async {
    const url = '$baseUrl/task/1';
    debugPrint("Calling API Detail: $url");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['id'] != null || jsonResponse['title'] != null) {
        return TaskDetail.fromJson(jsonResponse);
      } else if (jsonResponse['data'] != null) {
        return TaskDetail.fromJson(jsonResponse['data']);
      }
    }
    throw Exception('Failed to load detail');
  }

  // Xóa (Hardcode ID = 1 theo đề)
  static Future<bool> deleteTask(int id) async {
    const url = '$baseUrl/task/1';
    debugPrint("Calling API Delete: $url");

    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    }
    return false;
  }
}
