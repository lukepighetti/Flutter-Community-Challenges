import 'package:flutter/material.dart';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:simple_auth_flutter/simple_auth_flutter.dart';

import 'screens/check_login.dart';
import 'screens/current_challenge/index.dart';
import 'screens/hall_of_fame.dart';
import 'screens/login_screen.dart';
import 'screens/settings.dart';
import 'screens/submit_entry.dart';
import 'screens/suggest_challenge.dart';
import 'screens/upcoming_challenges.dart';
import 'screens/vote_challenge_suggestions.dart';

void main() => runApp(FlutterCommunityChallenges());

class FlutterCommunityChallenges extends StatefulWidget {
  @override
  FlutterCommunityChallengesState createState() {
    return FlutterCommunityChallengesState();
  }
}

class FlutterCommunityChallengesState
    extends State<FlutterCommunityChallenges> {
  @override
  void initState() {
    super.initState();
    SimpleAuthFlutter.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => ThemeData(
              primarySwatch: Colors.indigo,
              primaryColor: Colors.indigo,
              accentColor: Colors.indigoAccent,
              //fontFamily: 'GoogleSans'
            ),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            title: 'Flutter Community Challenges',
            theme: theme,
            home: CheckLogin(),
            debugShowCheckedModeBanner: false,
            routes: <String, WidgetBuilder>{
              "/LoginScreen": (BuildContext context) => LoginScreen(),
              "/CurrentChallenge": (BuildContext context) => CurrentChallenge(),
              "/HallOfFame": (BuildContext context) => HallOfFame(),
              "/UpcomingChallenges": (BuildContext context) =>
                  UpcomingChallenges(),
              "/VoteOnChallengeSuggestions": (BuildContext context) =>
                  VoteOnChallengeSuggestions(),
              "/SuggestChallenge": (BuildContext context) => SuggestChallenge(),
              "/SubmitEntryToChallenge": (BuildContext context) =>
                  SubmitEntryToChallenge(),
              "/Settings": (BuildContext context) => Settings(),
            },
          );
        });
  }
}
