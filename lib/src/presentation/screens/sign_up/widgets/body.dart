import 'package:flutter/material.dart';
import 'package:recipe_app/src/core/functions.dart';
import 'package:recipe_app/src/core/screen_information.dart';
import 'package:recipe_app/src/presentation/screens/sign_up/widgets/sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenInfo = screenInformation(context);
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(
        top: AppBar().preferredSize.height,
        left: screenInfo.size.width * 0.20,
        right: screenInfo.size.width * 0.20,
      ),
      child: LayoutBuilder(
        builder: (_, constraints) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                verticalSpace(constraints.maxHeight * 0.05),
                Text(
                  'Sign up',
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
                verticalSpace(constraints.maxHeight * 0.07),
                SignupForm(
                  parentSize: Size(constraints.maxWidth, constraints.maxHeight),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
