import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';


class modifyInformationScreen extends StatefulWidget {
  @override
  _modifyInformationScreenState createState() => _modifyInformationScreenState();
}

class _modifyInformationScreenState extends State<modifyInformationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Modify Information',
          style: TextStyle(color: Colors.pink),
        ),
      ),
      body: Center(child: Text('test : modify Information Screen')),
    );
  }

}