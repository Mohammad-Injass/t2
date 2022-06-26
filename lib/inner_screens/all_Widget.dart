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
    apiSuggestion();
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
          'all Widget',
          style: TextStyle(color: Colors.pink),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Text('test : allWidget'),
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

  void apiSuggestion() async {
    var url1 = Uri.parse(
        'https://api.ubiops.com/v2.1/projects/smartwatch-recommende-system/deployments/grad-project-1/versions/v1-copy-01yuk-copy-t67m3-copy-nzqhr-copy-se58o/requests');

    var the_json = {
      "city": "Jerusalem",
      "heart-information": [13212312312, 77, 88.5],
      "medicine-name": "Corgard",
      "phone-accelerometer": [43243523, 43245643, 0.675643, 0.23435, 0.87654],
      "phone-gyroscope": [43243523, 43245643, 0.675643, 0.23435, 0.87654],
      "watch-accelerometer": [43243523, 43245643, 0.675643, 0.23435, 0.87654],
      "watch-gyroscope": [43243523, 43245643, 0.675643, 0.23435, 0.87654]
    };
    Map<String, String> headers = {
      // 'url': url1.toString(),
      HttpHeaders.authorizationHeader:
          'Token 3c3e5a7a99bac8d802642ac15091ecc38c2d5a16',
      'input': the_json.toString(),
    };
    var response = await http.post(
      url1,
    body: jsonEncode(the_json),
      headers: {'Authorization':'Token 3c3e5a7a99bac8d802642ac15091ecc38c2d5a16'}
    );
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    Constants.suggestion = jsonResponse['result']['result'];
    print(response.body);
    print(Constants.suggestion);
    // var request = new http.MultipartRequest("post", url1);
    // request.headers.addAll(headers);
    // request.fields['city'] = "Jerusalem";
    // request.fields['heart-information'] = jsonEncode([13212312312, 77, 88.5]);
    // request.fields['medicine-name'] = "congard";
    // request.fields['phone-accelerometer'] =
    // jsonEncode([43243523, 43245643, 0.675643, 0.23435, 0.87654]);
    //
    // request.fields['phone-gyroscope'] =
    //     jsonEncode([43243523, 43245643, 0.675643, 0.23435, 0.87654]);
    // request.fields['watch-accelerometer'] =
    // jsonEncode([43243523, 43245643, 0.675643, 0.23435, 0.87654]);
    // request.fields['watch-gyroscope'] =
    //     jsonEncode([43243523, 43245643, 0.675643, 0.23435, 0.87654]);
    // http.Response response =
    // await http.Response.fromStream(await request.send());
    // print(response.body);
    // http.post(url1);
    // http.post(url1,headers: headers,body: the_json.toString());
    // var res = await http.post(url1, body: headers.toString());
    // if (res.statusCode == 200) {
    //   print(res.body);
    //   var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
    //   Constants.suggestion = jsonResponse.values.toString();
    //   for (var i in jsonResponse.entries) {
    //     print(i.toString());
    //   }
    //   print('Uploaded! ${response.body} ++ ${response.statusCode}');
    //   print(Constants.suggestion);
    // } else {
    //   print('Request failed with status: ${res.statusCode},${res.body} ');
    // }
  }
}
