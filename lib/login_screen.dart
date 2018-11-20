import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:simple_auth/simple_auth.dart' as simpleAuth;
import 'package:simple_auth_flutter/simple_auth_flutter.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void login(simpleAuth.AuthenticatedApi api) async {
    try {
      var success = await api.authenticate();
      showMessage("Logged in success: $success");
    } catch (e) {
      showError(e);
    }
  }

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

  Future<void> _retrieveDynamicLink() async {
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.retrieveDynamicLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      Navigator.pushNamed(context, '/CurrentChallenge'); // deeplink.path == '/helloworld'
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        /*child: Center(
          child: RaisedButton.icon(
            icon: Icon(GroovinMaterialIcons.github_circle, color: Colors.white,),
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
            label: Text("Login", style: TextStyle(color: Colors.white),),
            color: Colors.indigoAccent,
            onPressed: () {
              Navigator.pushNamed(context, '/CurrentChallenge');
            },
          ),
        ),*/
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
                          "*", //clientid
                          "*", //clientsecret
                          "*", //redirecturl
                          scopes: [
                            "user",
                            "repo",
                            "public_repo",
                          ]);
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
