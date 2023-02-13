import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final CollectionReference _appointmentDetails =
      FirebaseFirestore.instance.collection('appointmentDetails');
  final _auth = FirebaseAuth.instance.currentUser;

  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _topicController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String _hour = '', _minute = '', _time = '';

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            color: const Color(0xffF5EBE0),
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: Color(0xffAB9581),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: _topicController,
                  decoration: const InputDecoration(
                    labelText: 'Topic',
                    labelStyle: TextStyle(
                      color: Color(0xffAB9581),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: _descController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      color: Color(0xffAB9581),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Ink(
                        child: Container(
                          margin: const EdgeInsets.only(top: 15),
                          height: 40,
                          width: 100,
                          color: const Color(0xff987F69),
                          child: const Center(
                            child: Text(
                              'Pick Date',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: Ink(
                        child: Container(
                          margin: const EdgeInsets.only(top: 15, left: 15),
                          height: 40,
                          width: 100,
                          color: const Color(0xff987F69),
                          child: const Center(
                            child: Text(
                              'Pick Time',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff987F69),
                  ),
                  child: const Text('CREATE'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String topic = _topicController.text;
                    final String desc = _descController.text;
                    final String date = _dateController.text;
                    final String time = _timeController.text;
                    if (name != null) {
                      await _appointmentDetails.add({
                        "name": name,
                        "topic": topic,
                        "desc": desc,
                        "date": date,
                        "time": time,
                        "status": "Created",
                        "email": _auth!.email
                      });

                      _nameController.text = '';
                      _topicController.text = '';
                      _descController.text = '';
                      _dateController.text = '';
                      _timeController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _descController.text = documentSnapshot['desc'];
      _topicController.text = documentSnapshot['topic'];
      _dateController.text = documentSnapshot['date'];
      _timeController.text = documentSnapshot['time'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            color: const Color(0xffF5EBE0),
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: Color(0xffAB9581),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: _topicController,
                  decoration: const InputDecoration(
                    labelText: 'Topic',
                    labelStyle: TextStyle(
                      color: Color(0xffAB9581),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: _descController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      color: Color(0xffAB9581),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Ink(
                        child: Container(
                          margin: const EdgeInsets.only(top: 15),
                          height: 40,
                          width: 100,
                          color: const Color(0xff987F69),
                          child: const Center(
                            child: Text(
                              'Pick Date',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: Ink(
                        child: Container(
                          margin: const EdgeInsets.only(top: 15, left: 15),
                          height: 40,
                          width: 100,
                          color: const Color(0xff987F69),
                          child: const Center(
                            child: Text(
                              'Pick Time',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff987F69),
                  ),
                  child: const Text('UPDATE'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String topic = _topicController.text;
                    final String desc = _descController.text;
                    final String date = _dateController.text;
                    final String time = _timeController.text;

                    if (name != null) {
                      await _appointmentDetails
                          .doc(documentSnapshot!.id)
                          .update({
                        "name": name,
                        "topic": topic,
                        "desc": desc,
                        "date": date,
                        "time": time
                      });

                      _nameController.text = '';
                      _topicController.text = '';
                      _descController.text = '';
                      _dateController.text = '';
                      _timeController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _appointmentDetails.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted an appointment')));
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
              primary: Color(0xff987F69),
              onPrimary: Color(0xffF5EBE0),
              onSurface: Color(0xffAB9581),
            )),
            child: child!);
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
              primary: Color(0xff987F69),
              onPrimary: Color(0xffF5EBE0),
              onSurface: Color(0xffAB9581),
            )),
            child: child!);
      },
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EBE0),
      appBar: AppBar(
        backgroundColor: const Color(0xff987F69),
        title: const Text("STUDENT PAGE"),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xffF5EBE0),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xff987F69),
              ),
              child: Text(
                "Hi ${user.email!}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Scan QR Code',
                style: TextStyle(
                  color: Color(0xff987F69),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: _appointmentDetails.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  final theDate = documentSnapshot['date'];
                  final theTime = documentSnapshot['time'];
                  final theStatus = documentSnapshot['status'];
                  final theEmail = documentSnapshot['email'];
                  print(theEmail);
                  // if (theEmail == _auth!.email) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      tileColor: const Color(0xff987F69),
                      shape: RoundedRectangleBorder(
                        // side: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      title: Text(
                        documentSnapshot['name'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '$theDate, $theTime\nStatus: $theStatus',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      isThreeLine: true,
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (documentSnapshot['email'] == _auth!.email) {
                                  _update(documentSnapshot);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'You cannot edit other student\'s appointment!')));
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (documentSnapshot['email'] == _auth!.email) {
                                  _delete(documentSnapshot.id);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'You cannot delete other student\'s appointment!')));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                // },
                );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff987F69),
        onPressed: () {
          _create();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
