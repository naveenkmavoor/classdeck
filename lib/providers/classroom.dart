import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClassRoom {
  final int id;
  final String name;
  final String layout;
  final int size;
  final int? subjectId;

  ClassRoom({
    required this.id,
    required this.name,
    required this.layout,
    required this.size,
    this.subjectId,
  });
}

class ClassRooms with ChangeNotifier {
  List<ClassRoom> _classrooms = [];
  bool isLoading = false;
  List<ClassRoom> get classrooms {
    return [..._classrooms];
  }

  Future<void> getClassroom() async {
    const url =
        'https://hamon-interviewapi.herokuapp.com/classrooms/?api_key=8A46f';
    final http.Response response =
        await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final extractedClassroom = (extractedData['classrooms'] as List<dynamic>)
        .map((classroom) => ClassRoom(
            id: classroom['id'],
            name: classroom['name'],
            layout: classroom['layout'],
            size: classroom['size'],
            subjectId: classroom['subject'] ?? 0))
        .toList();
    _classrooms = extractedClassroom;
  }

  Future<Map<String, dynamic>> getClassById(int id) async {
    try {
      final http.Response response = await http
          .get(Uri.parse(
              'https://hamon-interviewapi.herokuapp.com/classrooms/$id?api_key=8A46f'))
          .timeout(const Duration(seconds: 10));
      final extractedClassroom =
          json.decode(response.body) as Map<String, dynamic>;
      return extractedClassroom;
    } catch (err) {
      rethrow;
    }
  }

  Future<void> addSubjectToClass(int classId, int subjectId) async {
    isLoading = true;
    notifyListeners();
    try {
      final http.Response response = await http.patch(
          Uri.parse(
              'https://hamon-interviewapi.herokuapp.com/classrooms/$classId?api_key=8A46f'),
          body: {'subject': '$subjectId'}).timeout(const Duration(seconds: 10));
      if (response.statusCode >= 400) {
        throw ("Subject id not found.");
      }
    } on TimeoutException {
      throw ('Timeout Error. Failed to perform task.');
    } on SocketException {
      throw ('No Internet connection. Failed to perform task');
    } on Error {
      throw ('Error occurred. Failed to perform task');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
