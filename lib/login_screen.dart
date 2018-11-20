import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:simple_auth/simple_auth.dart' as simpleAuth;
import 'package:simple_auth_flutter/simple_auth_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // attempt to log into github on login button press
  void login(simpleAuth.AuthenticatedApi api) async {
    try {
      var success = await api.authenticate();
      Map userData = success.toJson();
      print("Token: " + userData['token']);
      FirebaseUser user = await FirebaseAuth.instance.signInWithGithub(token: userData['token']);
      if(user != null) {
        Navigator.pushNamed(context, '/CurrentChallenge');
      }
    } catch (e) {
      showError(e);
    }
  }

  // log out of github (not firebase)
  void logout(simpleAuth.AuthenticatedApi api) async {
    await api.logOut();
    showMessage("Logged out");
  }
  
  void showError(dynamic ex) {
    showMessage(ex.toString());
  }

  void showMessage(String text) {
    var alert = new AlertDialog(content: new Text(text), actions: <Widget>[
      new FlatButton(
          child: const Text("Ok"),
          onPressed: () {
            Navigator.pop(context);
          })
    ]);
    showDialog(context: context, builder: (BuildContext context) => alert);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Flutter Community Challenges",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
              /*Image.asset(
                "images/flutt.png",
                height: 150.0,
                width: 150.0,
              ),*/
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
                    onPressed: () {
                      final simpleAuth.GithubApi githubApi = simpleAuth.GithubApi(
                        "github",
                        "b7dd731226e5603af86c", //clientid
                        "0a44a5003946034edfffdd795f17a2d7ebbf3ba2", //clientsecret
                        "fluttercommunitychallenges://authenticate",
                        scopes: [
                          "user",
                          "read:user",
                          "repo",
                          "public_repo",
                        ],
                      );
                      /*Navigator.pushNamed(context, '/CurrentChallenge');*/
                      login(githubApi);
                    },
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
