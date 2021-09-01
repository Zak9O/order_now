import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_now/models/address.dart';
import 'package:order_now/util/account_helper.dart';

class AddressRepo {
  static CollectionReference _addressCol =
      AccountHelper.accountDoc.collection('addresses');

  static Future<List<Address>> getAddresses() async {
    var addressesRaw = await _addressCol.get();
    List<Address> addresses = [];
    addressesRaw.docs.forEach((element) {
      addresses.add(Address.fromDoc(element));
    });
    return addresses;
  }

  static Future<void> addAddress(Address address) async {
    await _addressCol.add(address.toDocMap());
  }
}
