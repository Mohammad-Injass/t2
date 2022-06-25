import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../widgets/drawer_widget.dart';
import 'dart:async';
import 'package:t2/constants/constants.dart';


class AllInformationScreen extends StatefulWidget {
  final String userID;

  const AllInformationScreen({required this.userID});

  @override
  _AllInformationScreenState createState() => _AllInformationScreenState();
}

class _AllInformationScreenState extends State<AllInformationScreen> {
  String email = "";
  String name = "";
  String phoneNumber = "";
  String joinedAt = "";
  String height = "";
  String weight = "";
  String DateOfBirth = "";
  String haveChronicDisease = "";

  List<String> medicineFieldsType_1 = [];
  List<String> medicineFieldsType_2 = [];

   String medicineType_1 = "" ;
  String medicineType_2 = "" ;

  List array1 = [];
  List array2 = [];

  // var nameMedicineFields = [];

  @override
  void initState() {
    super.initState();
    // Api();
    getMedicineType_1(widget.userID);
    getMedicineType_2(widget.userID);
    getUserDate();
    // for(int i =0 ; i < nameMedicineFields.length ; i++ )
    // print(nameMedicineFields[i]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'All Information ',
          style: TextStyle(color: Colors.pink),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            children: [
              Card(
                margin: EdgeInsets.all(30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child:
                        Text(//'cf'
                            name == null ? "" : name,
                            style: titleTextStyle,
                            ),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      //
                      // Divider(
                      //   thickness: 5,
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // Text(
                      //   'Info',
                      //   style: titleTextStyle,
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // socialInfo(label: 'Email:', content: email),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // socialInfo(label: 'Phone number:', content: phoneNumber),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // socialInfo(label: 'height:', content: height),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // socialInfo(label: 'weight:', content: weight),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // // socialInfo(label: 'Date of Birth:', content: DateOfBirth),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // socialInfo(label: 'Email:', content: email),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // socialInfo(label: 'Phone number:', content: phoneNumber),
                      SizedBox(
                        height: 30,
                      ),
                      socialInfo(label: 'have Chronic Disease:', content: haveChronicDisease),
                      SizedBox(
                        height: 50,
                      ),
                      socialInfoM(
                          label: '  Medicine Specified Time',
                          content: '''${medicineType_1}'''),
                      SizedBox(
                        height: 10,
                      ),
                      socialInfoM(
                          label: '  Medicine Unspecified Time',
                          content: '''${medicineType_2}'''),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var titleTextStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );

  Widget socialInfo({required String label, required String content}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              content,
              style: TextStyle(
                color: Constants.darkBlue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget socialInfoM({required String label, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              content,
              style: TextStyle(
                color: Constants.darkBlue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ),
      ],
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
          //  getM( widget.userID , 2);

          name = userDoc.get('name');
          email = userDoc.get('email');
          phoneNumber = userDoc.get('phone');
          weight = userDoc.get('weight');
          height = userDoc.get('height');

          haveChronicDisease = userDoc.get('have Chronic Disease');
        });
      }
    } catch (err) {
    } finally {
      setState(() {});
    }
  }

  Future<void> getMedicineType_1(String userID) async {
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();
    String m;
    String d;
    // name Medicine 1 type 1
    // name Medicine 2 type 1
    // Date for end for Medicine 1 type 1
    // Date for start for Medicine 1 type 1
    // time You Take for Medicine 1 type 1
    // other Time You Take for Medicine 3 2 type 1

    int y = 1;
    int x = 1;
    while (true) {
      try {
        m = userDoc.get('name Medicine $y type 1');
        if (m != null) {
          medicineFieldsType_1.add(m);
          // print("${nameMedicineFields}");
          d = userDoc.get('Date for start for Medicine $y type 1');
          medicineFieldsType_1.add(d);
          // print("${nameMedicineFields}");
          d = userDoc.get('Date for end for Medicine $y type 1');
          medicineFieldsType_1.add(d);
          //  print("${nameMedicineFields}");
          d = userDoc.get('time You Take for Medicine $y type 1');
          medicineFieldsType_1.add(d);
          //  print("${nameMedicineFields}");

          while (true) {
            try {
              d = userDoc.get('other Time You Take for Medicine$y $x type 1');
              if (d != null) {
                medicineFieldsType_1.add(d);
                //  print("${nameMedicineFields}");

                x++;
              } else {
                break;
              }
            } catch (err) {
              print('done 00 ');
              x = 1;
              break;
            }
          }
          print("${medicineFieldsType_1}");
          medicineFieldsType_1.add("\n");
          y++;
        } else {
          break;
        }
      } catch (err) {
        print('done ');
        break;
      }

    }
    medicineType_1 = medicineFieldsType_1.toString();
    medicineType_1 = medicineType_1.substring(1,medicineType_1.length-1);
  }

  Future<void> getMedicineType_2(String userID) async {
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();

    String m;
    String d;
    int y = 1;
    int x = 1;

    while (true) {
      try {
        m = userDoc.get('name Medicine $y type 2');
        if (m != null) {
          medicineFieldsType_2.add(m);
          // print("${nameMedicineFields}");
          d = userDoc.get('time You Take for Medicine $y type 2');
          medicineFieldsType_2.add(d);
          //  print("${nameMedicineFields}");
          while (true) {
            try {
              d = userDoc.get('other Time You Take for Medicine$y $x type 2');
              if (d != null) {
                medicineFieldsType_2.add(d);
                //  print("${nameMedicineFields}");
                x++;
              } else {
                break;
              }
            } catch (err) {
              print('done 00 ');
              x = 1;
              break;
            }
          }
          print("${medicineFieldsType_2}");
          medicineFieldsType_2.add("\n");
          y++;

        } else {
          break;
        }
      } catch (err) {
        print('done ');
        break;
      }
    }
    medicineType_2 = medicineFieldsType_2.toString();
    medicineType_2 = medicineType_2.substring(1,medicineType_2.length-1);
  }

//   void Api() async {
//     // var dio = Dio();
//     // final response = await dio.get('http://api.openweathermap.org/geo/1.0/direct?&appid=de31ed3287a3444805bcb24c21789ebc&limit=2&q= Jerusalem');
//     // print(response.data);
//     //
//     var currDt = DateTime.now();
//     String date = currDt.toString().substring(0,10);
//     //print(date);
//     //
//     // var headers = {
//     //   'accept': 'application/json',
//     //   'authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMzhNQkYiLCJzdWIiOiI5WERXTkoiLCJpc3MiOiJGaXRiaXQiLCJ0eXAiOiJhY2Nlc3NfdG9rZW4iLCJzY29wZXMiOiJ3aHIgd3BybyB3bnV0IHdzbGUgd3dlaSB3c29jIHdzZXQgd2FjdCB3b3h5IHdsb2Mgd3JlcyIsImV4cCI6MTY1ODYwNTI4NCwiaWF0IjoxNjU2MDEzMjg0fQ.mgCSmvZcxY2O9jhTAiZIOKs7bjtM36Qrh7mU2PiltlA',
//     // };
//     // var url = Uri.parse('https://api.fitbit.com/1/user/-/activities/heart/date/${date}/1d.json');
//     // var res = await http.get(url, headers: headers);
//     // if (res.statusCode != 200) throw Exception('http.get error: statusCode= ${res.statusCode}');
//
//     // var headers = {
//     //   'accept': 'application/json',
//     //   'authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMzhNQkYiLCJzdWIiOiI5WERXTkoiLCJpc3MiOiJGaXRiaXQiLCJ0eXAiOiJhY2Nlc3NfdG9rZW4iLCJzY29wZXMiOiJ3aHIgd3BybyB3bnV0IHdzbGUgd3dlaSB3c29jIHdzZXQgd2FjdCB3b3h5IHdsb2Mgd3JlcyIsImV4cCI6MTY1ODYwNTI4NCwiaWF0IjoxNjU2MDEzMjg0fQ.mgCSmvZcxY2O9jhTAiZIOKs7bjtM36Qrh7mU2PiltlA',
//     // };
//
//     // var url = Uri.parse('https://api.fitbit.com/1/user/-/activities/heart/date/${date}/1d.json');
//     // var res = await http.get(url, headers: headers);
//     // if (res.statusCode == 200) {
//     //   var jsonResponse =
//     //   convert.jsonDecode(res.body) as Map<String, dynamic>;
//     //   var itemCount = jsonResponse['activities-heart'][0]['value']['heartRateZones'][0];
//     //    print( jsonResponse);
//     // } else {
//     //   print('Request failed with status: ${res.statusCode}.');
//     // }
//
//
//
//     // This example uses the Google Books API to search for books about http.
//     // https://developers.google.com/books/docs/overview
//     var headers = {
//       'accept': 'application/json',
//       'authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMzhNQkYiLCJzdWIiOiI5WERXTkoiLCJpc3MiOiJGaXRiaXQiLCJ0eXAiOiJhY2Nlc3NfdG9rZW4iLCJzY29wZXMiOiJ3aHIgd3BybyB3bnV0IHdzbGUgd3dlaSB3c29jIHdzZXQgd2FjdCB3b3h5IHdsb2Mgd3JlcyIsImV4cCI6MTY1ODYwNTI4NCwiaWF0IjoxNjU2MDEzMjg0fQ.mgCSmvZcxY2O9jhTAiZIOKs7bjtM36Qrh7mU2PiltlA',
//     };
//
//     var url = Uri.parse('https://api.fitbit.com/1/user/-/activities/heart/date/${date}/1d.json');
//     var res = await http.get(url, headers: headers);
//     if (res.statusCode == 200) {
//       var jsonResponse =
//       convert.jsonDecode(res.body) as Map<String, dynamic>;
// //     var itemCount = jsonResponse['activities-heart'][0]['value']['heartRateZones'][0];
//       var itemCount = jsonResponse['activities-heart-intraday']['dataset'];
//       int count = 0;
//
//       while(true){
//         try{
//           var temp = itemCount[count]['time'];
//           double value = double.parse(itemCount[count]['value'].toString());
//           int hours = int.parse(temp.toString().substring(0,1));
//           int minutes = int.parse(temp.toString().substring(3,5));
//           var time = hours + (minutes/60);
//           time*=10;
//           Constants.combination.add(FlSpot(time,value));
//         }
//         catch(test)
//         {
//           break;
//         }
//         count++;
//       }
//       // print(array1);
//       // print(count);
//       // print("TESTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTtt");
//       // print(array2);
//       // print(array1.length);
//       // print(array2.length);
//
// //     print( itemCount);
//     } else {
//       print('Request failed with status: ${res.statusCode}.');
//     }
//    // print(res.body);
//   }

}
