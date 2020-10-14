import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe_app/src/business_logic/cubit/authentication/authentication_cubit.dart';
import 'package:recipe_app/src/business_logic/cubit/sign_up/sign_up_cubit.dart';

import '../../widgets/container_with_background_image.dart';
import '../../widgets/custom_snackbar.dart';
import '../home_screen.dart';
import 'widgets/body.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return ContainerWithBackgroundImage(
      image: AssetImage('assets/images/sign_in_background_image.jpg'),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
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
          body: MultiBlocListener(
            listeners: [
              BlocListener<AuthenticationCubit, AuthenticationState>(
                listener: (context, state) {
                  if (state is Authenticated) {
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  }
                },
              ),
              BlocListener<SignUpCubit, SignUpState>(
                listener: (context, state) {
                  if (state.error != null) {
                    Scaffold.of(context)
                        .showSnackBar(customSnackBar(state.error.toString()));
                  } else if (state.status.isSubmissionInProgress) {
                    Scaffold.of(context).hideCurrentSnackBar();
                  } else if (state.currentUser != null) {
                    context
                        .bloc<AuthenticationCubit>()
                        .signInSuccess(state.currentUser);
                  }
                },
              ),
            ],
            child: Body(),
          ),
        ),
      ),
    );
  }
}
