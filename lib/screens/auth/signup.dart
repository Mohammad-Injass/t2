import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:t2/constants/constants.dart';
import 'package:t2/screens/auth/login.dart';
import 'Health_informationScreen.dart';

int flge = 1;

String str1 = "";

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  late TextEditingController _fullnameTextController =
      TextEditingController(text: '');
  late TextEditingController _emailTextController =
      TextEditingController(text: '');
  late TextEditingController _passTextController =
      TextEditingController(text: '');
  late TextEditingController _positionCPTextController =
      TextEditingController(text: '');
  late TextEditingController _phoneTextController =
      TextEditingController(text: '');
  late TextEditingController _heightTextController =
      TextEditingController(text: '');
  late TextEditingController _weightTextController =
      TextEditingController(text: '');
  late TextEditingController _Date_of_BirthTextController =
      TextEditingController(text: '');

  late TextEditingController _haveChronicTextController =
      TextEditingController(text: '');

  // late TextEditingController _haveDiseaseTextController =
  //     TextEditingController(text: '');

  FocusNode _fullnameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _positionFocusNode = FocusNode();
  FocusNode _heightFocusNode = FocusNode();
  FocusNode _weightFocusNode = FocusNode();
  FocusNode _Date_of_BirthFocusNode = FocusNode();
  FocusNode _haveChronicFocusNode = FocusNode();

  FocusNode _haveDiseaseFocusNode = FocusNode();

  bool _obscureText = true;
  final _signUpFormKey = GlobalKey<FormState>();
  File? imageFile;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  DateTime? picked;

  bool isVisibleForHaveDisease = false;

  //bool isVisibleForMedicine = false;

  @override
  void dispose() {
    _fullnameTextController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _positionCPTextController.dispose();
    _haveChronicTextController.dispose();
    _phoneTextController.dispose();
    _heightTextController.dispose();
    _weightTextController.dispose();
    _Date_of_BirthTextController.dispose();
    _heightFocusNode.dispose();
    _weightFocusNode.dispose();
    _Date_of_BirthFocusNode.dispose();
    _fullnameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _positionFocusNode.dispose();
    _phoneFocusNode.dispose();
    _haveChronicFocusNode.dispose();

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
                'Register',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 9,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Already have an account?',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: '   '),
                    TextSpan(
                      text: 'Login',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            ),
                      style: TextStyle(
                          color: Colors.blue.shade300,
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Form(
                key: _signUpFormKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            focusNode: _fullnameFocusNode,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_emailFocusNode),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field can\'t be missing';
                              }
                              return null;
                            },
                            controller: _fullnameTextController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Full name',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.pink.shade700),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      focusNode: _emailFocusNode,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_passFocusNode),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid Email adress';
                        }
                        return null;
                      },
                      controller: _emailTextController,
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink.shade700),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Password TextField

                    TextFormField(
                      focusNode: _passFocusNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_phoneFocusNode),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                      obscureText: _obscureText,
                      controller: _passTextController,
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink.shade700),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      focusNode: _phoneFocusNode,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_positionFocusNode),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field can\'t be missing';
                        }
                        return null;
                      },
                      onChanged: (v) {
                        print(
                            '_phoneTextController.text ${_phoneTextController.text}');
                      },
                      controller: _phoneTextController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Emergency Phone number',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink.shade700),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      focusNode: _heightFocusNode,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_heightFocusNode),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field can\'t be missing';
                        }
                        return null;
                      },
                      onChanged: (v) {
                        print(
                            '_heightTextController.text ${_heightTextController.text}');
                      },
                      controller: _heightTextController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Height',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink.shade700),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      focusNode: _weightFocusNode,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_weightFocusNode),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field can\'t be missing';
                        }
                        return null;
                      },
                      onChanged: (v) {
                        print(
                            '_weightTextController.text ${_weightTextController.text}');
                      },
                      controller: _weightTextController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Weight',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink.shade700),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      //keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      focusNode: _Date_of_BirthFocusNode,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_Date_of_BirthFocusNode),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field can\'t be missing';
                        }
                        return null;
                      },
                      onChanged: (v) {
                        print(
                            '_weightTextController.text ${_Date_of_BirthTextController.text}');
                      },
                      onTap: () {
                        _pickDate();
                      },
                      controller: _Date_of_BirthTextController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Date of Birth',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink.shade700),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () => showJobsDialog(size),
                      child: TextFormField(
                        enabled: false,
                        focusNode: _positionFocusNode,
                        textInputAction: TextInputAction.done,
                        onEditingComplete: submitFormOnSignUp,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field can\'t be missing';
                          }
                          return null;
                        },
                        controller: _positionCPTextController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'female Or male',
                          hintStyle: TextStyle(color: Colors.white),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink.shade700),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                onPressed: () => setState(
                    () => isVisibleForHaveDisease = !isVisibleForHaveDisease),
                color: Colors.pink.shade700,
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                    side: BorderSide.none),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon(
                    //   Icons.add,
                    //   color: Colors.white,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'Do you have chronic diseases if yes Pressed in  ',
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
                visible: isVisibleForHaveDisease,
                child: GestureDetector(
                  onTap: () => showChronicDiseases(size),
                  child: TextFormField(
                    enabled: false,
                    focusNode: _haveChronicFocusNode,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: submitFormOnSignUp,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field can\'t be missing';
                      }
                      return null;
                    },
                    controller: _haveChronicTextController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Chronic Disease',
                      hintStyle: TextStyle(color: Colors.white),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink.shade700),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _isLoading
                  ? Center(
                      child: Container(
                        width: 70,
                        height: 70,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : MaterialButton(
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
                              'Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.person_add,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
            ],
          ),
        )
      ],
    ));
  }

  void submitFormOnSignUp() async {
    final isValid = _signUpFormKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.createUserWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passTextController.text.trim());

        final User? user = _auth.currentUser;
        final _uId = user!.uid;

        await FirebaseFirestore.instance.collection('users').doc(_uId).set({
          'id ': _uId,
          'name': _fullnameTextController.text,
          'email': _emailTextController.text,
          'pass': _passTextController.text,
          'phone': _phoneTextController.text,
          'weight': _weightTextController.text,
          'height': _heightTextController.text,
          'position': _positionCPTextController.text,
          'Date of Birth' : _Date_of_BirthTextController.text,
          if (_haveChronicTextController.text == '')
            'have Chronic Disease': "No Have Chronic Disease",
          if (_haveChronicTextController.text != '')
            'have Chronic Disease': _haveChronicTextController.text,
          'Timestamp': Timestamp.now(),
        });

        _logout(context);
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        _showErrorDialog(error.toString());
        print('erorr occured $error');
      }
    } else {
      print('Form not valid');
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(error) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Error occured'),
                ),
              ],
            ),
            content: Text(
              error,
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
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }

  void _pickDate() async {
    picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920),
        lastDate: DateTime.now());

    if (picked != null) {
      setState(() {
        _Date_of_BirthTextController.text =
            '${picked!.year}-${picked!.month}-${picked!.day}';
      });
    }
  }

  void showJobsDialog(size) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'female or male',
              style: TextStyle(color: Colors.pink.shade300, fontSize: 20),
            ),
            content: Container(
              width: size.width * 0.9,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Constants.femaleOrmale.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _positionCPTextController.text =
                              Constants.femaleOrmale[index];
                        });
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: Colors.red[200],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              Constants.femaleOrmale[index],
                              style: TextStyle(
                                  color: Color(0xFF00325A),
                                  fontSize: 20,
                                  // fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text('Close'),
              ),
              TextButton(onPressed: () {}, child: Text('Cancel filter'))
            ],
          );
        });
  }

  void showChronicDiseases(size) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'chronic diseases',
              style: TextStyle(color: Colors.pink.shade300, fontSize: 20),
            ),
            content: Container(
              width: size.width * 0.9,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Constants.chronicDiseases.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _haveChronicTextController.text =
                              Constants.chronicDiseases[index];
                        });
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: Colors.red[200],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              Constants.chronicDiseases[index],
                              style: TextStyle(
                                  color: Color(0xFF00325A),
                                  fontSize: 20,
                                  // fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text('Close'),
              ),
              TextButton(onPressed: () {}, child: Text('Cancel filter'))
            ],
          );
        });
  }

  void _logout(context) {
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
              'you now have an account ',
              style: TextStyle(
                  color: Constants.darkBlue,
                  fontSize: 20,
                  fontStyle: FontStyle.italic),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    final User? user = _auth.currentUser;
                    final _uId = user!.uid;

                    //    _auth.signOut();
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (cix) => Health_informationScreen(userID: _uId),
                    ));
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }
}
