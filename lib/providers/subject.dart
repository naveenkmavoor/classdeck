import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Subject {
  final int id;
  final String name;
  final String teacher;
  final int credits;

  Subject(
      {required this.id,
      required this.name,
      required this.teacher,
      required this.credits});
}

class Subjects with ChangeNotifier {
  List<Subject> _subjects = [];

  List<Subject> get subjects {
    return [..._subjects];
  }

  Future<void> getSubjects() async {
    const url =
        'https://hamon-interviewapi.herokuapp.com/subjects/?api_key=8A46f';
    final response = await http.get(Uri.parse(url));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final loadedSubjects = (extractedData['subjects'] as List<dynamic>)
        .map((subjectData) => Subject(
              id: subjectData['id'],
              name: subjectData['name'],
              teacher: subjectData['teacher'],
              credits: subjectData['credits'],
            ))
        .toList();

    _subjects = loadedSubjects;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getSubjectById(int subjectId) async {
    final http.Response response = await http.get(Uri.parse(
        'https://hamon-interviewapi.herokuapp.com/subjects/$subjectId?api_key=8A46f'));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    return extractedData;
  }
}
