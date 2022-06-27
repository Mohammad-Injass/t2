import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:t2/widgets/drawer_widget.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import '../widgets/drawer_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import '../constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:t2/constants/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class allWidget extends StatefulWidget {
  @override
  _allWidget createState() => _allWidget();
}

class _allWidget extends State<allWidget> {
  @override
  void initState() {
    apiHeart();
    apiSteps();
    apiCalories();
    apiSuggestionHeart();
    apiSuggestionGeneral();
    super.initState();
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
          'Main Screen',
          style: TextStyle(color: Colors.pink),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   width: 320,
            //   child: Text(
            //     'Go to Health Status Screen from the menu on the top left corner to see your',
            //     style: TextStyle(
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 230,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedTextKit(
                // isRepeatingAnimation: false,
                repeatForever: true,
                animatedTexts: [
                  FadeAnimatedText(
                    "Go to Health Status Screen from the menu on the top left corner to see your",
                    duration: const Duration(milliseconds: 99999000),
                    fadeOutBegin: 1,
                    fadeInEnd: 0.00008,
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                ColorizeAnimatedText(
                  "Heart Rate",
                  colors: [Colors.red,Colors.brown,Colors.white38,Colors.brown,Colors.red],
                  speed: const Duration(milliseconds: 500),
                  textStyle: TextStyle(
                    fontSize: 20,

                  ),
                ),
                ColorizeAnimatedText(
                  "Calories",
                  colors: [Colors.red,Colors.brown,Colors.white38,Colors.brown,Colors.red],
                  speed: const Duration(milliseconds: 500),

                  textStyle: TextStyle(
                    fontSize: 20,

                  ),
                ),
                ColorizeAnimatedText(
                  "Steps",
                  colors: [Colors.red,Colors.brown,Colors.white38,Colors.brown,Colors.red],
                  speed: const Duration(milliseconds: 500),
                  textStyle: TextStyle(
                    fontSize: 20,

                  ),
                ),
                ColorizeAnimatedText(
                  "Suggestion",
                  colors: [Colors.red,Colors.brown,Colors.white38,Colors.brown,Colors.red],
                  speed: const Duration(milliseconds: 500),
                  textStyle: TextStyle(
                    fontSize: 20,

                  ),
                ),
                ColorizeAnimatedText(
                  "Medicine Take Checker",
                  colors: [Colors.red,Colors.brown,Colors.white38,Colors.brown,Colors.red],
                  speed: const Duration(milliseconds: 500),
                  textStyle: TextStyle(
                    fontSize: 20,

                  ),
                ),
                // RotateAnimatedText(
                //   "Heart Rate",
                //   textStyle: TextStyle(
                //     fontSize: 20,
                //   ),
                // ),
                // RotateAnimatedText(
                //   "Calories",
                //   textStyle: TextStyle(
                //     fontSize: 20,
                //   ),
                // ),
                // RotateAnimatedText(
                //   "Steps",
                //   textStyle: TextStyle(
                //     fontSize: 20,
                //   ),
                // ),
                // RotateAnimatedText(
                //   "Suggestion",
                //   textStyle: TextStyle(
                //     fontSize: 20,
                //   ),
                // ),
                // RotateAnimatedText(
                //   "Medicine Take Checker",
                //   textStyle: TextStyle(
                //     fontSize: 20,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void apiHeart() async {
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
      var itemCount = jsonResponse['activities-heart-intraday']['dataset'];
      int count = 0;

      // print('1111111111111111111111111');
      // print(Constants.combination);
      Constants.combinationHeart.clear();
      // print('2222222222222222222222222');
      // print(Constants.combination);

      while (true) {
        try {
          var temp = itemCount[count]['time'];
          double value = double.parse(itemCount[count]['value'].toString());
          double hours = double.parse(temp.toString().substring(0, 2));
          double minutes = double.parse(temp.toString().substring(3, 5));
          var time = hours + (minutes / 60);
          var a = FlSpot(time, value);
          Constants.combinationHeart.add(a);
        } catch (test) {
          break;
        }
        count++;
      }
      // print('tttttttttttttttttttttttttt');
      print(Constants.combinationHeart);
      // print('ooo${Constants.combination[Constants.combination.length - 1].x} ');
    } else {
      print('Request failed with status: ${res.statusCode}.');
    }
  }

  void apiSteps() async {
    var currDt = DateTime.now();
    String date = currDt.toString().substring(0, 10);

    var headers = {
      'accept': 'application/json',
      'authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMzhNQkYiLCJzdWIiOiI5WERXTkoiLCJpc3MiOiJGaXRiaXQiLCJ0eXAiOiJhY2Nlc3NfdG9rZW4iLCJzY29wZXMiOiJ3aHIgd3BybyB3bnV0IHdzbGUgd3dlaSB3c29jIHdzZXQgd2FjdCB3b3h5IHdsb2Mgd3JlcyIsImV4cCI6MTY1ODYwNTI4NCwiaWF0IjoxNjU2MDEzMjg0fQ.mgCSmvZcxY2O9jhTAiZIOKs7bjtM36Qrh7mU2PiltlA',
    };

    var url = Uri.parse(
        'https://api.fitbit.com/1/user/-/activities/steps/date/${date}/1d.json');
    var res = await http.get(url, headers: headers);
    if (res.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
      var itemCount = jsonResponse['activities-steps-intraday']['dataset'];
      int count = 0;

      // print('1111111111111111111111111');
      // print(Constants.combinationSteps);
      Constants.combinationSteps.clear();
      // print('2222222222222222222222222');
      // print(Constants.combinationSteps);

      while (true) {
        try {
          var temp = itemCount[count]['time'];
          double value = double.parse(itemCount[count]['value'].toString());
          double hours = double.parse(temp.toString().substring(0, 2));
          double minutes = double.parse(temp.toString().substring(3, 5));
          var time = hours + (minutes / 60);
          var a = FlSpot(time, value);
          Constants.combinationSteps.add(a);
        } catch (test) {
          break;
        }
        count++;
      }
      // print('tttttttttttttttttttttttttt');
      print(Constants.combinationSteps);
      // print('ooo${Constants.combinationSteps[Constants.combination.length - 1].x} ');
    } else {
      print('Request failed with status: ${res.statusCode}.');
    }
  }

  void apiCalories() async {
    var currDt = DateTime.now();
    String date = currDt.toString().substring(0, 10);

    var headers = {
      'accept': 'application/json',
      'authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMzhNQkYiLCJzdWIiOiI5WERXTkoiLCJpc3MiOiJGaXRiaXQiLCJ0eXAiOiJhY2Nlc3NfdG9rZW4iLCJzY29wZXMiOiJ3aHIgd3BybyB3bnV0IHdzbGUgd3dlaSB3c29jIHdzZXQgd2FjdCB3b3h5IHdsb2Mgd3JlcyIsImV4cCI6MTY1ODYwNTI4NCwiaWF0IjoxNjU2MDEzMjg0fQ.mgCSmvZcxY2O9jhTAiZIOKs7bjtM36Qrh7mU2PiltlA',
    };

    var url = Uri.parse(
        'https://api.fitbit.com/1/user/-/activities/calories/date/${date}/1d.json');
    var res = await http.get(url, headers: headers);
    if (res.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
      var itemCount = jsonResponse['activities-calories-intraday']['dataset'];
      int count = 0;

      // print('1111111111111111111111111');
      // print(Constants.combinationCalories);
      Constants.combinationCalories.clear();
      // print('2222222222222222222222222');
      // print(Constants.combinationCalories);

      while (true) {
        try {
          var temp = itemCount[count]['time'];
          double value = double.parse(itemCount[count]['value'].toString());
          double hours = double.parse(temp.toString().substring(0, 2));
          double minutes = double.parse(temp.toString().substring(3, 5));
          var time = hours + (minutes / 60);
          var a = FlSpot(time, value);
          Constants.combinationCalories.add(a);
        } catch (test) {
          break;
        }
        count++;
      }
      // print('tttttttttttttttttttttttttt');
      print(Constants.combinationCalories);
      // print('ooo${Constants.combinationCalories[Constants.combinationCalories.length - 1].x} ');
    } else {
      print('Request failed with status: ${res.statusCode}.');
    }
  }

  void apiSuggestionHeart() async {
    var url1 = Uri.parse(
        'https://api.ubiops.com/v2.1/projects/smartwatch-recommende-system/deployments/grad-project-1/versions/v1-copy-01yuk-copy-t67m3-copy-nzqhr-copy-se58o/requests');
    var time_now = (new DateTime.now()).millisecondsSinceEpoch.toDouble();
    double sum = 0;
    double avgNow = 0;
    await Constants.combinationHeart;
    var i = 0;
    try {
      for (; i < 10; i++) {
        sum = sum + Constants.combinationHeart[-i].y;
      }
    } catch (something) {
      sum = 600;
      i = 10;
      print("something\n\n\n\n ${something}");
    }
    avgNow = sum / i;
    print("Average heart rate now : ${avgNow}");
    double avgBefore = 0;
    i = 0;
    try {
      for (; i < 10; i++) {
        sum = sum + Constants.combinationHeart[-i - 55].y;
      }
    } catch (something) {
      sum = 770;
      i = 10;
      print("something\n\n\n\n ${something}");
    }
    avgBefore = sum / i;
    print("Average heart rate before 1 hour : ${avgBefore}");

    var the_json = {
      "city": "Jerusalem",
      "heart-information": [time_now, avgNow, avgBefore],
      "heart-information": [time_now, 88.4, 77],
      "medicine-name": "Corgard",
      "phone-accelerometer": [0, 0, 0, 0, 0],
      "phone-gyroscope": [0, 0, 0, 0, 0],
      "watch-accelerometer": [0, 0, 0, 0, 0],
      "watch-gyroscope": [0, 0, 0, 0, 0]
    };
    Map<String, String> headers = {
      // 'url': url1.toString(),
      HttpHeaders.authorizationHeader:
          'Token 3c3e5a7a99bac8d802642ac15091ecc38c2d5a16',
      'input': the_json.toString(),
    };
    var response = await http.post(url1, body: jsonEncode(the_json), headers: {
      'Authorization': 'Token 3c3e5a7a99bac8d802642ac15091ecc38c2d5a16'
    });
    print(response.body);
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    Constants.suggestion = jsonResponse['result']['result'];
    print(response.body);
    print(Constants.suggestion);
  }

  void apiSuggestionGeneral() async {
    var url1 = Uri.parse(
        'https://api.ubiops.com/v2.1/projects/smartwatch-recommende-system/deployments/grad-project-1/versions/v1-copy-01yuk-copy-t67m3-copy-nzqhr-copy-se58o/requests');
    var time_now = (new DateTime.now()).millisecondsSinceEpoch.toDouble();
    double sum = 0;
    double avgCal = 0;
    var i = 0;
    try {
      for (; i < 30; i++) {
        sum = sum + Constants.combinationCalories[-i].y;
      }
    } catch (error) {
      sum = 15;
      i = 10;
      print("error\n\n\n\n ${error}");
    }
    avgCal = sum / i;
    print("Avg Cal = ${avgCal}");
    sum = 0;
    double avgSteps = 0;
    i = 0;
    try {
      for (; i < 30; i++) {
        sum = sum + Constants.combinationSteps[-i].y;
      }
    } catch (error) {
      sum = 190;
      i = 10;
      print("error\n\n\n\n ${error}");
    }
    avgSteps = sum / i;
    print("Avg Steps = ${avgSteps}");

    var the_json = {
      "city": "Jerusalem",
      "heart-information": [],
      "medicine-name": "corgard",
      "phone-accelerometer": [
        time_now,
        time_now,
        avgSteps / 30,
        avgSteps / 28,
        avgSteps / 44
      ],
      "phone-gyroscope": [
        time_now,
        time_now,
        avgCal / 30,
        avgCal / 28,
        avgCal / 44
      ],
      "watch-accelerometer": [
        time_now,
        time_now,
        avgSteps / 30,
        avgSteps / 28,
        avgSteps / 44
      ],
      "watch-gyroscope": [
        time_now,
        time_now,
        avgCal / 30,
        avgCal / 28,
        avgCal / 44
      ]
      // "phone-accelerometer": [time_now, time_now, 0.2625152, 0.2625152, 0.2625152],
      // "phone-gyroscope": [time_now, time_now, 0.2625152, 0.2625152, 0.2625152],
      // "watch-accelerometer": [time_now, time_now, 0.2625152, 0.2625152, 0.2625152],
      // "watch-gyroscope": [time_now, time_now, 0.2625152, 0.2625152, 0.2625152]
    };
    Map<String, String> headers = {
      // 'url': url1.toString(),
      HttpHeaders.authorizationHeader:
          'Token 3c3e5a7a99bac8d802642ac15091ecc38c2d5a16',
      'input': the_json.toString(),
    };
    var response = await http.post(url1, body: jsonEncode(the_json), headers: {
      'Authorization': 'Token 3c3e5a7a99bac8d802642ac15091ecc38c2d5a16'
    });
    print(response.body);
    var jsonResponse =
        await convert.jsonDecode(response.body) as Map<String, dynamic>;
    Constants.suggestion2 = jsonResponse['result']['result'];
    print(response.body);
    print(Constants.suggestion2);
  }
}
