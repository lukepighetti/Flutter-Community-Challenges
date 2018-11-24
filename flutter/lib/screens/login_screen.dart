import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';

import '../services/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // attempt to log into github on login button press

  void showError(dynamic ex) {
    showMessage(ex.toString());
  }

  Future showMessage(String text) async {
    final alert = AlertDialog(
      content: Text(text),
      actions: <Widget>[
        FlatButton(
          child: Text("Ok"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }

  void showSnackbar() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).canvasColor,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Logging in...",
              style: TextStyle(color: Colors.black),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: CircularProgressIndicator(),
            ),
          ],
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void popView() {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/CurrentChallenge',
        (Route<dynamic> route) => false,
      );
    }

    void handlePressed() async {
      try {
        await login();
        showSnackbar();
        await Future.delayed(Duration(milliseconds: 500));
        popView();
      } catch (e) {
        showError(e);
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Flutter Community Challenges",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton.extended(
                    icon: Icon(
                      GroovinMaterialIcons.github_circle,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => handlePressed(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
