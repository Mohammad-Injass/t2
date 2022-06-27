import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:t2/constants/constants.dart';
import 'package:t2/widgets/drawer_widget.dart';
import 'dart:ui';
import 'package:t2/constants/chart_activity_status.dart';
import 'package:t2/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../widgets/drawer_widget.dart';

class healthStatusScreen extends StatefulWidget {
  final String userID;
  const healthStatusScreen({required this.userID});

  @override
  _healthStatusScreen createState() => _healthStatusScreen();
}

class _healthStatusScreen extends State<healthStatusScreen> {
  String phoneNumber = "";

  @override
  void initState() {
    super.initState();
    getUserDate();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Health Status',
          style: TextStyle(color: Colors.pink),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Heart Rate",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      color: secondary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30)),
                  // width: double.infinity,
                  child:
                      LineChart(activityData(Constants.combinationHeart, 140)),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Steps",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      color: secondary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30)),
                  // width: double.infinity,
                  child:
                      LineChart(activityData(Constants.combinationSteps, 140)),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Calories",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      color: secondary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30)),
                  // width: double.infinity,
                  child: LineChart(
                      activityData(Constants.combinationCalories, 15)),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Last Health Suggestion:",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: secondary.withOpacity(0.5),
                    // borderRadius: BorderRadius.circular(30)
                  ),
                  // width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        Constants.suggestion2,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Medicine Suggestion:",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: secondary.withOpacity(0.5),
                    // borderRadius: BorderRadius.circular(30)
                  ),
                  // width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        Constants.suggestion,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "Call Emergency Contact Now!",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                      ),
                      socialButtons(
                          color: Colors.green,
                          icon: Icons.call_outlined,
                          fct: () {
                            _makePhoneCall(phoneNumber);
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Widget socialButtons(
      {required Color color, required IconData icon, required Function fct}) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 25,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: Icon(
            icon,
            color: color,
          ),
          onPressed: () {
            fct();
          },
        ),
      ),
    );
  }

  void getUserDate() async {
    print('uid ${widget.userID}');
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userID)
          .get();
      if (userDoc == null) {
        return;
      } else {
        setState(() {
          phoneNumber = userDoc.get('phone');
        });
      }
    } catch (err) {
    } finally {
      setState(() {});
    }
  }
}
