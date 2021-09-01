import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_now/repositories/table_repo.dart';
import 'package:order_now/view_models/account_doc_vm.dart';
import 'package:provider/provider.dart';

class TableOverviewVM extends ChangeNotifier {
  bool _isAddingTables = false;

  Future<void> addTable(BuildContext context, int amount) async {
    _isAddingTables = true;
    notifyListeners();

    await TableRepo.addTables(amount);

    _isAddingTables = false;
    notifyListeners();
  }

  Future<void> deleteTables(BuildContext context, int amount) async {
    notifyListeners();

    await TableRepo.deleteTables(amount);

    notifyListeners();
  }

  List<int> _selectedTables = [];

  void selectTable(int tableIndex) {
    _selectedTables.add(tableIndex);
    notifyListeners();
  }

  void deselectTable(int tableIndex) {
    _selectedTables.remove(tableIndex);
    notifyListeners();
  }

  bool isTableSelected(int tableIndex) => _selectedTables.contains(tableIndex);

  bool get isNoTablesSelected => _selectedTables.isEmpty;

  int get selectedTablesLen => _selectedTables.length;

  bool get isAddingTables => _isAddingTables;
}
