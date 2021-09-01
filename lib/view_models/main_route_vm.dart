import 'package:flutter/material.dart';
import 'package:order_now/models/address.dart';
import 'package:order_now/repositories/address_repo.dart';

///Responsible for reading, storing and updating the [Address] objects used
///by it's children.
class MainRouteVM extends ChangeNotifier {
  MainRouteVM() {
    print('runned');
    _isLoadingAddresses = true;
    _getAddresses();
  }

  List<Address> _addresses;
  bool _isLoadingAddresses;

  bool get isLoadingAddresses => _isLoadingAddresses;
  List<Address> get addresses => _addresses;

  Future<void> _getAddresses() async {
    _addresses = await AddressRepo.getAddresses();
    _isLoadingAddresses = false;
    notifyListeners();
  }

  void refreshAddresses() {
    _isLoadingAddresses = true;
    notifyListeners();
    _getAddresses();
  }
}
