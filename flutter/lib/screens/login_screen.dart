import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:simple_auth/simple_auth.dart' as simpleAuth;

import '../secrets.dart' show githubSecret;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseUser currentUser;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // attempt to log into github on login button press
  void login(simpleAuth.AuthenticatedApi api) async {
    try {
      currentUser = await FirebaseAuth.instance.currentUser();
      final githubUser = await api.authenticate();
      final token = githubUser.toJson()['token'];
      final response = await http.get(
        "https://api.github.com/user",
        headers: {HttpHeaders.authorizationHeader: "Bearer " + token},
      );
      final responseJson = json.decode(response.body.toString());
      final reposURL = responseJson['repos_url'];
      final firebaseUser =
          await FirebaseAuth.instance.signInWithGithub(token: token);
      final newInfo = UserUpdateInfo();
      newInfo.displayName = responseJson['login'];
      firebaseUser.updateProfile(newInfo);
      final usersDB =
          Firestore.instance.collection("Users").document(firebaseUser.uid);
      usersDB.setData({
        "ReposUrl": reposURL,
      });
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
      await Future.delayed(Duration(milliseconds: 500));
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/CurrentChallenge',
        (Route<dynamic> route) => false,
      );
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
    final alert = AlertDialog(content: Text(text), actions: <Widget>[
      FlatButton(
          child: Text("Ok"),
          onPressed: () {
            Navigator.pop(context);
          })
    ]);
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {
                      final githubApi = simpleAuth.GithubApi(
                        "github",
                        "b7dd731226e5603af86c", //clientid
                        githubSecret, //clientsecret
                        "fluttercommunitychallenges://authenticate",
                        scopes: [
                          "user",
                          "read:user",
                          "repo",
                          "public_repo",
                        ],
                      );
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
