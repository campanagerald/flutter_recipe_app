import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/functions.dart';
import '../../../../core/screen_information.dart';
import '../../sign_up/sign_up_screen.dart';
import 'sign_in_form.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenInfo = screenInformation(context);
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenInfo.size.width * 0.12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpace(screenInfo.size.height * 0.2),
          Text(
            'Recipes.',
            textAlign: TextAlign.center,
            style: theme.textTheme.headline3.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(2, 3),
                  blurRadius: 8,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          verticalSpace(screenInfo.size.height * 0.1),
          SignInForm(),
          verticalSpace(screenInfo.size.height * 0.02),
          Text(
            'Forgot my password?',
            textAlign: TextAlign.center,
            style: theme.textTheme.subtitle1.copyWith(color: Colors.white),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: screenInfo.size.height * 0.03),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Don't have and account?",
                style: theme.textTheme.subtitle1
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: ' Sign up',
                    style: TextStyle(
                      color: theme.accentColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.of(context)
                          .pushNamed(SignupScreen.routeName),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
