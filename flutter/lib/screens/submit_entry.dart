import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:outline_material_icons/outline_material_icons.dart';

class SubmitEntryToChallenge extends StatefulWidget {
  @override
  _SubmitEntryToChallengeState createState() => _SubmitEntryToChallengeState();
}

class _SubmitEntryToChallengeState extends State<SubmitEntryToChallenge> {
  String _githubRepo;
  List<String> repoNames = [];

  final _appNameController = TextEditingController();
  final _submissionDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            final currentUser = snapshot.data;
            return StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection("Users")
                  .document(currentUser.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final snap = snapshot.data;
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 16.0,
                            bottom: 12.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Submit Challenge Entry",
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
                          child: FutureBuilder(
                            future: http.get('${snap['ReposUrl']}'),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                http.Response response = snapshot.data;
                                var reposJson =
                                    json.decode(response.body) as List;
                                List<DropdownMenuItem> _githubRepos =
                                    reposJson.map((repo) {
                                  return DropdownMenuItem(
                                    child: Text(repo['name']),
                                    value: repo['name'],
                                  );
                                }).toList();

                                return OutlineDropdownButton(
                                  items: _githubRepos,
                                  value: _githubRepo,
                                  onChanged: (value) {
                                    setState(() {
                                      _appNameController.text = value;
                                      _githubRepo = value;
                                    });
                                  },
                                  hint: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.0),
                                        child: Icon(
                                            GroovinMaterialIcons.github_circle),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text("Choose Repo"),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return OutlineDropdownButton(
                                  items: [
                                    DropdownMenuItem(
                                      value: "",
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(left: 4.0),
                                            child: Icon(GroovinMaterialIcons
                                                .github_circle),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child:
                                                Text("Loading repositories..."),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  value: "",
                                  onChanged: (value) {
                                    setState(() {
                                      _githubRepo = value;
                                    });
                                  },
                                  hint: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.0),
                                        child: Icon(
                                            GroovinMaterialIcons.github_circle),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text("Choose Repo"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "App Name",
                                prefixIcon: Icon(OMIcons.shortText)),
                            controller: _appNameController,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Submission Description",
                                prefixIcon: Icon(OMIcons.textsms)),
                            maxLines: 2,
                            controller: _submissionDescriptionController,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 8.0),
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 8.0),
                          child: ListTile(
                            //leading: Icon(OMIcons.image),
                            title: Text("Upload Screenshots"),
                            trailing: IconButton(
                              icon: Icon(
                                OMIcons.addPhotoAlternate,
                                color: Colors.black,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.cloud_upload),
        label: Text("Submit"),
        onPressed: () {},
      ),
    );
  }
}
