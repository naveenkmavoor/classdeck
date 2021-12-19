import 'package:classdeck/providers/classroom.dart';
import 'package:classdeck/screens/classroom_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassroomList extends StatelessWidget {
  static const routeName = '/classroom';
  const ClassroomList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final classroomsInstance = Provider.of<ClassRooms>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classrooms'),
      ),
      body: FutureBuilder(
        future: classroomsInstance.getClassroom(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Oops! Something went wrong.'));
          }
          return ListView(
            children: classroomsInstance.classrooms.map((classval) {
              return Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pushNamed(
                        ClassRoomDetails.routeName,
                        arguments: classval.id),
                    child: ListTile(
                      title: Text(classval.name),
                      leading: Text(
                        classval.id.toString(),
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
