import 'package:classdeck/screens/classrooms.dart';
import 'package:classdeck/screens/students.dart';
import 'package:classdeck/screens/subjects.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Options'),
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(text: 'Classrooms'),
              Tab(text: 'Subjects'),
              Tab(text: 'Students'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            ClassroomList(),
            SubjectsList(),
            StudentsList(),
          ],
        ),
      ),
    );
  }
}
