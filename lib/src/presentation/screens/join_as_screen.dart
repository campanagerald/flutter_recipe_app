import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recipe_app/src/presentation/widgets/container_with_background_image.dart';
import 'package:recipe_app/src/presentation/widgets/primary_button.dart';

class JoinAsScreen extends StatelessWidget {
  static const String routeName = '/join-as';

  const JoinAsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          splashColor: Colors.transparent,
          icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ContainerWithBackgroundImage(
        image: AssetImage('assets/images/sign_in_background_image.jpg'),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            margin: EdgeInsets.only(
              top: AppBar().preferredSize.height,
              left: mediaQuery.size.width * 0.20,
              right: mediaQuery.size.width * 0.20,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final height = constraints.maxHeight;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Join',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headline3.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'as',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headline6
                          .copyWith(color: Colors.white),
                    ),
                    SizedBox(height: height * 0.05),
                    PrimayButton(text: 'Chef', onPressed: () {}),
                    SizedBox(height: height * 0.03),
                    PrimayButton(text: 'Apprentice', onPressed: () {}),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
