import 'package:flutter/material.dart';
import 'package:recipe_app/src/routes.dart';

import 'core/constants.dart';
import 'presentation/screens/initial_screen.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffFBFAFA),
        textTheme: textTheme,
        primaryColor: kPrimaryColor,
        accentColor: kAccentColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: InitialScreen(),
      onGenerateRoute: routes,
    );
  }
}
