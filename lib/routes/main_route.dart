import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:order_now/pages/home_page.dart';
import 'package:order_now/pages/manage_addresses_page.dart';
import 'package:order_now/pages/table_overview_page.dart';
import 'package:order_now/view_models/account_doc_vm.dart';
import 'package:order_now/view_models/main_route_vm.dart';
import 'package:provider/provider.dart';

enum _MainRoutePages { home, tableOverview, manageAddresses }

///The main route of the app. This is the page where the restaurant can
///see a overview of things
class MainRoute extends StatefulWidget {
  @override
  _MainRouteState createState() => _MainRouteState();
}

///This apps handles it's own simple page switching state. It would be overkill
///to create a VM that only handled page switching
class _MainRouteState extends State<MainRoute> {
  @override
  void initState() {
    super.initState();
    _page = _MainRoutePages.home;
  }

  _MainRoutePages _page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _page.toString().split('.')[1],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text(
                'Home',
              ),
              leading: Icon(
                Icons.house,
              ),
              onTap: () {
                setState(() {
                  _page = _MainRoutePages.home;
                });
              },
            ),
            ListTile(
              title: Text(
                'Requests',
              ),
              leading: Icon(
                Icons.mail,
              ),
            ),
            ListTile(
              title: Text(
                'Table overview',
              ),
              leading: Icon(
                Icons.view_comfortable,
              ),
              onTap: () {
                setState(() {
                  _page = _MainRoutePages.tableOverview;
                });
              },
            ),
            ListTile(
              title: Text(
                'Mange places',
              ),
              leading: Icon(
                Icons.place,
              ),
              onTap: () {
                setState(() {
                  _page = _MainRoutePages.manageAddresses;
                });
              },
            ),
            ListTile(
              title: Text(FirebaseAuth.instance.currentUser.email),
            ),
          ],
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => MainRouteVM(),
        child: Consumer<MainRouteVM>(
          builder: (context, _, __) => child(),
        ),
      ),
    );
  }

  Widget child() {
    switch (_page) {
      case _MainRoutePages.home:
        return HomePage();
      case _MainRoutePages.tableOverview:
        return TableOverviewPage();
      case _MainRoutePages.manageAddresses:
        return ManageAddressesPage();
    }
    return null;
  }
}
