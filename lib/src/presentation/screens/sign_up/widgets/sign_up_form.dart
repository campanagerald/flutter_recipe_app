import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../business_logic/cubit/authentication/authentication_cubit.dart';
import '../../../../business_logic/cubit/sign_up/sign_up_cubit.dart';
import '../../../../core/functions.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_text_field.dart';

class SignupForm extends StatefulWidget {
  final Size parentSize;

  const SignupForm({
    Key key,
    @required this.parentSize,
  }) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'First Name',
              style: theme.textTheme.headline6.copyWith(color: Colors.white),
            ),
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (previous, current) =>
                  previous.firstName != current.firstName,
              builder: (context, state) {
                return PrimaryTextField(
                  onChanged: (value) => firstName = value,
                  errorText: state.firstName?.invalid == true
                      ? state.firstName.error
                      : null,
                );
              },
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last Name',
              style: theme.textTheme.headline6.copyWith(color: Colors.white),
            ),
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (previous, current) =>
                  previous.lastName != current.lastName,
              builder: (context, state) {
                return PrimaryTextField(
                  onChanged: (value) => lastName = value,
                  errorText: state.lastName?.invalid == true
                      ? state.lastName.error
                      : null,
                );
              },
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: theme.textTheme.headline6.copyWith(color: Colors.white),
            ),
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (previous, current) => previous.email != current.email,
              builder: (context, state) {
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
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (previous, current) =>
                  previous.password != current.password,
              builder: (context, state) {
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confirm Password',
              style: theme.textTheme.headline6.copyWith(color: Colors.white),
            ),
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (previous, current) =>
                  previous.confirmPassword != current.confirmPassword,
              builder: (context, state) {
                return PrimaryTextField(
                  obscureText: true,
                  toogleObscureText: true,
                  onChanged: (value) => confirmPassword = value,
                  errorText: state.confirmPassword?.invalid == true
                      ? state.confirmPassword.error
                      : null,
                );
              },
            ),
            verticalSpace(widget.parentSize.height * 0.03),
            BlocBuilder<SignUpCubit, SignUpState>(
              builder: (_, state) {
                if (state.status.isSubmissionInProgress)
                  return Center(child: CircularProgressIndicator());

                return SizedBox(
                  height: widget.parentSize.height * 0.07,
                  width: widget.parentSize.width,
                  child: PrimayButton(
                    text: 'Submit',
                    onPressed: () => context.bloc<SignUpCubit>().signUp(
                          firstName: firstName,
                          lastName: lastName,
                          email: email,
                          password: password,
                          confirmPassword: confirmPassword,
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
