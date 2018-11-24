import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:package_info/package_info.dart';

import './current_challenge_card.dart' show CurrentChallengeCard;
import './bottom_navigation_bar.dart' show MyBottomNavigationBar;

class CurrentChallenge extends StatefulWidget {
  @override
  _CurrentChallengeState createState() => _CurrentChallengeState();
}

class _CurrentChallengeState extends State<CurrentChallenge> {
  FirebaseUser currentUser;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _initPackageInfo();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness:
            Theme.of(context).brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light,
        statusBarColor: Theme.of(context).canvasColor,
        systemNavigationBarColor: Theme.of(context).canvasColor,
        systemNavigationBarIconBrightness:
            Theme.of(context).brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Flutter Community Challenges",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            CurrentChallengeCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/SubmitEntryToChallenge");
        },
        child: Icon(Icons.file_upload),
        tooltip: "Submit Entry",
        //label: Text("Submit Entry"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyBottomNavigationBar(
        currentUser: currentUser,
        packageInfo: _packageInfo,
      ),
    );
  }
}
