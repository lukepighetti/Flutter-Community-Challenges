import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';

class UpcomingChallenges extends StatefulWidget {
  @override
  _UpcomingChallengesState createState() => _UpcomingChallengesState();
}

class _UpcomingChallengesState extends State<UpcomingChallenges> {
  @override
  Widget build(BuildContext context) {
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
                    "Suggest a Challenge",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
