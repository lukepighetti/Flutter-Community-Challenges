import 'package:flutter/material.dart';
import 'package:flutter_community_challenges/hall_of_fame.dart';
import 'package:flutter_community_challenges/mainViews.dart';
import 'package:flutter_community_challenges/settings.dart';
import 'package:flutter_community_challenges/submit_entry.dart';
import 'package:flutter_community_challenges/suggest_challenge.dart';
import 'package:flutter_community_challenges/upcoming_challenges.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        fontFamily: 'GoogleSans'
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: 'Flutter Community Challenges',
          theme: theme,
          home: MainViews(title: 'Flutter Community Challenges'),
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            "/HallOfFame": (BuildContext context) => HallOfFame(),
            "/UpcomingChallenges": (BuildContext context) => UpcomingChallenges(),
            "/SuggestChallenge": (BuildContext context) => SuggestChallenge(),
            "/SubmitEntryToChallenge": (BuildContext context) => SubmitEntryToChallenge(),
            "/Settings": (BuildContext context) => Settings(),
          },
        );
      }
    );
  }
}