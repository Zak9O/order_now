import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  Address({this.title});

  Address.fromDoc(DocumentSnapshot doc) {
    _ref = doc.reference;
    var map = doc.data() as Map<String, dynamic>;
    title = map['title'];
  }

  String title;
  DocumentReference _ref;

  ///Returns a Map that is compatible with the map struture of this class in
  ///Firestore
  Map<String, dynamic> toDocMap() {
    Map<String, dynamic> map = Map();
    map['title'] = title;
    return map;
  }

  DocumentReference get ref => _ref;
  String get id => _ref.id;
}
