
import 'package:flutter/material.dart';
import 'package:t2/constants/constants.dart';
import 'package:t2/user_state.dart';

class apiFitbit extends StatefulWidget {
  @override
  _apiFitbit createState() => _apiFitbit();
}

class _apiFitbit extends State<apiFitbit>
    with TickerProviderStateMixin {

  late TextEditingController _apiforSmartwatchController =
  TextEditingController(text: '');

  @override
  void dispose() {
    _apiforSmartwatchController.dispose();

    super.dispose();
  }

  @override
  void initState() {

    super.initState();
  }
  //
  // void _forgetpasswordFCT() {
  //   // print('_forgetPasswordController.text ${_forgetPasswordController.text}');
  // }

  void submitFormOnSignUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Welcome'),
                ),
              ],
            ),
            content: Text(
              'Thank you for information',
              style: TextStyle(
                  color: Constants.darkBlue,
                  fontSize: 20,
                  fontStyle: FontStyle.italic),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (cix) => UserState(),
                    ));
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }

  void watchVideo(){
    print('the video is start');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.red,
        body: Stack(
          children: [
            Image(
              image: AssetImage('assets/images/image3.jpg'),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Text(
                    'Connect the smartwatch',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'api for smartwatch',
                    style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextField(
                      controller: _apiforSmartwatchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink.shade700),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  MaterialButton(
                    onPressed: submitFormOnSignUp,
                    color: Colors.pink.shade700,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                        side: BorderSide.none),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            'Connecting now',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 80,
                  ),
                  Column(
                    children: [
                      // Text(
                      //   'If you don\'t know how get api',
                      //   style: TextStyle(
                      //       fontSize: 18,
                      //       fontStyle: FontStyle.italic,
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      SizedBox(
                        height : 30,
                      ),
                      MaterialButton(
                        onPressed: watchVideo,
                        color: Colors.pink.shade700,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                            side: BorderSide.none),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Text(
                                '''\t\t\t\t\t\t\t\t\t\t If you don\'t know how get api \n Press here to Watch video help you get it ''',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
