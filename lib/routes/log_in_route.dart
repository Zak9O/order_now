import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:order_now/constants.dart';
import 'package:order_now/widgets/elevated_card.dart';

class LogInRoute extends StatefulWidget {
  @override
  _LogInRouteState createState() => _LogInRouteState();
}

class _LogInRouteState extends State<LogInRoute> {
  String email;
  String password;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedCard(
          child: Container(
            width: 400.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Log In',
                  style: kTitleTextStyle,
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  onChanged: (str) => email = str,
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  onChanged: (str) => password = str,
                ),
                SizedBox(
                  height: 15.0,
                ),
                MaterialButton(
                  child: Row(
                    children: [
                      Text(
                        'Log in',
                        style: TextStyle(color: Colors.white),
                      ),
                      isLoading
                          ? RefreshProgressIndicator()
                          : Icon(
                              Icons.login,
                              color: Colors.white,
                            ),
                    ],
                  ),
                  color: kPrimaryColor,
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    var credentials = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email, password: password);
                    setState(() {
                      isLoading = false;
                    });
                    print(
                        '_LogInRouteState.build: credentials: ${credentials.additionalUserInfo}');
                    print(
                        '_LogInRouteState.build: email: ${FirebaseAuth.instance.currentUser.email}');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
