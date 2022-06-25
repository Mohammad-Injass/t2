import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:t2/inner_screens/all_Widget.dart';
import 'package:t2/inner_screens/healthStatusScreen.dart';
import 'package:t2/screens/auth/HomeScreen.dart';
import 'package:t2/screens/auth/login.dart';


class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.data == null) {
            print('User didn\'t login yet');
            return homeScreen();
            //return LoginScreen();
          } else if (userSnapshot.hasData) {
            print('User is logged in');
            return allWidget();
          } else if (userSnapshot.hasError) {
            return Center(
              child: Text(
                'An error has been occured',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            ),
          );
        });
  }

}
