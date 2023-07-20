import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/src/constants/text_constants.dart';
import 'package:firebase1/src/screens/login_screen.dart';
import 'package:firebase1/src/screens/note_editor.dart';
import 'package:firebase1/src/screens/note_reader.dart';
import 'package:firebase1/src/widgets/folder.dart';
import 'package:firebase1/src/widgets/note_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/style.dart';
import 'note_adder.dart';

// collection doc collection doc -- pattern followed for forming subcollections
// Try using these to create folder structure
class FolderScreen extends StatefulWidget {
  FolderScreen(this.inst, this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;
  CollectionReference<Map<String, dynamic>> inst;
  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  // User? user_id = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    String folderName = widget.doc["name"];
    String docId = widget.doc.id;
    // FirebaseFirestore newInst = widget.inst.doc(docId).collection(folderName);
    return Scaffold(
      appBar: AppBar(
        title: const Text(homeText1),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Log Out',
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Get.to(() => const LoginPage());
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
            Text(folderName,
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
              child: StreamBuilder<QuerySnapshot>(
                  // stream: FirebaseFirestore.instance.collection("notes").where("user_id", isEqualTo: user_id?.uid).snapshots(),
                  stream:
                      widget.inst.doc(docId).collection(folderName).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      // return GridView(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //           crossAxisCount: 2,
                      //         ),
                      //       children: snapshot.data!.docs
                      //       .map((note) => noteCard(() {
                      //         Get.to(() => NoteReaderScreen(note));
                      //         // Navigator.push(context, MaterialPageRoute(builder: (context) => NoteReaderScreen(note)));
                      //       }, note))
                      //       .toList(),
                      //       );
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final data = snapshot.data!.docs[index];
                          final dataType = data["data_type"];
                          final docId = snapshot.data!.docs[index].id;
                          if (dataType == "note") {
                            return noteCard(() {
                              Get.to(() => NoteReaderScreen(data));
                            }, data, widget.inst.doc(docId).collection(folderName));
                          } else if (dataType == "folder") {
                            return folder(() {
                              Get.to(() => FolderScreen(
                                  widget.inst.doc(docId).collection(folderName),
                                  data));
                            }, data);
                          }
                          return null;
                        },
                      );
                    }
                    return (const Text("No Items Found"));
                  }),
            )
          ],
        ),
      ),
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
                Get.to(() => NoteAdderScreen(widget.inst.doc(docId).collection(folderName)));
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
                                decoration: const InputDecoration(
                                  border: InputBorder.none, hintText: "Folder Name")
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await widget.inst.doc(docId).collection(folderName).add({
                                  "data_type": "folder",
                                  "name": inputName,
                                  "date": date.toString().substring(0, 16),
                                  // "user_id": userId?.uid
                                }).then((value) {
                                  print(value.id);
                                  Get.back();
                                }).catchError((error) =>
                                    print("Failed to add note due to $error"));
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
        // Get.to(() => NoteAdderScreen(widget.inst));
        child: const Icon(Icons.add),
      ),
    );
  }
}
