import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:t2/constants/constants.dart';
import 'package:t2/user_state.dart';
import '../inner_screens/AddNewInformationScreen.dart';
import '../inner_screens/AllInformationScreen.dart';
import '../inner_screens/MyAccountProfileScreen.dart';
import '../inner_screens/healthStatusScreen.dart';
import '../inner_screens/modifyInformationScreen.dart';
import '../inner_screens/all_Widget.dart';
import '../inner_screens/profile.dart';

class DrawerWidget extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.cyan),
                child: Column(
                  children: [
                    Flexible(
                        child:
                        Text(
                          'y app',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Constants.darkBlue,
                              fontSize: 22,
                              fontStyle: FontStyle.italic),
                        ),
                    )
                  ],
                )),
            SizedBox(
              height: 30,
            ),
            _listTiles(
                label: 'Health status',
                fct: () {
                  _healthStatusScreen(context);
                },
                icon: Icons.task_outlined),

            _listTiles(
                label: 'All information',
                fct: () {
                  _AllInformationScreen(context);
                },
                icon: Icons.task_outlined),
            _listTiles(
                label: 'Modify information',
                fct: () {
                  _modifyInformationScreen(context);
                },
                icon: Icons.settings_outlined),
            _listTiles(
                label: 'Add new information',
                fct: () {
                  _AddNewInformationScreen(context);
                },
                icon: Icons.add_task_outlined),
            _listTiles(
                label: 'My account',
                fct: () {
                  _MyAccountProfileScreen(context);
                },
                icon: Icons.home),
            Divider(
              thickness: 1,
            ),
            _listTiles(
                label: 'Logout',
                fct: () {
                  _logout(context);
                },
                icon: Icons.logout_outlined),
          ],
        ));
  }

  void _healthStatusScreen(context) {
    final User? user = _auth.currentUser;
    final _uId = user!.uid;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => healthStatusScreen(userID: _uId),
      ),
    );
  }

  void _MyAccountProfileScreen(context) {
    final User? user = _auth.currentUser;
    final _uId = user!.uid;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(userID: _uId),
      ),
    );
  }

  void _modifyInformationScreen(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => modifyInformationScreen(),
      ),
    );
  }

  void _AddNewInformationScreen(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewInformationScreen(),
      ),
    );
  }

  void _AllInformationScreen(context) {
    final User? user = _auth.currentUser;
    final _uId = user!.uid;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AllInformationScreen(userID: _uId),
      ),
    );
  }

  void _logout(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Sign out'),
                ),
              ],
            ),
            content: Text(
              'Do you want Sign out',
              style: TextStyle(
                  color: Constants.darkBlue,
                  fontSize: 20,
                  fontStyle: FontStyle.italic),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text('Cancel'),
              ),
              TextButton(
                  onPressed: () {
                    _auth.signOut();
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                    Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (cix) => UserState(),
                    )
                    );
                    },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }

  Widget _listTiles(
      {required String label, required Function fct, required IconData icon}) {
    return ListTile(
      onTap: () {
        fct();
      },
      leading: Icon(
        icon,
        color: Constants.darkBlue,
      ),
      title: Text(
        label,
        style: TextStyle(
            color: Constants.darkBlue,
            fontSize: 20,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
