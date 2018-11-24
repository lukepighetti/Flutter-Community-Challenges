import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_auth/simple_auth.dart' as simpleAuth;

import '../secrets.dart' show githubSecret;

final githubApi = simpleAuth.GithubApi(
  "github",
  "b7dd731226e5603af86c", //clientid
  githubSecret, //clientsecret
  "fluttercommunitychallenges://authenticate",
  scopes: [
    "user",
    "read:user",
    "repo",
    "public_repo",
  ],
);

FirebaseUser currentUser;

Future<void> login() async {
  currentUser = await FirebaseAuth.instance.currentUser();
  final githubUser = await githubApi.authenticate();
  final token = githubUser.toJson()['token'];
  final response = await http.get(
    "https://api.github.com/user",
    headers: {HttpHeaders.authorizationHeader: "Bearer " + token},
  );

  final responseJson = json.decode(response.body.toString());
  final reposURL = responseJson['repos_url'];

  final firebaseUser =
      await FirebaseAuth.instance.signInWithGithub(token: token);
  final newInfo = UserUpdateInfo();
  newInfo.displayName = responseJson['login'];
  firebaseUser.updateProfile(newInfo);
  final usersDB =
      Firestore.instance.collection("Users").document(firebaseUser.uid);
  usersDB.setData({
    "ReposUrl": reposURL,
  });
}

// log out of github (not firebase)
Future<void> logout(simpleAuth.AuthenticatedApi api) async {
  await api.logOut();
}
