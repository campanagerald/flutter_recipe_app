import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/authentication/authentication_cubit.dart';
import '../screens/sign_in/sign_in_screen.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (_, state) {
        if (state is UnAuthenticated)
          Navigator.of(context).pushNamedAndRemoveUntil(
              SignInScreen.routeName, (route) => false);
      },
      child: Container(
        child: Center(
          child: FlatButton(
            onPressed: () => context.bloc<AuthenticationCubit>().signOut(),
            child: Text('Logout'),
          ),
        ),
      ),
    );
  }
}
