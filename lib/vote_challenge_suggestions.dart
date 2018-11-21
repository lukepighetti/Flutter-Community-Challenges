import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VoteOnChallengeSuggestions extends StatefulWidget {
  @override
  _VoteOnChallengeSuggestionsState createState() => _VoteOnChallengeSuggestionsState();
}

class _VoteOnChallengeSuggestionsState extends State<VoteOnChallengeSuggestions> {
  Color upvoteColor;
  Color downvoteColor;
  bool upvoted = false;
  bool downvoted = false;
  int voteCount = 0;
  String votes;

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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("ChallengeSuggestions").snapshots(),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (builder, index) {
                          DocumentSnapshot csSnap = snapshot.data.documents[index];
                          if("${csSnap['VoteCount']}" == null || "${csSnap['VoteCount']}" == ""){
                            votes = "0";
                          } else {
                            votes = "${csSnap['VoteCount']}";
                          }
                          if("${csSnap['VoteType']}" == "Upvoted") {
                            upvoteColor = Colors.orange;
                            upvoted = true;
                            downvoted = false;
                          } else if ("${csSnap['VoteType']}" == "Downvoted") {
                            downvoteColor = Colors.indigo;
                            downvoted = true;
                            upvoted = false;
                          }
                          return Card(
                            elevation: 0.0,
                            color: Theme.of(context).canvasColor,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "${csSnap['ChallengeName']} - Submitted by " + "${csSnap['SubmittedBy']}",
                                            style: TextStyle(
                                              fontSize: 16.0
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Text("${csSnap['ChallengeDescription']}"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                                            child: Text("Category: " + "${csSnap['ChallengeCategory']}"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Column(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.arrow_upward, color: upvoted == true ? upvoteColor : Colors.black),
                                            onPressed: (){
                                              setState(() {
                                                if(!upvoted) {
                                                  upvoted = true;
                                                  downvoted = false;
                                                  voteCount += 1;
                                                  Firestore.instance.collection("ChallengeSuggestions").document(csSnap.documentID).updateData({
                                                    "VoteCount":voteCount,
                                                    "VoteType":"Upvote",
                                                  });
                                                }
                                              });
                                            },
                                          ),
                                          Text(votes),
                                          IconButton(
                                            icon: Icon(Icons.arrow_downward, color: downvoteColor),
                                            onPressed: (){
                                              setState(() {
                                                if(!downvoted) {
                                                  downvoted = true;
                                                  upvoted = false;
                                                  voteCount-= 1;
                                                  Firestore.instance.collection("ChallengeSuggestions").document(csSnap.documentID).updateData({
                                                    "VoteCount":voteCount,
                                                    "VoteType":"Downvote",
                                                  });
                                                }
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
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
