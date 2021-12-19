import 'package:classdeck/screens/classrooms.dart';
import 'package:classdeck/screens/students.dart';
import 'package:classdeck/screens/subjects.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Options'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                onPressed: () =>
                    Navigator.of(context).pushNamed(StudentsList.routeName),
                icon: const Icon(Icons.navigate_next),
                label: const Text('Students List')),
            ElevatedButton.icon(
                onPressed: () =>
                    Navigator.of(context).pushNamed(SubjectsList.routeName),
                icon: const Icon(Icons.navigate_next),
                label: const Text('Subjects')),
            ElevatedButton.icon(
                onPressed: () =>
                    Navigator.of(context).pushNamed(ClassroomList.routeName),
                icon: const Icon(Icons.navigate_next),
                label: const Text('Classrooms'))
          ],
        ),
      ),
    );
  }
}
