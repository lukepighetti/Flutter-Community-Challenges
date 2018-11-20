import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:groovin_widgets/groovin_widgets.dart';

class SubmitEntryToChallenge extends StatefulWidget {
  @override
  _SubmitEntryToChallengeState createState() => _SubmitEntryToChallengeState();
}

class _SubmitEntryToChallengeState extends State<SubmitEntryToChallenge> {
  var _githubRepo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                child: OutlineDropdownButton(
                  items: [
                    DropdownMenuItem(
                      child: Text("Users can pick from their github repos"),
                      value: Text("repo"),
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
                        child: Icon(GroovinMaterialIcons.github_circle),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text("Choose Repo"),
                      ),
                    ],
                  ),
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
                    icon: Icon(OMIcons.addPhotoAlternate),
                    onPressed: () {},
                  ),
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
        onPressed: () {},
      ),
    );
  }
}