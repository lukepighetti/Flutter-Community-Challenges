import 'package:flutter/material.dart';

class VoteOnChallengeSuggestions extends StatefulWidget {
  @override
  _VoteOnChallengeSuggestionsState createState() => _VoteOnChallengeSuggestionsState();
}

class _VoteOnChallengeSuggestionsState extends State<VoteOnChallengeSuggestions> {
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
                    "Vote on Challenge Suggestions",
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.lightbulb_outline),
        label: Text("Suggest Challenge"),
        onPressed: () {
          Navigator.pushNamed(context, '/SuggestChallenge');
        },
      ),
    );
  }
}
