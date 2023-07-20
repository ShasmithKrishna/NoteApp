import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/src/screens/note_home_screen.dart';
import 'package:firebase1/src/styles/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NoteEditorScreen extends StatefulWidget {
  NoteEditorScreen(this.inst, {Key? key} ): super(key :key);
  CollectionReference<Map<String, dynamic>> inst;
  
  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int themeId = Get.arguments["color_id"];

  User? userId = FirebaseAuth.instance.currentUser;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    final formattedDate = DateFormat.yMd().format(date);
    final formattedTime = DateFormat.Hm().format(date);
    ThemeData theme = AppStyle.cardsColor[themeId];
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColorDark,
        title: const Text("Add a New Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(
            controller: _titleController..text="${Get.arguments['note_title']}",
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: "Note Title"),
            style: AppStyle.mainTitle,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Date: $formattedDate',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Time: $formattedTime',
            style: const TextStyle(fontSize: 16),
          ),
          TextField(
            controller: _contentController..text="${Get.arguments['note_content']}",
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: "Write your notes here"),
            style: AppStyle.mainContent,
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: theme.colorScheme.primary,
          onPressed: () async {
            await widget.inst.doc(Get.arguments["doc_id"]).update
            ({
              "name": _titleController.text,
              "content": _contentController.text,
              "creation_date": date.toString().substring(0, 16),
            }).catchError((error) => print("Failed to update note due to $error"));
            Get.to(() => NoteHomeScreen());
          },
          child: Icon(Icons.update)),
    );
  }
}
