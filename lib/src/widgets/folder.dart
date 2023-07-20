import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../styles/style.dart';

Widget folder(Function() ?onTap, QueryDocumentSnapshot doc){
  ThemeData theme = AppStyle.cardsColor[Random().nextInt(AppStyle.cardsColor.length)];
  
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.folder_rounded),
          const SizedBox(width: 10.0,),
          Text(doc["name"], style:AppStyle.mainTitle)
        ],
      ),
    )
  );
}