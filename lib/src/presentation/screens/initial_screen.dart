import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/src/business_logic/cubit/authentication/authentication_cubit.dart';

import 'home_screen.dart';
import 'sign_in/sign_in_screen.dart';

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (_, state) {
          if (state is UnAuthenticated)
            Navigator.of(context).popAndPushNamed(SignInScreen.routeName);
          else if (state is Authenticated)
            Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
        },
        builder: (_, state) {
          if (state is Authenticating)
            return Center(
              child: CircularProgressIndicator(),
            );

          return Container();
        },
      ),
    );
  }
}
