import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:t2/constants/chart_activity_status.dart';

import 'package:t2/colors.dart';

import 'package:fl_chart/fl_chart.dart';

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t2/inner_screens/healthStatusScreen.dart';
import '../constants/constants.dart';
import '../widgets/drawer_widget.dart';

import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:t2/constants/constants.dart';

import 'dart:convert' as convert;
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  // List<FlSpot> con ;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Api();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {


    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Activity Status",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: black),
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
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: LineChart(activityData(Constants.combinationHeart, 140)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "Heart Rate",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void Api() async {
    // Constants.combination.clear();

    var currDt = DateTime.now();
    String date = currDt.toString().substring(0, 10);

    var headers = {
      'accept': 'application/json',
      'authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMzhNQkYiLCJzdWIiOiI5WERXTkoiLCJpc3MiOiJGaXRiaXQiLCJ0eXAiOiJhY2Nlc3NfdG9rZW4iLCJzY29wZXMiOiJ3aHIgd3BybyB3bnV0IHdzbGUgd3dlaSB3c29jIHdzZXQgd2FjdCB3b3h5IHdsb2Mgd3JlcyIsImV4cCI6MTY1ODYwNTI4NCwiaWF0IjoxNjU2MDEzMjg0fQ.mgCSmvZcxY2O9jhTAiZIOKs7bjtM36Qrh7mU2PiltlA',
    };

    var url = Uri.parse(
        'https://api.fitbit.com/1/user/-/activities/heart/date/${date}/1d.json');
    var res = await http.get(url, headers: headers);
    if (res.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
//     var itemCount = jsonResponse['activities-heart'][0]['value']['heartRateZones'][0];
      var itemCount = jsonResponse['activities-heart-intraday']['dataset'];
      int count = 0;

      while (true) {
        try {
          var temp = itemCount[count]['time'];
          // print('test 1 ${temp.toString()}');
          double value = double.parse(itemCount[count]['value'].toString());
          double hours = double.parse(temp.toString().substring(0, 2));
          double minutes = double.parse(temp.toString().substring(3, 5));
          // print('test 2 ${temp.toString().substring(0, 2)}');
          // print('test 21 ${temp.toString().substring(3, 5)}');
          var time = hours + (minutes / 60);
          // print('time : ${time}');
          // time *= 10;
          // print('test 3 ${FlSpot(time, value)}');
          var a = FlSpot(time, value);
          Constants.combinationHeart.add(a);
          //print(Constants.combination.length);

        } catch (test) {
          // print(test);
          break;

        }
        count++;
      }
      print(Constants.combinationHeart);
      print('ooo${Constants.combinationHeart[Constants.combinationHeart.length-1].x } ');
    } else {
      print('Request failed with status: ${res.statusCode}.');
    }
    // print(res.body);
  }
}
