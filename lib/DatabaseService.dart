import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService extends ChangeNotifier {
  Stream<QuerySnapshot> fullDescStream =
      firestore().collection('jgh-ed').orderBy('timestamp', 'desc').onSnapshot;

  getFullDescStreamLength() {
    return fullDescStream.length;
  }
}
