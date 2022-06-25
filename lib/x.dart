import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DynamicTextFieldView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView(
        children: [

          _View3(),

        ],
      ),
    );
  }

}
class _View3 extends StatefulWidget {
  @override
  _View3State createState() => _View3State();
}

class _View3State extends State<_View3> {

  var counterAll = 0 ;
  var counterOne = 0 ;
  var counterSecond = 0 ;
  var counterThird = 0 ;

  DateTime? picked;
  String _selectedTime = '8:00 AM';


  List<TextEditingController> _nameMedicineTextController = [];
  List<TextField> _nameMedicineFields = [];

  List<TextEditingController> _timeOoYouTakeMedicineTextController = [];
  List<TextField> _timeOoYouTakeMedicineFields = [];

  List<TextEditingController> _otherTimeOoYouTakeMedicineTextControllerOther = [];
  List<TextField> _otherTimeOoYouTakeMedicineFields = [];

  List<TextEditingController> _Date_for_startMedicineTextController = [];
  List<TextField> _Date_for_startMedicineFields = [];

  List<TextEditingController> _Date_for_endMedicineTextController = [];
  List<TextField> _Date_for_endFields = [];

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
  //  _okController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Dynamic Group Text Field"),
          ),
          body: Column(

            children: [
              _addTile(),
             // _addTile_1(),
              Expanded(child: SingleChildScrollView(child: Column(
                children: [
                  _listView(),
                 // _addTile_1(),
                  _listView_1(),
                ],
              ))),
            //  _addTile_1(),
            //  Expanded(child: _listView_1()),

             // _okButton(context),
            ],
          )),
    );
  }

  Widget _addTile() {
    return ListTile(
      title: Icon(Icons.add),
      onTap: () {
        final nameMedicine = TextEditingController();
        final timeOoYouTakeMedicine = TextEditingController();
        final Date_for_startMedicine = TextEditingController();
        final Date_for_endMedicine = TextEditingController();

        final nameField = _generateTextField(nameMedicine, "nameMedicine");
        final nameField_1 = _generateTextField3(timeOoYouTakeMedicine, _selectedTime);
        final telField = _generateTextField1(Date_for_startMedicine, "Date_for_startMedicine");
        final addressField = _generateTextField2(Date_for_endMedicine, "Date_for_endMedicine");

        setState(() {
          _nameMedicineTextController.add(nameMedicine);
          _Date_for_startMedicineTextController.add(Date_for_startMedicine);
          _Date_for_endMedicineTextController.add(Date_for_endMedicine);
          _timeOoYouTakeMedicineTextController.add(timeOoYouTakeMedicine);
          _timeOoYouTakeMedicineFields.add(nameField_1);
          _nameMedicineFields.add(nameField);
          _Date_for_startMedicineFields.add(telField);
          _Date_for_endFields.add(addressField);
        });
      },
    );
  }



  Future<void> _openTimePicker(BuildContext context) async {

    final TimeOfDay? t = await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (t != null) {
      setState(() {
        //for (var index = 0; index < _nameMedicineTextController.length; index++)
     //  var index = _timeOoYouTakeMedicineTextController.length;

       //print('The value of the  counter is: $counterThird');
        //_timeOoYouTakeMedicineTextController.length-1

        _timeOoYouTakeMedicineTextController[counterThird].text = t.format(context);
        _selectedTime = t.format(context);
        counterThird++;
      });
    }
  }

  TextField _generateTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: hint,
      ),
    );
  }

  TextField _generateTextField1(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      onTap: () {
        _pickDateStart();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: hint,
      ),
    );
  }

  TextField _generateTextField2(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      onTap: () {
        _pickDateEnd();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: hint,
      ),
    );
  }

  TextField _generateTextField3(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      onTap: () {
        _openTimePicker(context);
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: hint,
      ),
    );
  }

  void _pickDateStart() async {

    picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920),
        lastDate: DateTime.now());

    if (picked != null) {
     // for (var index = 0; index < _nameMedicineTextController.length; index++)
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
    //  for (var index = 0; index < _nameMedicineTextController.length; index++)
      setState(() {
        //_Date_for_endMedicineTextController.length-1
        _Date_for_endMedicineTextController[counterSecond].text =
        '${picked!.year}-${picked!.month}-${picked!.day}';
        counterSecond++;
      });
    }
  }




  // Widget _listView() {
  //   final children = [
  //     for (var i = 0; i < _nameMedicineTextController.length; i++)
  //       Container(
  //         margin: EdgeInsets.all(5),
  //         child: InputDecorator(
  //           child:
  //           Column(
  //             children: [
  //               _nameMedicineFields[i],
  //               _Date_for_startMedicineFields[i],
  //               _Date_for_endFields[i],
  //               _timeOoYouTakeMedicineFields[i],
  //
  //             ],
  //           ),
  //
  //           decoration: InputDecoration(
  //             labelText: i.toString(),
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(10.0),
  //             ),
  //           ),
  //         ),
  //       )
  //   ];
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: children,
  //     ),
  //   );
  // }
  //

  Widget _listView() {
    final children = [
      for (var i = 0; i < _nameMedicineTextController.length; i++)
     // var i = counterAll;
        Container(
          margin: EdgeInsets.all(5),
          child: InputDecorator(
            child:
            Column(
              children: [
                _nameMedicineFields[i],
                _Date_for_startMedicineFields[i],
                _Date_for_endFields[i],
                _timeOoYouTakeMedicineFields[i],
                _addTile_1(),
                //_listView_1(),

              ],
            ),

            decoration: InputDecoration(
              labelText: i.toString(),
             //labelText: counterAll.toString(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
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

  Widget _listView_1() {
    final children = [
      for (var i = 0; i < _otherTimeOoYouTakeMedicineTextControllerOther.length; i++)
        Container(
          margin: EdgeInsets.all(5),
          child: InputDecorator(
            child:
            Column(
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
      title: Icon(Icons.add),
      onTap: () {

        final timeOoYouTakeMedicine = TextEditingController();
        final nameField_1 = _generateTextField3(timeOoYouTakeMedicine, _selectedTime);

        setState(() {
          _otherTimeOoYouTakeMedicineTextControllerOther.add(timeOoYouTakeMedicine);
          _otherTimeOoYouTakeMedicineFields.add(nameField_1);
        });
      },

    );

  }

}

