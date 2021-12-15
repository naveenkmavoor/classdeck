import 'package:classdeck/screens/students.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                onPressed: () =>
                    Navigator.of(context).pushNamed(StudentsList.routename),
                icon: const Icon(Icons.navigate_next),
                label: const Text('Students List'))
          ],
        ),
      ),
    );
  }
}
