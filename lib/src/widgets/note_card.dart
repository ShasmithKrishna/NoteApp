import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/src/screens/note_editor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/style.dart';

Widget noteCard(Function() ?onTap, QueryDocumentSnapshot doc, CollectionReference<Map<String, dynamic>> inst){
  ThemeData theme = AppStyle.cardsColor[doc['color_id']];
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(6.0),
    child: Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(doc["name"], style:AppStyle.mainTitle),
              const SizedBox(height: 4.0,),
              Text(doc["date"], style:AppStyle.dateTitle),
              // const SizedBox(height: 8.0,),
              // Text(doc["note_content"], style:AppStyle.mainContent, maxLines: 2, overflow: TextOverflow.ellipsis,),
          ]),
          Row(
            children: [
              IconButton(onPressed: () async {
                Get.to(() => NoteEditorScreen(inst), arguments:{
                  "note_title": doc["name"],
                  "note_content": doc["content"],
                  "doc_id": doc.id,
                  "color_id":doc["color_id"],
                });
              }, alignment: AlignmentDirectional.centerEnd, iconSize:26.0, icon:const Icon(Icons.mode_edit_outlined)),
              IconButton(onPressed: () async {
                inst.doc(doc.id).delete();
              }, alignment: AlignmentDirectional.centerEnd, iconSize:26.0, icon:const Icon(Icons.delete_outline_rounded)),
            ],
          ),
        ],
      ),
    ),
  );
}