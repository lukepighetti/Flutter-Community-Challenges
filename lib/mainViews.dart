import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:flutter_community_challenges/current_challenge.dart';
import 'package:groovin_widgets/modal_drawer_handle.dart';
import 'package:rounded_modal/rounded_modal.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:flutter_community_challenges/extended_fab_notched_shape.dart';

class MainViews extends StatefulWidget {
  MainViews({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainViewsState createState() => _MainViewsState();
}

class _MainViewsState extends State<MainViews> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
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
    ));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.title,
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
            CurrentChallenge(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, "/SubmitEntryToChallenge");
        },
        icon: Icon(Icons.add),
        label: Text("Submit Entry"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: ExtendedFABNotchedRectangle(),
        notchMargin: 2.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(OMIcons.more),
                  onPressed: () {
                    showRoundedModalBottomSheet(
                      context: context,
                      color: Theme.of(context).canvasColor,
                      dismissOnTap: false,
                      builder: (builder) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ModalDrawerHandle(
                                handleColor: Colors.indigoAccent,
                              ),
                            ),
                            ListTile(
                              leading: Icon(OMIcons.accountCircle),
                              title: Text("Test Person"),
                              subtitle: Text("testperson@test.com"),
                              trailing: FlatButton(
                                child: Text("Log Out"),
                                onPressed: () {},
                              ),
                            ),
                            Divider(
                              height: 0.0,
                              color: Colors.grey,
                            ),
                            Material(
                              child: ListTile(
                                title: Text("My Submissions"),
                                leading:
                                    Icon(GroovinMaterialIcons.upload_multiple),
                                onTap: () {},
                              ),
                            ),
                            Material(
                              child: ListTile(
                                leading: Icon(OMIcons.settings),
                                title: Text("App Settings"),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, '/Settings');
                                },
                              ),
                            ),
                            Divider(
                              height: 0.0,
                              color: Colors.grey,
                            ),
                            ListTile(
                              leading: Icon(OMIcons.info),
                              title: Text("Flutter Community Challenges"),
                              subtitle: Text("Version 0.1.0"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: IconButton(
                    icon: Icon(GroovinMaterialIcons.crown),
                    onPressed: () {
                      Navigator.pushNamed(context, '/HallOfFame');
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    icon: Icon(GroovinMaterialIcons.calendar_text),
                    onPressed: () {
                      Navigator.pushNamed(context, '/UpcomingChallenges');
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(GroovinMaterialIcons.comment_plus_outline),
                  onPressed: () {
                    Navigator.pushNamed(context, '/SuggestChallenge');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
