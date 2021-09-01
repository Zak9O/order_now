import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TableRepo {
  static Future<void> addTables(int amount) async {
    await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({'tables': FieldValue.increment(amount)});
  }

  static Future<void> deleteTables(int amount) async {
    await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({'tables': FieldValue.increment(-amount)});
  }
}
