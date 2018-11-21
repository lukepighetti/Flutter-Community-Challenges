import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class SubmitEntryToChallenge extends StatefulWidget {
  @override
  _SubmitEntryToChallengeState createState() => _SubmitEntryToChallengeState();
}

class _SubmitEntryToChallengeState extends State<SubmitEntryToChallenge> {
  var _githubRepo;

  FirebaseUser currentUser;

  List<String> repoNames = [];

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
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              DocumentSnapshot snap;
              for(int i = 0; i < snapshot.data.documents.length; i++) {
                if(snapshot.data.documents[i].documentID == currentUser.uid) {
                  snap = snapshot.data.documents[i];
                }
              }
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Submit Entry To Challenge",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FutureBuilder(
                        future: http.get('${snap['ReposUrl']}'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            http.Response response = snapshot.data;
                            var reposJson = json.decode(response.body) as List;
                            List<DropdownMenuItem> _githubRepos = [];
                            for (int i = 0; i < reposJson.length; i++) {
                              _githubRepos.add(
                                DropdownMenuItem(
                                  child: Text(reposJson[i]['name']),
                                  value: Text(reposJson[i]['name']),
                                ),
                              );
                            }
                            return OutlineDropdownButton(
                              items: _githubRepos,
                              value: _githubRepo,
                              onChanged: (value) {
                                setState(() {
                                  _githubRepo = value;
                                });
                              },
                              hint: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Icon(
                                        GroovinMaterialIcons.github_circle),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text("Choose Repo"),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return OutlineDropdownButton(
                              items: [
                                DropdownMenuItem(
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4.0),
                                        child: Icon(
                                            GroovinMaterialIcons.github_circle),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Text("Loading repositories..."),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              value: _githubRepo,
                              onChanged: (value) {
                                setState(() {
                                  _githubRepo = value;
                                });
                              },
                              hint: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Icon(
                                        GroovinMaterialIcons.github_circle),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text("Choose Repo"),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "App Name",
                            prefixIcon: Icon(OMIcons.shortText)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Submission Description",
                            prefixIcon: Icon(OMIcons.textsms)
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                      child: ListTile(
                        //leading: Icon(OMIcons.image),
                        title: Text("Submit Screenshots"),
                        trailing: IconButton(
                          icon: Icon(OMIcons.addPhotoAlternate, color: Colors.black,),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
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