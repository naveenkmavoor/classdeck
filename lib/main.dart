import 'package:classdeck/providers/classroom.dart';
import 'package:classdeck/providers/student.dart';
import 'package:classdeck/providers/subject.dart';
import 'package:classdeck/screens/classroom_details.dart';
import 'package:classdeck/screens/classrooms.dart';
import 'package:classdeck/screens/menu.dart';
import 'package:classdeck/screens/student_details.dart';
import 'package:classdeck/screens/students.dart';
import 'package:classdeck/screens/subject_details.dart';
import 'package:classdeck/screens/subjects.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Students()),
        ChangeNotifierProvider(create: (context) => Subjects()),
        ChangeNotifierProvider(create: (context) => ClassRooms())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: Theme.of(context).textTheme.apply(
                  fontSizeDelta: 2.0,
                )),
        home: const Menu(),
        routes: {
          StudentDetails.routeName: (context) => const StudentDetails(),
          StudentsList.routeName: (context) => const StudentsList(),
          SubjectsList.routeName: (context) => const SubjectsList(),
          SubjectDetails.routeName: (context) => const SubjectDetails(),
          ClassroomList.routeName: (context) => const ClassroomList(),
          ClassRoomDetails.routeName: (context) => const ClassRoomDetails()
        },
      ),
    );
  }
}
