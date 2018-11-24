import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();
admin.firestore().settings({ timestampsInSnapshots: true });

/**
 * nextChallenge
 */

export const nextChallenge = functions.https.onRequest(async (req, res) => {
  const suggestionsRef = admin.firestore().collection("ChallengeSuggestions");
  const nextChallengeRef = admin.firestore().collection("NextChallenge");

  // /// clear out NextChallenge collection
  // /// dont enable if NextChallenge has more than 100 entries
  // /// refer to https://firebase.google.com/docs/firestore/manage-data/delete-data

  // const deleteCollection = await admin
  //   .firestore()
  //   .collection("NextChallenge")
  //   .get();

  // const batch = admin.firestore().batch();

  // deleteCollection.forEach(doc => {
  //   batch.delete(doc.ref);
  // });

  // batch.commit();

  const collection = await suggestionsRef
    .orderBy("VoteCount", "desc")
    .limit(1)
    .get();

  await nextChallengeRef.add(collection.docs[0].data());

  res.send(collection.docs[0].data());
});
