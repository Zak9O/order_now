import 'package:flutter/material.dart';
import 'package:order_now/models/address.dart';
import 'package:order_now/repositories/address_repo.dart';
import 'package:order_now/view_models/main_route_vm.dart';
import 'package:provider/provider.dart';

class ManageAddressesVM extends ChangeNotifier {
  bool _isAddingAddress = false;

  ///Adds and address and updates the [MainRouteVM]
  Future<void> addAddress(BuildContext context, Address address) async {
    _isAddingAddress = true;
    notifyListeners();
    await AddressRepo.addAddress(address);
    _isAddingAddress = false;
    notifyListeners();
    Provider.of<MainRouteVM>(context, listen: false).refreshAddresses();
  }

  bool get isAddingAddress => _isAddingAddress;
}
