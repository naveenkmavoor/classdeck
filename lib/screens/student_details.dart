import 'package:classdeck/providers/student.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentDetails extends StatelessWidget {
  static const routeName = '/studentdetails';

  const StudentDetails({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final studentId = ModalRoute.of(context)!.settings.arguments as int;
    final students = Provider.of<Students>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
      ),
      body: Center(
        child: FutureBuilder(
          future: students.fetchStudentById(studentId),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Oops! Something went wrong.'),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Text('ID : ${snapshot.data!['id']}'),
                    Text(
                      'NAME : ${snapshot.data!['name']}',
                    ),
                    Text('AGE : ${snapshot.data!['age']}'),
                    Text('EMAIL : ${snapshot.data!['email']}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
