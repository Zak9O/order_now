import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:order_now/routes/log_in_route.dart';
import 'package:order_now/routes/main_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(scaffoldBackgroundColor: Colors.grey[200]),
      home: _Start(),
    );
  }
}

///Simply checks if the user is logged in or not.
class _Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData || FirebaseAuth.instance.currentUser != null) {
          return MainRoute();
        }
        return LogInRoute();
      },
    );
  }
}
