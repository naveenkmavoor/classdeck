import 'package:classdeck/providers/student.dart';
import 'package:classdeck/screens/menu.dart';
import 'package:classdeck/screens/student_details.dart';
import 'package:classdeck/screens/students.dart';
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
      providers: [ChangeNotifierProvider(create: (context) => Students())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Menu(),
        routes: {
          StudentDetails.routename: (context) => const StudentDetails(),
          StudentsList.routename: (context) => const StudentsList()
        },
      ),
    );
  }
}
