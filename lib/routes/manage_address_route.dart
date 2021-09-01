import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_now/constants.dart';
import 'package:order_now/models/address.dart';
import 'package:order_now/widgets/elevated_card.dart';

class ManageAddressRoute extends StatelessWidget {
  ManageAddressRoute({@required this.address}) : assert(address != null);

  final Address address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage address',
        ),
      ),
      body: Scrollbar(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 50.0),
          children: [
            LayoutBuilder(
              builder: (context, box) => createView(context, box),
            ),
            SizedBox(
              height: 25.0,
            ),
            ElevatedCard(
              height: 800.0,
              child: Column(
                children: [
                  Text(
                    'Regions and tables',
                    style: kTitleTextStyle,
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  SizedBox(
                    height: 700.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Overview',
                            style: kLesserTitleTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _PageButton(
                              title: 'Outdoor',
                              isSelected: true,
                              onTap: () {},
                            ),
                            _PageButton(
                              title: 'Indoor',
                              isSelected: false,
                              onTap: () {},
                            ),
                            _PageButton(
                              title: 'New Section',
                              isSelected: false,
                              onTap: () {},
                            ),
                          ],
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.grey[200],
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(25.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 8.0,
                                right: 8.0,
                                bottom: 8.0,
                              ),
                              child: PageView(
                                children: [
                                  Scrollbar(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) =>
                                          ListTile(title: Text('$index')),
                                      itemCount: 100,
                                    ),
                                  ),
                                  ListView.builder(
                                    itemBuilder: (context, index) =>
                                        Text('$index'),
                                    itemCount: 100,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(left: 8.0),
                        //   child: Text(
                        //     'Actions',
                        //     style: kLesserTitleTextStyle,
                        //   ),
                        // ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            MaterialButton(
                              child: Row(
                                children: [
                                  Text(
                                    'Add table',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                ],
                              ),
                              color: kPrimaryColor,
                              onPressed: () async {},
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            MaterialButton(
                              child: Row(
                                children: [
                                  Text(
                                    'Download all QR-codes',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.download_rounded,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                ],
                              ),
                              onPressed: () {},
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            MaterialButton(
                              child: Row(
                                children: [
                                  Text(
                                    'Download selected QR',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.download_rounded,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                ],
                              ),
                              onPressed: () {},
                              color: kPrimaryColor,
                              disabledColor: kPrimaryColor.withOpacity(0.5),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            MaterialButton(
                              child: Row(
                                children: [
                                  Text(
                                    'Delete tables',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.delete_forever_outlined,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                ],
                              ),
                              onPressed: () async {},
                              color: Colors.red,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createView(BuildContext context, BoxConstraints box) {
    bool isNarrow = box.maxWidth < 1000;
    var children = [
      Expanded(
        flex: 1,
        child: Hero(
          tag: address.id,
          child: ElevatedCard(
            height: 400.0,
            padding: 0.0,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
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
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      address.title,
                      textAlign: TextAlign.center,
                      style: kTitleTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(
        width: 25.0,
        height: 25.0,
      ),
      Expanded(
        flex: isNarrow ? 1 : 3,
        child: ElevatedCard(
          height: 400.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Address Info',
                style: kTitleTextStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sections',
                    style: kLesserTitleTextStyle,
                  ),
                  Text(
                    '10',
                    style: kLesserTitleTextStyle.copyWith(color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tables',
                    style: kLesserTitleTextStyle,
                  ),
                  Text(
                    '49',
                    style: kLesserTitleTextStyle.copyWith(color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total messages received from OrderNow',
                    style: kLesserTitleTextStyle,
                  ),
                  Text(
                    '4928',
                    style: kLesserTitleTextStyle.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ];
    return isNarrow
        ? SizedBox(
            height: 800.0,
            child: Column(
              children: children,
            ),
          )
        : Row(
            children: children,
          );
  }
}

class _PageButton extends StatelessWidget {
  const _PageButton({
    this.title = 'Placeholder',
    this.isSelected = false,
    this.onTap,
  });

  final bool isSelected;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPrimaryColor.withOpacity(isSelected ? 1 : 0.7),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(
            top: 8.0,
            left: 8.0,
            right: 8.0,
            bottom: isSelected ? 8.0 : 4.0,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
