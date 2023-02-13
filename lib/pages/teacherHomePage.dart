import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({super.key});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final CollectionReference _appointmentDetails =
      FirebaseFirestore.instance.collection('appointmentDetails');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EBE0),
      appBar: AppBar(
        backgroundColor: const Color(0xff987F69),
        title: const Text("TEACHER PAGE"),
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
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Slidable(
                    startActionPane:
                        ActionPane(motion: StretchMotion(), children: [
                      SlidableAction(
                        onPressed: (context) {
                          _appointmentDetails
                              .doc(documentSnapshot.id)
                              .update({"status": "Attended"});
                        },
                        backgroundColor: const Color(0xffF5EBE0),
                        icon: Icons.approval,
                        foregroundColor: const Color(0xff987F69),
                      ),
                    ]),
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
                                Icons.done,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _appointmentDetails
                                    .doc(documentSnapshot.id)
                                    .update({"status": "Approved"});
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _appointmentDetails
                                    .doc(documentSnapshot.id)
                                    .update({"status": "Rejected"});
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
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
