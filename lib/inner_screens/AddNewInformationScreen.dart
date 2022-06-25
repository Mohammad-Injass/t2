import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';


class AddNewInformationScreen extends StatefulWidget {
  @override
  _AddNewInformationScreenState createState() => _AddNewInformationScreenState();
}

class _AddNewInformationScreenState extends State<AddNewInformationScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Add New Information ',
          style: TextStyle(color: Colors.pink),
        ),
      ),
      body: Center(child: Text('test : Add New Information Screen')),
    );
  }
}


