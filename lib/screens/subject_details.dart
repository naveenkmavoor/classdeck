import 'package:classdeck/providers/subject.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectDetails extends StatelessWidget {
  static const routeName = '/subjectdetails';
  const SubjectDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subjectId = ModalRoute.of(context)!.settings.arguments as int;
    final subject = Provider.of<Subjects>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Subject Details'),
        ),
        body: FutureBuilder(
          future: subject.getSubjectById(subjectId),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Oops! Something goes wrong.'),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Text('Subject Name : ${snapshot.data!['name']}'),
                    Text('Subject Id : ${snapshot.data!['id']}'),
                    Text('Subject Handled By : ${snapshot.data!['teacher']}'),
                    Text('Subject Credits : ${snapshot.data!['credits']}'),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
