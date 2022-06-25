import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:t2/screens/auth/apiFitbit.dart';
import '../../constants/constants.dart';
import '../../user_state.dart';

class Health_informationScreen extends StatefulWidget {
  @override
  final String userID;

  const Health_informationScreen({required this.userID});

  _Health_informationScreenState createState() =>
      _Health_informationScreenState();
}

class _Health_informationScreenState extends State<Health_informationScreen>
    with TickerProviderStateMixin {
  int count = 0;
  int f = 0;
  var counterForMedicine = 0;
  var counterAll = 0;
  var counterAll_1 = 0;
  var counterOne = 0;
  var counterSecond = 0;
  var counterThird = 0;
  var counter_4 = 0;

  DateTime? picked;
  String _selectedTime = '8:00 AM';

  List<TextEditingController> _nameMedicineTextController = [];
  List<TextField> _nameMedicineFields = [];

  List<TextEditingController> _timeOoYouTakeMedicineTextController = [];
  List<TextField> _timeOoYouTakeMedicineFields = [];

  List<TextEditingController> _otherTimeOoYouTakeMedicineTextControllerOther =
      [];
  List<TextField> _otherTimeOoYouTakeMedicineFields = [];

  List<TextEditingController> _Date_for_startMedicineTextController = [];
  List<TextField> _Date_for_startMedicineFields = [];

  List<TextEditingController> _Date_for_endMedicineTextController = [];
  List<TextField> _Date_for_endFields = [];

  bool isVisibleForMedicineUnspecifiedTime = false;
  bool isVisibleForMedicineSpecifiedTime = false;

  @override
  void dispose() {
    for (final controller in _nameMedicineTextController) {
      controller.dispose();
    }
    for (final controller in _Date_for_startMedicineTextController) {
      controller.dispose();
    }
    for (final controller in _Date_for_endMedicineTextController) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
              MaterialButton(
                onPressed: () => setState(() =>
                    isVisibleForMedicineSpecifiedTime =
                        !isVisibleForMedicineSpecifiedTime),
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
                        'Specified Time',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
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
                height: 20,
              ),
              Visibility(
                visible: isVisibleForMedicineSpecifiedTime,
                child: Column(
                  children: [
                    _listView(),
                    _addTile(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () => setState(() =>
                    isVisibleForMedicineUnspecifiedTime =
                        !isVisibleForMedicineUnspecifiedTime),
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
                        'Unspecified Time',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
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
                height: 20,
              ),
              Visibility(
                visible: isVisibleForMedicineUnspecifiedTime,
                child: Column(
                  children: [
                    _listViewUnspecifiedTime(),
                    _addTileUnspecifiedTime(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
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
                        'Next',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    ));
  }

  void submitFormOnSignUp() async {

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (cix) => apiFitbit(),
    ));

    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         title: Row(
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Text('Welcome'),
    //             ),
    //           ],
    //         ),
    //         content: Text(
    //           'Thank you for information',
    //           style: TextStyle(
    //               color: Constants.darkBlue,
    //               fontSize: 20,
    //               fontStyle: FontStyle.italic),
    //         ),
    //         actions: [
    //           TextButton(
    //               onPressed: () {
    //                 Navigator.of(context).pushReplacement(MaterialPageRoute(
    //                   builder: (cix) => apiFitbit(),
    //                 ));
    //               },
    //               child: Text(
    //                 'OK',
    //                 style: TextStyle(color: Colors.red),
    //               ))
    //         ],
    //       );
    //     });
  }

  void submitFormOnSignUpTest() async {
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
                    print('uid ${widget.userID}');

                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                    //  print( _nameMedicineTextController.length );

                    // print('_nameMedicineTextController');
                    // for (int i = 0;
                    //     i < _nameMedicineTextController.length;
                    //     i++) {
                    //   print(_nameMedicineTextController[i].text);
                    // }
                    //
                    // print('_Date_for_startMedicineTextController');
                    // for (int i = 0;
                    //     i < _Date_for_startMedicineTextController.length;
                    //     i++) {
                    //   print(_Date_for_startMedicineTextController[i].text);
                    // }
                    //
                    // print('_Date_for_endMedicineTextController');
                    // for (int i = 0;
                    //     i < _Date_for_endMedicineTextController.length;
                    //     i++) {
                    //   print(_Date_for_endMedicineTextController[i].text);
                    // }
                    //
                    // print('_timeOoYouTakeMedicineTextController');
                    // for (int i = 0;
                    //     i < _timeOoYouTakeMedicineTextController.length;
                    //     i++) {
                    //   print(_timeOoYouTakeMedicineTextController[i].text);
                    // }
                    //
                    print('_otherTimeOoYouTakeMedicineTextControllerOther');
                    for (int i = 0;
                        i <
                            _otherTimeOoYouTakeMedicineTextControllerOther
                                .length;
                        i++) {
                      print(_otherTimeOoYouTakeMedicineTextControllerOther[i]
                          .text);
                    }
                    //
                    // ///// kjdfhl;dfahglkjsd
                    //
                    // print('_nameMedicineTextControllerUnspecifiedTime');
                    // for (int i = 0;
                    //     i < _nameMedicineTextControllerUnspecifiedTime.length;
                    //     i++) {
                    //   print(_nameMedicineTextControllerUnspecifiedTime[i].text);
                    // }
                    //
                    // print(
                    //     '_timeOoYouTakeMedicineTextControllerUnspecifiedTime');
                    // for (int i = 0;
                    //     i <
                    //         _timeOoYouTakeMedicineTextControllerUnspecifiedTime
                    //             .length;
                    //     i++) {
                    //   print(
                    //       _timeOoYouTakeMedicineTextControllerUnspecifiedTime[i]
                    //           .text);
                    // }
                    //
                    // print(
                    //     '_otherTimeOoYouTakeMedicineTextControllerOtherUnspecifiedTime');
                    // for (int i = 0;
                    //     i <
                    //         _otherTimeOoYouTakeMedicineTextControllerOtherUnspecifiedTime
                    //             .length;
                    //     i++) {
                    //   print(
                    //       _otherTimeOoYouTakeMedicineTextControllerOtherUnspecifiedTime[
                    //               i]
                    //           .text);
                    // }
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }

  ///// testtttttt sadlkfhj;lasdjhg;lkajshng;kjladfbnblkjnruibnfwsm;loknmvpwrbnt;smdnf;gn;mcnvitrhngad;g[oij;krtmgbn///

  Widget _listView() {
    //var i = _nameMedicineTextController.length;
    //var i = counterAll;
    final children = [
      // for (var i = counterAll_1; i <= _nameMedicineTextController.length; i++)
      if (counterAll_1 != 0)
        //var i =counterAll_1 ;
        Container(
          margin: EdgeInsets.all(5),
          child: InputDecorator(
            child: Column(
              children: [
                _nameMedicineFields[counterAll_1 - 1],
                SizedBox(
                  height: 15,
                ),
                _Date_for_startMedicineFields[counterAll_1 - 1],
                SizedBox(
                  height: 15,
                ),
                _Date_for_endFields[counterAll_1 - 1],
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _timeOoYouTakeMedicineFields[counterAll_1 - 1],
                      ),
                    ),
                    Expanded(child: _addTile_1()),
                    Expanded(child: _removeTile()),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                _listView_1(),
                //...getNewTextFormFields(),
              ],
            ),
            decoration: InputDecoration(
              labelText: counterAll_1.toString(),
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                gapPadding: 0.0,
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.red, width: 1.5),
              ),
            ),
          ),
        )
    ];
    // counterAll++;
    return SingleChildScrollView(
      child: Column(
        children: children,
      ),
    );
  }

  Widget _addTile() {
    return ListTile(
      title: Icon(
        Icons.add,
        color: Colors.white,
      ),
      onTap: () {
        if (f == 0) {
          final nameMedicine = TextEditingController();
          final timeOoYouTakeMedicine = TextEditingController();
          final Date_for_startMedicine = TextEditingController();
          final Date_for_endMedicine = TextEditingController();

          final nameField = _generateTextField(nameMedicine, "nameMedicine");
          final nameField_1 =
              _generateTextField3(timeOoYouTakeMedicine, _selectedTime);
          final telField = _generateTextField1(
              Date_for_startMedicine, "Date_for_startMedicine");
          final addressField =
              _generateTextField2(Date_for_endMedicine, "Date_for_endMedicine");

          setState(() {
            _nameMedicineTextController.add(nameMedicine);
            _Date_for_startMedicineTextController.add(Date_for_startMedicine);
            _Date_for_endMedicineTextController.add(Date_for_endMedicine);
            _timeOoYouTakeMedicineTextController.add(timeOoYouTakeMedicine);
            _timeOoYouTakeMedicineFields.add(nameField_1);
            _nameMedicineFields.add(nameField);
            _Date_for_startMedicineFields.add(telField);
            _Date_for_endFields.add(addressField);
            counterAll_1++;
            counterForMedicine++;
          });
        } else {
          _saveData(context);
        }
        counterAll = 0;
        f++;
      },
    );
  }

  void _saveData(context) {
    //final FirebaseAuth _auth = FirebaseAuth.instance;
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
              'save data before add',
              style: TextStyle(
                  color: Constants.darkBlue,
                  fontSize: 20,
                  fontStyle: FontStyle.italic),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  print('uid ${widget.userID}');
                  if (counterAll_1 != 0)
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.userID)
                        .update({
                      'name Medicine ${counterForMedicine} type 1':
                          _nameMedicineTextController[counterAll_1 - 1].text,
                      'time You Take for Medicine ${counterForMedicine} type 1':
                          _timeOoYouTakeMedicineTextController[counterAll_1 - 1]
                              .text,
                      'Date for start for Medicine ${counterForMedicine} type 1':
                          _Date_for_startMedicineTextController[
                                  counterAll_1 - 1]
                              .text,
                      'Date for end for Medicine ${counterForMedicine} type 1':
                          _Date_for_endMedicineTextController[counterAll_1 - 1]
                              .text,
                      for (int i = 0; i < _otherTimeOoYouTakeMedicineTextControllerOther.length; i++)
                        'other Time You Take for Medicine ${counterForMedicine} ${i + 1} type 1': _otherTimeOoYouTakeMedicineTextControllerOther[i].text,
                    });

                  for (var i = _otherTimeOoYouTakeMedicineFields.length; i > 0; i--) {
                    print(_otherTimeOoYouTakeMedicineFields.length);
                    setState(() {
                      _otherTimeOoYouTakeMedicineFields.removeAt(_otherTimeOoYouTakeMedicineFields.length - 1);
                      _otherTimeOoYouTakeMedicineTextControllerOther.removeAt(_otherTimeOoYouTakeMedicineTextControllerOther.length - 1);
                      });
                  }
                  counter_4 = 0 ;
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                  print('test jast save');
                },
                child: Text('save'),
              ),
              TextButton(
                  onPressed: () async {
                    print('uid ${widget.userID}');
                    if (counterAll_1 != 0)
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.userID)
                          .update({
                        'name Medicine ${counterForMedicine} type 1':
                            _nameMedicineTextController[counterAll_1 - 1].text,
                        'time You Take for Medicine ${counterForMedicine} type 1':
                            _timeOoYouTakeMedicineTextController[
                                    counterAll_1 - 1]
                                .text,
                        'Date for start for Medicine ${counterForMedicine} type 1':
                            _Date_for_startMedicineTextController[
                                    counterAll_1 - 1]
                                .text,
                        'Date for end for Medicine ${counterForMedicine} type 1':
                            _Date_for_endMedicineTextController[
                                    counterAll_1 - 1]
                                .text,
                        'Date for end for Medicine ${counterForMedicine} type 1':
                            _Date_for_endMedicineTextController[
                                    counterAll_1 - 1]
                                .text,
                        for (int i = 0;
                            i <
                                _otherTimeOoYouTakeMedicineTextControllerOther
                                    .length;
                            i++)
                          'other Time You Take for Medicine${counterForMedicine} ${i + 1} type 1':
                              _otherTimeOoYouTakeMedicineTextControllerOther[i]
                                  .text,
                      });


                    final nameMedicine = TextEditingController();
                    final timeOoYouTakeMedicine = TextEditingController();
                    final Date_for_startMedicine = TextEditingController();
                    final Date_for_endMedicine = TextEditingController();

                    final nameField =
                        _generateTextField(nameMedicine, "nameMedicine");
                    final nameField_1 = _generateTextField3(
                        timeOoYouTakeMedicine, _selectedTime);
                    final telField = _generateTextField1(
                        Date_for_startMedicine, "Date_for_startMedicine");
                    final addressField = _generateTextField2(
                        Date_for_endMedicine, "Date_for_endMedicine");

                    setState(() {
                      _nameMedicineTextController.add(nameMedicine);
                      _Date_for_startMedicineTextController.add(
                          Date_for_startMedicine);
                      _Date_for_endMedicineTextController.add(
                          Date_for_endMedicine);
                      _timeOoYouTakeMedicineTextController
                          .add(timeOoYouTakeMedicine);
                      _timeOoYouTakeMedicineFields.add(nameField_1);
                      _nameMedicineFields.add(nameField);
                      _Date_for_startMedicineFields.add(telField);
                      _Date_for_endFields.add(addressField);

                      for (var i = _otherTimeOoYouTakeMedicineFields.length; i > 0; i--) {
                        print(_otherTimeOoYouTakeMedicineFields.length);
                        setState(() {
                          _otherTimeOoYouTakeMedicineFields.removeAt(_otherTimeOoYouTakeMedicineFields.length - 1);
                          _otherTimeOoYouTakeMedicineTextControllerOther.removeAt(_otherTimeOoYouTakeMedicineTextControllerOther.length - 1);
                        });
                      }
                      counter_4 = 0 ;
                      counterAll_1++;
                      counterForMedicine++;
                    });

                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                    // print(newTextField);
                    print('save amd add other ');
                  },
                  child: Text(
                    'save and add other',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }

  Future<void> _openTimePicker(BuildContext context) async {
    final TimeOfDay? t =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (t != null) {
      setState(() {
        _timeOoYouTakeMedicineTextController[counterThird].text =
            t.format(context);
        _selectedTime = t.format(context);
        counterThird++;
      });
    }
  }

  Future<void> _openTimePicker_1(BuildContext context) async {
    final TimeOfDay? t =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (t != null) {
      setState(() {
        _otherTimeOoYouTakeMedicineTextControllerOther[counter_4].text =
            t.format(context);
        _selectedTime = t.format(context);
        counter_4++;
      });
    }
  }

  void _pickDateStart() async {
    picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920),
        lastDate: DateTime.now());

    if (picked != null) {
      setState(() {
        //_Date_for_startMedicineTextController.length-1
        _Date_for_startMedicineTextController[counterOne].text =
            '${picked!.year}-${picked!.month}-${picked!.day}';
        counterOne++;
      });
    }
  }

  void _pickDateEnd() async {
    picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(days: 2)),
        firstDate: DateTime(1920),
        lastDate: DateTime(2050));

    if (picked != null) {
      setState(() {
        //_Date_for_endMedicineTextController.length-1
        _Date_for_endMedicineTextController[counterSecond].text =
            '${picked!.year}-${picked!.month}-${picked!.day}';
        counterSecond++;
      });
    }
  }

  TextField _generateTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 0.0,
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
          labelText: hint,
          labelStyle: TextStyle(
            color: Colors.white,
          )),
    );
  }

  TextField _generateTextField1(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      onTap: () {
        _pickDateStart();
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 0.0,
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
          labelText: hint,
          labelStyle: TextStyle(
            color: Colors.white,
          )),
    );
  }

  TextField _generateTextField2(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      onTap: () {
        _pickDateEnd();
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 0.0,
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
          labelText: hint,
          labelStyle: TextStyle(
            color: Colors.white,
          )),
    );
  }

  TextField _generateTextField3(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      onTap: () {
        _openTimePicker(context);
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 0.0,
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
          labelText: hint,
          labelStyle: TextStyle(
            color: Colors.white,
          )),
    );
  }

  TextField _generateTextField4(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      onTap: () {
        _openTimePicker_1(context);
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 0.0,
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
          //hintText: '${i + 1} Text field',
          labelText: hint,
          labelStyle: TextStyle(
            color: Colors.white,
          )),
    );
  }

  Widget _listView_1() {
    final children = [
      for (var i = 0; i < _otherTimeOoYouTakeMedicineFields.length; i++)
        Container(
          margin: EdgeInsets.all(5),
          child: InputDecorator(
            child: Column(
              children: [
                _otherTimeOoYouTakeMedicineFields[i],
              ],
            ),
            decoration: InputDecoration(
              labelText: i.toString(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        )
    ];
    return SingleChildScrollView(
      child: Column(
        children: children,
      ),
    );
  }

  Widget _addTile_1() {
    return ListTile(
      title: Icon(
        Icons.add_circle,
        color: Colors.green,
        size: 30,
      ),
      onTap: () {
        final timeOoYouTakeMedicinee = TextEditingController();
        final nameField_1 =
            _generateTextField4(timeOoYouTakeMedicinee, _selectedTime);

        setState(() {
          _otherTimeOoYouTakeMedicineTextControllerOther
              .add(timeOoYouTakeMedicinee);
          _otherTimeOoYouTakeMedicineFields.add(nameField_1);
        });
      },
    );
  }

  Widget _removeTile() {
    return IconButton(
      onPressed: () {
        if (_otherTimeOoYouTakeMedicineFields.length != 0) {
          print(_otherTimeOoYouTakeMedicineFields.length);
          setState(() {
            _otherTimeOoYouTakeMedicineFields
                .removeAt(_otherTimeOoYouTakeMedicineFields.length - 1);
          });
        }
        // }
      },
      icon: Icon(
        Icons.remove_circle,
        color: Colors.red,
        size: 30,
      ),
    );
  }

//////// dsfkjgh;sdkljfhg;lskjdhfgkjsnbnfgiguh;slkgnhb;fngiufshfgkjhbosijtrfnhjnfgbjinw;r

  var counterAllUnspecifiedTime = 0;
  var counterForMedicineUnspecifiedTime = 0;

  var counterAll_1UnspecifiedTime = 0;
  var counterOneUnspecifiedTime = 0;
  var counterSecondUnspecifiedTime = 0;
  var counterThirdUnspecifiedTime = 0;
  var counter_4UnspecifiedTime = 0;

  int f_UnspecifiedTime = 0;

  List<TextEditingController> _nameMedicineTextControllerUnspecifiedTime = [];
  List<TextField> _nameMedicineFieldsUnspecifiedTime = [];

  List<TextEditingController>
      _timeOoYouTakeMedicineTextControllerUnspecifiedTime = [];
  List<TextField> _timeOoYouTakeMedicineFieldsUnspecifiedTime = [];

  List<TextEditingController>
      _otherTimeOoYouTakeMedicineTextControllerOtherUnspecifiedTime = [];
  List<TextField> _otherTimeOoYouTakeMedicineFieldsUnspecifiedTime = [];

  Widget _listViewUnspecifiedTime() {
    final children = [
      if (counterAll_1UnspecifiedTime != 0)
        //var i =counterAll_1 ;
        Container(
          margin: EdgeInsets.all(5),
          child: InputDecorator(
            child: Column(
              children: [
                _nameMedicineFieldsUnspecifiedTime[
                    counterAll_1UnspecifiedTime - 1],
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _timeOoYouTakeMedicineFieldsUnspecifiedTime[
                            counterAll_1UnspecifiedTime - 1],
                      ),
                    ),
                    Expanded(child: _addTile_1UnspecifiedTime()),
                    Expanded(child: _removeTileUnspecifiedTime()),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                _listView_1UnspecifiedTime(),
                //...getNewTextFormFields(),
              ],
            ),
            decoration: InputDecoration(
              labelText: counterAll_1UnspecifiedTime.toString(),
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                gapPadding: 0.0,
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.red, width: 1.5),
              ),
            ),
          ),
        )
    ];
    // counterAll++;
    return SingleChildScrollView(
      child: Column(
        children: children,
      ),
    );
  }

  Widget _addTileUnspecifiedTime() {
    return ListTile(
      title: Icon(
        Icons.add,
        color: Colors.white,
      ),
      onTap: () {
        if (f_UnspecifiedTime == 0) {
          final nameMedicine = TextEditingController();
          final timeOoYouTakeMedicine = TextEditingController();

          final nameField =
              _generateTextFieldUnspecifiedTime(nameMedicine, "nameMedicine");
          final nameField_1 = _generateTextField3UnspecifiedTime(
              timeOoYouTakeMedicine, _selectedTime);

          setState(() {
            _nameMedicineTextControllerUnspecifiedTime.add(nameMedicine);
            _timeOoYouTakeMedicineTextControllerUnspecifiedTime
                .add(timeOoYouTakeMedicine);
            _timeOoYouTakeMedicineFieldsUnspecifiedTime.add(nameField_1);
            _nameMedicineFieldsUnspecifiedTime.add(nameField);

            counterAll_1UnspecifiedTime++;
          });
        } else {
          _saveDataUnspecifiedTime(context);
        }
        counterAllUnspecifiedTime = 0;
        f_UnspecifiedTime++;
      },
    );
  }

  Widget _listView_1UnspecifiedTime() {
    final children = [
      for (var i = 0;
          i < _otherTimeOoYouTakeMedicineFieldsUnspecifiedTime.length;
          i++)
        Container(
          margin: EdgeInsets.all(5),
          child: InputDecorator(
            child: Column(
              children: [
                _otherTimeOoYouTakeMedicineFieldsUnspecifiedTime[i],
              ],
            ),
            decoration: InputDecoration(
              labelText: i.toString(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        )
    ];
    return SingleChildScrollView(
      child: Column(
        children: children,
      ),
    );
  }

  Widget _addTile_1UnspecifiedTime() {
    return ListTile(
      title: Icon(
        Icons.add_circle,
        color: Colors.green,
        size: 30,
      ),
      onTap: () {
        final timeOoYouTakeMedicine = TextEditingController();
        final nameField_1 = _generateTextField4UnspecifiedTime(
            timeOoYouTakeMedicine, _selectedTime);

        setState(() {
          _otherTimeOoYouTakeMedicineTextControllerOtherUnspecifiedTime
              .add(timeOoYouTakeMedicine);
          _otherTimeOoYouTakeMedicineFieldsUnspecifiedTime.add(nameField_1);
        });
      },
    );
  }

  Widget _removeTileUnspecifiedTime() {
    return IconButton(
      onPressed: () {
        if (_otherTimeOoYouTakeMedicineFieldsUnspecifiedTime.length != 0) {
          print(_otherTimeOoYouTakeMedicineFieldsUnspecifiedTime.length);
          setState(() {
            _otherTimeOoYouTakeMedicineFieldsUnspecifiedTime.removeAt(
                _otherTimeOoYouTakeMedicineFieldsUnspecifiedTime.length - 1);
          });
        }
        // }
      },
      icon: Icon(
        Icons.remove_circle,
        color: Colors.red,
        size: 30,
      ),
    );
  }

  void _saveDataUnspecifiedTime(context) {
    //final FirebaseAuth _auth = FirebaseAuth.instance;
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
              'save data before add',
              style: TextStyle(
                  color: Constants.darkBlue,
                  fontSize: 20,
                  fontStyle: FontStyle.italic),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  print('uid ${widget.userID}');
                  if (counterAll_1UnspecifiedTime != 0)
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.userID)
                        .update({
                      'name Medicine ${counterForMedicineUnspecifiedTime+1} type 2':
                          _nameMedicineTextControllerUnspecifiedTime[
                                  counterAll_1UnspecifiedTime - 1]
                              .text,
                      'time You Take for Medicine ${counterForMedicineUnspecifiedTime+1} type 2':
                          _timeOoYouTakeMedicineTextControllerUnspecifiedTime[
                                  counterAll_1UnspecifiedTime - 1]
                              .text,
                      for (int i = 0;
                          i <
                              _otherTimeOoYouTakeMedicineTextControllerOtherUnspecifiedTime
                                  .length;
                          i++)
                        'other Time You Take for Medicine${counterForMedicineUnspecifiedTime+1} ${i + 1} type 2':
                            _otherTimeOoYouTakeMedicineTextControllerOtherUnspecifiedTime[
                                    i]
                                .text,
                    });

                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                  print('test jast save');
                },
                child: Text('save'),
              ),
              TextButton(
                  onPressed: () async {
                    print('uid ${widget.userID}');
                    if (counterAll_1UnspecifiedTime != 0)
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.userID)
                          .update({
                        'name Medicine ${counterForMedicineUnspecifiedTime+1} type 2':
                            _nameMedicineTextControllerUnspecifiedTime[
                                    counterAll_1UnspecifiedTime - 1]
                                .text,
                        'time You Take for Medicine ${counterForMedicineUnspecifiedTime+1} type 2':
                            _timeOoYouTakeMedicineTextControllerUnspecifiedTime[
                                    counterAll_1UnspecifiedTime - 1]
                                .text,
                        for (int i = 0;
                            i <
                                _otherTimeOoYouTakeMedicineTextControllerOtherUnspecifiedTime
                                    .length;
                            i++)
                          'other Time You Take for Medicine${counterForMedicineUnspecifiedTime+1} ${i + 1} type 2':
                              _otherTimeOoYouTakeMedicineTextControllerOtherUnspecifiedTime[
                                      i]
                                  .text,
                      });

                    final nameMedicine = TextEditingController();
                    final timeOoYouTakeMedicine = TextEditingController();
                    final nameField = _generateTextFieldUnspecifiedTime(
                        nameMedicine, "nameMedicine");
                    final nameField_1 = _generateTextField3UnspecifiedTime(
                        timeOoYouTakeMedicine, _selectedTime);

                    setState(() {
                      _nameMedicineTextControllerUnspecifiedTime
                          .add(nameMedicine);
                      _timeOoYouTakeMedicineTextControllerUnspecifiedTime
                          .add(timeOoYouTakeMedicine);
                      _timeOoYouTakeMedicineFieldsUnspecifiedTime
                          .add(nameField_1);
                      _nameMedicineFieldsUnspecifiedTime.add(nameField);

                      for (var i =
                              _otherTimeOoYouTakeMedicineFieldsUnspecifiedTime
                                  .length;
                          i > 0;
                          i--) {
                        print(_otherTimeOoYouTakeMedicineFieldsUnspecifiedTime
                            .length);
                        setState(() {
                          _otherTimeOoYouTakeMedicineFieldsUnspecifiedTime
                              .removeAt(
                                  _otherTimeOoYouTakeMedicineFieldsUnspecifiedTime
                                          .length -
                                      1);
                        });
                      }
                      counterAll_1UnspecifiedTime++;
                      counterForMedicineUnspecifiedTime++;
                    });

                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                    // print(newTextField);
                    print('save amd add other ');
                  },
                  child: Text(
                    'save and add other',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }

  TextField _generateTextField4UnspecifiedTime(
      TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      onTap: () {
        _openTimePicker_1UnspecifiedTime(context);
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 0.0,
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
          //hintText: '${i + 1} Text field',
          labelText: hint,
          labelStyle: TextStyle(
            color: Colors.white,
          )),
    );
  }

  TextField _generateTextField3UnspecifiedTime(
      TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      onTap: () {
        _openTimePickerUnspecifiedTime(context);
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 0.0,
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
          labelText: hint,
          labelStyle: TextStyle(
            color: Colors.white,
          )),
    );
  }

  TextField _generateTextFieldUnspecifiedTime(
      TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 0.0,
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
          labelText: hint,
          labelStyle: TextStyle(
            color: Colors.white,
          )),
    );
  }

  Future<void> _openTimePickerUnspecifiedTime(BuildContext context) async {
    final TimeOfDay? t =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (t != null) {
      setState(() {
        _timeOoYouTakeMedicineTextControllerUnspecifiedTime[
                counterThirdUnspecifiedTime]
            .text = t.format(context);
        _selectedTime = t.format(context);
        counterThirdUnspecifiedTime++;
      });
    }
  }

  Future<void> _openTimePicker_1UnspecifiedTime(BuildContext context) async {
    final TimeOfDay? t =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (t != null) {
      setState(() {
        _otherTimeOoYouTakeMedicineTextControllerOtherUnspecifiedTime[
                counter_4UnspecifiedTime]
            .text = t.format(context);
        _selectedTime = t.format(context);
        counter_4UnspecifiedTime++;
      });
    }
  }
}
