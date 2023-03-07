import 'package:flutter/material.dart';
import 'app/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';

const myColors = Color(0xFF4B39EF);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

setSearchParam(String caseNumber) {
  List<String> caseSearchList = List<String>();
  String temp = "";

  List<String> nameSplits = caseNumber.split(" ");
  for (int i = 0; i < nameSplits.length; i++) {
    String name = "";

    for (int k = i; k < nameSplits.length; k++) {
      name = name + nameSplits[k] + " ";
    }
    temp = "";

    for (int j = 0; j < name.length; j++) {
      temp = temp + name[j];
      caseSearchList.add(temp.toUpperCase());
    }
  }
  return caseSearchList;
}

//gsutil cors set cors.json gs://flit-6d60d.appspot.com
