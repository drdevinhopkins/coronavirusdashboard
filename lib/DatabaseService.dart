import 'dart:html';

import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService extends ChangeNotifier {
  Future<QuerySnapshot> getAllScreenings(location) {
    var colRef = firestore().collection(location);
    return colRef.get();
  }

  // Stream<QuerySnapshot> fullDescStream =
  //     firestore().collection('jgh-ed').orderBy('timestamp', 'desc').onSnapshot;

  Stream<QuerySnapshot> getLast10ScreeningsStream(location) {
    var colRef = firestore().collection(location);
    return colRef.orderBy('timestamp', 'desc').limit(10).onSnapshot;
  }
}
