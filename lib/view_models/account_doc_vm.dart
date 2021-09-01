import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

///A VM that only handles updates to the logged in account's main doc in
///cloud Firestore
class AccountDocVM extends ChangeNotifier {
  AccountDocVM() {
    FirebaseFirestore.instance
        .collection('companies')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .listen((event) {
      _doc = event;
      notifyListeners();
    });
  }

  dynamic getField(String key) {
    if (!doc.exists) return null;
    var map = doc.data() as Map<String, dynamic>;
    return map[key];
  }

  DocumentSnapshot _doc;

  ///Remember to handle loading at your end!
  DocumentSnapshot get doc => _doc;
}
