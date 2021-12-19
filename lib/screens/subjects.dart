import 'package:classdeck/providers/subject.dart';
import 'package:classdeck/screens/subject_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectsList extends StatelessWidget {
  static const routeName = '/subjects';
  const SubjectsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sub = Provider.of<Subjects>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subjects'),
      ),
      body: FutureBuilder(
        future: sub.getSubjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Oops! Something went wrong.'));
          }
          return ListView(
            children: sub.subjects.map((subject) {
              return Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pushNamed(
                        SubjectDetails.routeName,
                        arguments: subject.id),
                    child: ListTile(
                      title: Text(subject.name),
                      leading: Text(
                        subject.id.toString(),
                      ),
                    ),
                  ),
                  const Divider()
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
