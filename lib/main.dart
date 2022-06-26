/*
import 'package:flutter/material.dart';
import 'package:t2/screens/auth/HomeScreen.dart';
import 'package:t2/screens/auth/login.dart';
import 'package:t2/screens/auth/signup.dart';

import 'screens/tasks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter WorkOs Arabic',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFEDE7DC),
        primarySwatch: Colors.blue,
      ),
      home: homeScreen(),
    );
  }
}

*/
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:t2/screens/auth/Health_informationScreen.dart';
import 'package:t2/user_state.dart';
import 'package:t2/x.dart';
import 'package:t2/xxxx.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _appInitialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _appInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Text(
                    'App is loading',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Text(
                    'An error has been occured',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Workouts Arabic',
            theme: ThemeData(
              scaffoldBackgroundColor: Color(0xFFEDE7DC),
              primarySwatch: Colors.blue,
            ),
            home: UserState(),
          );
        });
  }
}
