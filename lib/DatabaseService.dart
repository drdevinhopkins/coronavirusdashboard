import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService extends ChangeNotifier {
  final jghED = firestore().collection('jgh-ed');

  Future<QuerySnapshot> getAllScreenings() {
    return jghED.get();
  }

  // Stream<QuerySnapshot> fullDescStream =
  //     firestore().collection('jgh-ed').orderBy('timestamp', 'desc').onSnapshot;

  Stream<QuerySnapshot> getLast10ScreeningsStream() {
    return jghED.orderBy('timestamp', 'desc').limit(10).onSnapshot;
  }
}
