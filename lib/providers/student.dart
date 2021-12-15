import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Student {
  final int id;
  final String name;
  final int age;
  final String email;
  Student(
      {required this.id,
      required this.name,
      required this.age,
      required this.email});
}

class Students with ChangeNotifier {
  List<Student> _students = [];

  List<Student> get students {
    return [..._students];
  }

  Future<void> fetchStudents() async {
    final http.Response response = await http.get(
      Uri.parse(
          'https://hamon-interviewapi.herokuapp.com/students/?api_key=8A46f'),
    );
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    final loadedStudents = (extractedData['students'] as List<dynamic>)
        .map((student) => Student(
            id: student['id'],
            name: student['name'],
            age: student['age'],
            email: student['email']))
        .toList();

    _students = loadedStudents;
  }

  Future<Map<String, dynamic>> fetchStudentById(int id) async {
    final http.Response response = await http.get(Uri.parse(
        'https://hamon-interviewapi.herokuapp.com/students/${id}?api_key=8A46f'));
    final loadedStudent = json.decode(response.body) as Map<String, dynamic>;
    return loadedStudent;
  }
}
