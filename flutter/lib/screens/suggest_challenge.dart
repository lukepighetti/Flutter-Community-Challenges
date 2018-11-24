import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

import '../services/database.dart' show createChallengeSuggestion;

class SuggestChallenge extends StatefulWidget {
  @override
  _SuggestChallengeState createState() => _SuggestChallengeState();
}

class _SuggestChallengeState extends State<SuggestChallenge> {
  String _challengeType;
  FirebaseUser currentUser;

  final _challengeNameController = TextEditingController();
  final _challengeDescriptionController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Suggest a Challenge",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Challenge Name *",
                      prefixIcon: Icon(OMIcons.assignment)),
                  controller: _challengeNameController,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: OutlineDropdownButton(
                  items: [
                    DropdownMenuItem(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Icon(OMIcons.checkCircleOutline),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Text("Productivity"),
                          ),
                        ],
                      ),
                      value: "Productivity",
                    ),
                    DropdownMenuItem(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Icon(OMIcons.brush),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Text("UI/UX"),
                          ),
                        ],
                      ),
                      value: "UI/UX",
                    ),
                    DropdownMenuItem(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Icon(OMIcons.cached),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Text("State Management"),
                          ),
                        ],
                      ),
                      value: "State Management",
                    ),
                    DropdownMenuItem(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Icon(OMIcons.golfCourse),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Text("Codegolf"),
                          ),
                        ],
                      ),
                      value: "Codegolf",
                    ),
                    DropdownMenuItem(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Icon(OMIcons.moreHoriz),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Text("Other"),
                          ),
                        ],
                      ),
                      value: "Other",
                    ),
                  ],
                  hint: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Icon(OMIcons.category, color: Colors.grey),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text("Challenge Category *"),
                      ),
                    ],
                  ),
                  value: _challengeType,
                  onChanged: (value) {
                    setState(() {
                      _challengeType = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Description",
                      prefixIcon: Icon(OMIcons.textsms)),
                  maxLines: 2,
                  controller: _challengeDescriptionController,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.cloud_upload),
        label: Text("Submit"),
        onPressed: () {
          if (_challengeNameController.text != null ||
              _challengeNameController.text != "") {
            if (_challengeType != null) {
              createChallengeSuggestion(
                title: _challengeNameController.text,
                category: _challengeType,
                description: _challengeDescriptionController.text,
              );
              Navigator.pop(context);
            } else if (_challengeType == null) {
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).canvasColor,
                  content: Row(
                    children: <Widget>[
                      Icon(Icons.error, color: Colors.red),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Please enter required fields",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: "Dismiss",
                    onPressed: () {},
                  ),
                ),
              );
            }
          } else if (_challengeType == null) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).canvasColor,
                content: Row(
                  children: <Widget>[
                    Icon(Icons.error, color: Colors.red),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Please enter required fields",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: "Dismiss",
                  onPressed: () {},
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
