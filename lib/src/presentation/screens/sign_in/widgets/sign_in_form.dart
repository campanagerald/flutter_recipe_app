import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../business_logic/cubit/sign_in/sign_in_cubit.dart';
import '../../../../core/functions.dart';
import '../../../../core/screen_information.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_text_field.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final screenInfo = screenInformation(context);
    final theme = Theme.of(context);

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: theme.textTheme.headline6.copyWith(color: Colors.white),
            ),
            BlocBuilder<SignInCubit, SignInState>(
              buildWhen: (previous, current) => previous.email != current.email,
              builder: (_, state) {
                return PrimaryTextField(
                  onChanged: (value) => email = value,
                  errorText:
                      state.email?.invalid == true ? state.email.error : null,
                );
              },
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: theme.textTheme.headline6.copyWith(color: Colors.white),
            ),
            BlocBuilder<SignInCubit, SignInState>(
              buildWhen: (previous, current) =>
                  previous.password != current.password,
              builder: (_, state) {
                return PrimaryTextField(
                  obscureText: true,
                  toogleObscureText: true,
                  onChanged: (value) => password = value,
                  errorText: state.password?.invalid == true
                      ? state.password.error
                      : null,
                );
              },
            ),
          ],
        ),
        verticalSpace(screenInfo.size.height * 0.03),
        SizedBox(
          height: screenInfo.size.height * 0.06,
          width: screenInfo.size.width,
          child: BlocBuilder<SignInCubit, SignInState>(
            builder: (_, state) {
              if (state.status.isSubmissionInProgress) {
                return Center(child: CircularProgressIndicator());
              }

              return PrimayButton(
                text: 'Submit',
                onPressed: () => context
                    .bloc<SignInCubit>()
                    .signIn(email: email, password: password),
              );
            },
          ),
        ),
      ],
    );
  }
}
