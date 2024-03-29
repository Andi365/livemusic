import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:livemusic/model/colors.dart';
import 'package:livemusic/view/login/custom_textview.dart';

import '../../api/signIn_api.dart';
import '../../model/colors.dart';
import '../../model/user.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  //Some inspiration from here
  //https://github.com/pr-Mais/flutter_firebase_login
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKeyRegister = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();
  PersistentBottomSheetController _sheetController;
  String _email;
  String _password;
  String _displayName;
  bool _loading;
  String errorMsg = "";

  @override
  void initState() {
    _loading = false;

    /*StreamBuilder(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            CircularProgressIndicator();
            break;
          case ConnectionState.done:
            if (snapshot.hasData) {
              Navigator.of(context).pushReplacementNamed('/');
            } else {
              Navigator.of(context).pushReplacementNamed('/login');
            }
            break;
          default:
            Navigator.of(context).pushReplacementNamed('/login');
        }
      },
    );*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              _displayLogo(150),
              SizedBox(height: 35),
              _loginGoogle(),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Or',
                  style: TextStyle(fontSize: 12, color: primaryWhiteColor),
                ),
              ),
              Form(
                key: _formKeyLogin,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20, top: 0),
                      child: CustomTextField(
                        onSaved: (input) {
                          _email = input;
                        },
                        validator: emailValidator,
                        icon: Icon(Icons.email),
                        hint: "EMAIL",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: CustomTextField(
                        obsecure: true,
                        onSaved: (input) => _password = input,
                        validator: (input) =>
                            input.isEmpty ? "*Required" : null,
                        icon: Icon(Icons.lock),
                        hint: "PASSWORD",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Container(
                        child: _loading
                            ? CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    primaryColor),
                              )
                            : customButton(
                                "Login",
                                Colors.white,
                                primaryColor,
                                primaryColor,
                                Colors.white,
                                _validateLoginInput),
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Or',
                  style: TextStyle(fontSize: 12, color: primaryWhiteColor),
                ),
              ),
              Container(
                child: customButton("Create account", Colors.white,
                    primaryColor, primaryColor, Colors.white, registerSheet),
                height: 40,
              ),
              Divider(
                height: 20,
                thickness: 1,
                indent: 170,
                endIndent: 170,
                color: primaryWhiteColor,
              ),
              _loginAnonymously(),
            ],
          ),
        ),
      ),
    );
  }

  Widget customButton(String text, Color splashColor, Color highlightColor,
      Color fillColor, Color textColor, void function()) {
    return Container(
      padding: EdgeInsets.only(left: 60, right: 60),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          splashColor: splashColor,
          highlightColor: highlightColor,
          color: fillColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: () => function(),
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: textColor, fontSize: 12),
          ),
        ),
      ),
    );
  }

  Widget _loginGoogle() {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 15, right: 60, left: 60),
      child: SizedBox(
        width: double.infinity,
        child: GoogleSignInButton(
          onPressed: () {
            signInWithGoogle().then(
              (result) {
                if (result != null) {
                  Navigator.of(context).pushReplacementNamed('/');
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _loginAnonymously() {
    return Center(
      child: InkWell(
        onTap: () {
          signInAnonymously().then(
            (result) {
              if (result != null) {
                Navigator.of(context).pushReplacementNamed('/');
              }
            },
          );
        },
        child: Text(
          'Later',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _displayLogo(double size) {
    return Container(
        child: Image.asset(
      'assets/icons/app_icon.png',
      width: size,
      height: size,
    ));
  }

  void _validateLoginInput() async {
    final FormState form = _formKeyLogin.currentState;
    form.save();
    setState(() {
      _loading = true;
    });
    try {
      await auth
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((value) => Navigator.of(context).pushReplacementNamed('/'))
          .then((value) {
        setState(() {
          _loading = false;
        });
      });
    } catch (error) {
      switch (error.code) {
        case "ERROR_USER_NOT_FOUND":
          {
            setState(() {
              errorMsg =
                  "There is no user with such entries. Please try again.";
              _loading = false;
            });
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      child: Text(errorMsg),
                    ),
                  );
                });
          }
          break;
        case "ERROR_WRONG_PASSWORD":
          {
            setState(() {
              errorMsg = "Password doesn\'t match your email.";
              _loading = false;
            });
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      child: Text(errorMsg),
                    ),
                  );
                });
          }
          break;
        default:
          {
            setState(() {
              errorMsg = "";
            });
          }
      }
    }
  }

  void _validateRegisterInput() async {
    final FormState form = _formKeyRegister.currentState;
    if (_formKeyRegister.currentState.validate()) {
      form.save();
      _sheetController.setState(() {
        _loading = true;
      });
      try {
        signInWithEmail(_displayName, _email, _password).then((value) {
          Navigator.of(context).pushReplacementNamed('/');
        }).then((value) {
          _sheetController.setState(() {
            _loading = false;
          });
        });
      } catch (error) {
        switch (error.code) {
          case "ERROR_EMAIL_ALREADY_IN_USE":
            {
              _sheetController.setState(() {
                errorMsg = "This email is already in use.";
                _loading = false;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text(errorMsg),
                      ),
                    );
                  });
            }
            break;
          case "ERROR_WEAK_PASSWORD":
            {
              _sheetController.setState(() {
                errorMsg = "The password must be 6 characters long or more.";
                _loading = false;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text(errorMsg),
                      ),
                    );
                  });
            }
            break;
          default:
            {
              _sheetController.setState(() {
                errorMsg = "";
              });
            }
        }
      }
    }
  }

  void registerSheet() {
    _sheetController =
        _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
      return DecoratedBox(
        decoration: BoxDecoration(color: backgroundColor),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
          child: Container(
            child: ListView(
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 10,
                        top: 10,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.close,
                            size: 30.0,
                            color: primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  height: 50,
                  width: 50,
                ),
                SingleChildScrollView(
                    child: Form(
                  child: Column(children: <Widget>[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text('Create User'),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          bottom: 20,
                          top: 60,
                        ),
                        child: CustomTextField(
                          icon: Icon(Icons.account_circle),
                          hint: "Name",
                          validator: (input) =>
                              input.isEmpty ? "*Required" : null,
                          onSaved: (input) => _displayName = input,
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: CustomTextField(
                          icon: Icon(Icons.email),
                          hint: "E-mail",
                          onSaved: (input) {
                            _email = input;
                          },
                          validator: emailValidator,
                        )),
                    Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: CustomTextField(
                          icon: Icon(Icons.lock),
                          obsecure: true,
                          onSaved: (input) => _password = input,
                          validator: (input) =>
                              input.isEmpty ? "*Required" : null,
                          hint: "Password",
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: _loading
                          ? CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  primaryColor),
                            )
                          : Container(
                              child: customButton(
                                  "REGISTER",
                                  Colors.white,
                                  primaryColor,
                                  primaryColor,
                                  Colors.white,
                                  _validateRegisterInput),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                            ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                  key: _formKeyRegister,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                )),
              ],
            ),
            height: MediaQuery.of(context).size.height / 1.1,
            width: MediaQuery.of(context).size.width,
            color: backgroundColor,
          ),
        ),
      );
    });
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return '*Required';
    if (!regex.hasMatch(value))
      return '*Enter a valid email';
    else
      return null;
  }
}
