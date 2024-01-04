import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app/app_widget.dart';

const myColors = Color(0xFF4B39EF);

void main() async {
  if(kIsWeb){
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: FirebaseOptions(
        apiKey: "AIzaSyBNYYjGrcGw9gOFfAg9rr2ACeEofhZC0x0",
        authDomain: "first-logic-erp.firebaseapp.com",
        projectId: "first-logic-erp",
        storageBucket: "first-logic-erp.appspot.com",
        messagingSenderId: "1006994680466",
        appId: "1:1006994680466:web:e0a6260b5a8a502e40d44b",
        measurementId: "G-58TS14550F"
    ));


    runApp(MyApp());
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MyApp());
  }

}

setSearchParam(String caseNumber) {
  List<String> caseSearchList = [];
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

getBranch() {
  FirebaseFirestore.instance
      .collection('sendNotification')
      .add({
    'name':'DDEC2023'
  });
}