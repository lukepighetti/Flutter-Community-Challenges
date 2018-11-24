import 'package:meta/meta.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future createChallengeSuggestion({
  @required String title,
  @required String category,
  @required String description,
}) async {
  final db = Firestore.instance.collection("ChallengeSuggestions");
  final currentUser = await FirebaseAuth.instance.currentUser();

  db.document().setData({
    "ChallengeName": title,
    "ChallengeCategory": category,
    "ChallengeDescription": description,
    "SubmittedBy": currentUser.displayName,
    "VoteCount": "",
  });
}
