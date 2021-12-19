import 'package:classdeck/providers/student.dart';
import 'package:classdeck/screens/student_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentsList extends StatelessWidget {
  static const routeName = '/studentslist';

  const StudentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studentsData = Provider.of<Students>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: studentsData.getStudents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Oops! Something went wrong'),
              );
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pushNamed(
                          StudentDetails.routeName,
                          arguments: studentsData.students[index].id),
                      child: ListTile(
                        title: Text(
                          studentsData.students[index].name,
                        ),
                        leading: Text('${index + 1}'),
                      ),
                    ),
                    const Divider()
                  ],
                );
              },
              itemCount: studentsData.students.length,
            );
          },
        ),
      ),
    );
  }
}
