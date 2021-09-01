import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_now/constants.dart';
import 'package:order_now/models/address.dart';
import 'package:order_now/routes/manage_address_route.dart';
import 'package:order_now/view_models/main_route_vm.dart';
import 'package:order_now/view_models/manage_places_vm.dart';
import 'package:order_now/widgets/elevated_card.dart';
import 'package:order_now/widgets/overlay_button.dart';
import 'package:provider/provider.dart';

class ManageAddressesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ManageAddressesVM(),
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  ElevatedCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Addresses',
                              style: kTitleTextStyle,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.info,
                                color: kPrimaryColor,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => _InfoDialog(),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Builder(
            builder: (context) {
              var mainModel = Provider.of<MainRouteVM>(context, listen: true);
              return mainModel.isLoadingAddresses
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SliverPadding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 20.0),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            //When the last index is met an add button
                            //should be added to the list
                            if (index == mainModel.addresses.length) {
                              return Consumer<ManageAddressesVM>(
                                builder: (context, model, child) =>
                                    ElevatedCard(
                                  padding: 0.0,
                                  child: InkWell(
                                    onTap: model.isAddingAddress
                                        ? null
                                        : () async {
                                            Address address = await showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  _CreatePlaceDialog(),
                                            );
                                            if (address == null) return;
                                            model.addAddress(context, address);
                                          },
                                    child: Center(
                                      child: LayoutBuilder(
                                        builder: (context, box) =>
                                            model.isAddingAddress
                                                ? CircularProgressIndicator()
                                                : Icon(
                                                    Icons.add_circle_outline,
                                                    color: kPrimaryColor,
                                                    size: box.maxWidth / 3,
                                                  ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return _PlaceCard(
                              address: mainModel.addresses[index],
                            );
                          },
                          //Length plussed with one to add an add button
                          childCount: mainModel.addresses.length + 1,
                        ),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300.0,
                          crossAxisSpacing: 25.0,
                          mainAxisSpacing: 25.0,
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}

///Returns a new [Address] object
//TODO: make stateless
class _CreatePlaceDialog extends StatefulWidget {
  @override
  _CreatePlaceDialogState createState() => _CreatePlaceDialogState();
}

class _CreatePlaceDialogState extends State<_CreatePlaceDialog> {
  String _addressName;

  bool _isValid = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 400.0,
        width: 400.0,
        child: Material(
          borderRadius: BorderRadius.circular(25.0),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.white,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 300.0,
                    child: Material(
                      color: kPrimaryColor,
                      child: Center(
                        child: Icon(
                          Icons.person,
                          size: 100.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100.0,
                    child: Center(
                      child: TextField(
                        style: kTitleTextStyle,
                        textAlign: TextAlign.center,
                        onChanged: (text) {
                          _addressName = text;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Click to write name',
                        ),
                      ),
                    ),
                    // Column(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     Container(
                    //       constraints: BoxConstraints(minHeight: 85.0),
                    //       child: RoundedTextField(
                    //         labelText: 'Name of Place',
                    //         hintText: 'Burger Joint - New York City',
                    //         errorText: _isValid ? null : 'Not a valid name',
                    //         onChanged: (text) {
                    //           _placeName = text;
                    //           if (!_isValid) {
                    //             setState(() {
                    //               _isValid = true;
                    //             });
                    //           }
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                ],
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OverlayButton(
                          radius: 25.0,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        OverlayButton(
                          radius: 25.0,
                          onTap: () {
                            if (!validate()) return;
                            Navigator.pop(
                                context, Address(title: _addressName));
                          },
                          icon: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  bool validate() {
    if (_addressName == null || _addressName.trim().isEmpty) {
      _isValid = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No name provided')));
    }
    return _isValid;
  }
}

class _InfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16.0),
        constraints: BoxConstraints(maxWidth: 350.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What is Places?',
              style: kTitleTextStyle,
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
                "A 'Place' is one of your restaurants or cafes in different geographical locations. "
                "\n\nBy creating an individual 'Place' for each of your individual restaurants you will have an easier time managing each of your restaurants' tables and notifications"),
            SizedBox(
              height: 15.0,
            ),
            MaterialButton(
              child: Text(
                'OK!',
                style: TextStyle(color: Colors.white),
              ),
              minWidth: double.infinity,
              color: kPrimaryColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceCard extends StatelessWidget {
  _PlaceCard({@required this.address}) : assert(address != null);

  final Address address;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: address.id,
      child: ElevatedCard(
        padding: 0.0,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ManageAddressRoute(address: address)));
          },
          child: LayoutBuilder(
            builder: (context, box) => Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Material(
                    color: kPrimaryColor,
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: box.maxWidth / 3,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      address.title,
                      textAlign: TextAlign.center,
                      style: kTitleTextStyle.copyWith(
                        fontSize: (box.maxWidth ~/ 13).toDouble(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
