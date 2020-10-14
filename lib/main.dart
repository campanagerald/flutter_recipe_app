import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/src/business_logic/cubit/authentication/authentication_cubit.dart';
import 'package:recipe_app/src/config_reader.dart';

import 'src/app.dart';
import 'src/locators.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ConfigReader.initialize();
  await Firebase.initializeApp();
  await setupLocators();

  runApp(
    BlocProvider<AuthenticationCubit>(
      create: (_) => sl<AuthenticationCubit>()..authenticate(),
      child: App(),
    ),
  );
}
