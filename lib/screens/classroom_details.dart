import 'package:classdeck/providers/classroom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ClassRoomDetails extends StatefulWidget {
  static const routeName = '/classroomdetails';

  const ClassRoomDetails({Key? key}) : super(key: key);

  @override
  State<ClassRoomDetails> createState() => _ClassRoomDetailsState();
}

class _ClassRoomDetailsState extends State<ClassRoomDetails> {
  int subId = 0;
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final classId = ModalRoute.of(context)!.settings.arguments as int;

    final classroomsInstance = Provider.of<ClassRooms>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Classroom Details'),
        ),
        body: FutureBuilder(
          future: classroomsInstance.getClassById(classId),
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
                    Text('Classroom Name : ${snapshot.data!['name']}'),
                    Text('Classroom Id : ${snapshot.data!['id']}'),
                    Text('Classroom Layout : ${snapshot.data!['layout']}'),
                    Text('Classroom Size : ${snapshot.data!['size']}'),
                    snapshot.data!['subject'] == ""
                        ? const Text('No subject assigned yet!')
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text('Subject Id : '),
                              Form(
                                key: _key,
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: TextFormField(
                                    initialValue:
                                        snapshot.data!['subject'] == ""
                                            ? null
                                            : '${snapshot.data!['subject']}',
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]'))
                                    ], // Only num

                                    decoration: const InputDecoration(
                                        hintText: 'Enter Subject Id'),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Enter id';
                                      }
                                    },
                                    onSaved: (val) {
                                      subId = int.parse(val!);
                                    },
                                  ),
                                ),
                              ),
                              Consumer(
                                builder:
                                    (ctx, ClassRooms classval, Widget? child) {
                                  return TextButton.icon(
                                      onPressed: classval.isLoading
                                          ? null
                                          : () async {
                                              FocusScope.of(context).unfocus();

                                              if (_key.currentState!
                                                  .validate()) {
                                                _key.currentState!.save();
                                                try {
                                                  await classroomsInstance
                                                      .addSubjectToClass(
                                                          snapshot.data!['id'],
                                                          subId);
                                                  setState(() {});
                                                } catch (err) {
                                                  snackbarWidget(context, err);
                                                }
                                              }
                                            },
                                      icon: const Icon(Icons.add),
                                      label: const Text('Add/Modify subject'));
                                },
                              )
                            ],
                          ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  void snackbarWidget(BuildContext context, Object err) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).errorColor,
        content: Text(err.toString())));
  }
}
