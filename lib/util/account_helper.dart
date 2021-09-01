import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountHelper {
  static DocumentReference get accountDoc => FirebaseFirestore.instance
      .collection('companies')
      .doc(FirebaseAuth.instance.currentUser.uid);
}
