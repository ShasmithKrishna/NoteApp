import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/src/constants/text_constants.dart';
import 'package:firebase1/src/screens/login_screen.dart';
import 'package:firebase1/src/screens/note_editor.dart';
import 'package:firebase1/src/screens/note_reader.dart';
import 'package:firebase1/src/widgets/note_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/style.dart';
import '../widgets/folder.dart';
import 'folder_viewer.dart';
import 'note_adder.dart';
// import 'note_adder.dart';

class NoteHomeScreen extends StatefulWidget {
  NoteHomeScreen({super.key});

  @override
  State<NoteHomeScreen> createState() => _NoteHomeScreenState();
}

class _NoteHomeScreenState extends State<NoteHomeScreen> {
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    // int _selectedIndex = 0;
    CollectionReference<Map<String, dynamic>> inst =
        FirebaseFirestore.instance.collection("users");

    Future<String> getDocumentId(String? email) async {
      String documentId = "";
      await inst.where('email', isEqualTo: email).get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          documentId = result.id;
        }
      });
      return documentId;
    }

    // String docId = "";
    String? docId;
    // print("docId: ${docId}");
    return Scaffold(
      appBar: AppBar(
        title: const Text(homeText1),
        automaticallyImplyLeading: false,
        // Profile Screen
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.account_circle)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Log Out',
            onPressed: () {
              Get.to(() => LoginPage());
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notes",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: theme.primaryColorDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                )),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: FutureBuilder(
                  future: getDocumentId(userId?.email),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      docId = snapshot.data.toString();
                      // print("docId: ${docId}");
                      return StreamBuilder<QuerySnapshot>(
                          stream:
                              inst.doc(docId.toString()).collection("notes").snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                            if (streamSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (streamSnapshot.hasData) {
                              return ListView.builder(
                                itemCount: streamSnapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final note = streamSnapshot.data!.docs[index];
                                  final dataType = note["data_type"];
                                  if(dataType == "folder"){
                                      return folder(() {
                                        Get.to(() => FolderScreen(
                                            inst.doc(docId)
                                                .collection("notes"),
                                            note));
                                      }, note);
                                  }
                                  else if(dataType == "note") {
                                      return noteCard(() {
                                        Get.to(() => NoteReaderScreen(note));
                                      }, note, inst.doc(docId).collection("notes"));
                                    }
                                    else{
                                      return const Text("No objects");
                                    }
                                },
                              );
                            }
                            return (const Text("No notes Found"));
                          });
                    }
                  }),
            )
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.speaker_notes_outlined),
      //       label: 'Notes',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.business),
      //       label: 'Appointments',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.school),
      //       label: 'Documents',
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final RenderBox overlay =
              Overlay.of(context).context.findRenderObject() as RenderBox;
          final RelativeRect position = RelativeRect.fromRect(
            Rect.fromPoints(
              Offset.zero,
              overlay.size.bottomRight(Offset.zero),
            ),
            Offset.zero & overlay.size,
          );
          showMenu<String>(
            context: context,
            position: position,
            items: [
              const PopupMenuItem<String>(
                value: '1',
                child: Text('Add Note'),
              ),
              const PopupMenuItem<String>(
                value: '2',
                child: Text('Add Folder'),
              ),
              // const PopupMenuItem<String>(
              //   value: 'Option 3',
              //   child: Text('Option 3'),
              // ),
            ],
          ).then((value) {
            if (value != null) {
              // Handle menu item selection
              // print('Selected: $value');
              if (value == "1") {
                Get.to(() => NoteAdderScreen(
                    inst.doc(docId.toString()).collection("notes")));
              } else if (value == "2") {
                final date = DateTime.now();
                String inputName = '';
                void storeNameValue(String value) {
                  setState(() {
                    inputName = value;
                  });
                }

                showModalBottomSheet(
                  context: context,
                  builder: (builder) {
                    return Container(
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                onChanged: (value) {
                                  storeNameValue(value);
                                },
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                print("docId: ${docId}");
                                await inst
                                    .doc(docId.toString())
                                    .collection("notes")
                                    .add({
                                  "data_type": "folder",
                                  "name": inputName,
                                  "color_id": Random()
                                      .nextInt(AppStyle.cardsColor.length),
                                  "date": date.toString().substring(0, 16),
                                  // "user_id": userId?.uid
                                }).then((value) {
                                  print(value.id);
                                }).catchError((error) => print(
                                        "Failed to add note due to $error"));
                              },
                              child: const Text("Add"),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }
          });
        },
        // Get.to(() => NoteAdderScreen(inst));
        child: const Icon(Icons.add),
      ),
    );
  }
}
