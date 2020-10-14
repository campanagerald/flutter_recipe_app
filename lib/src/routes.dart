import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/cubit/recipes/recipes_cubit.dart';
import 'business_logic/cubit/sign_in/sign_in_cubit.dart';
import 'business_logic/cubit/sign_up/sign_up_cubit.dart';
import 'locators.dart';
import 'presentation/screens/detail_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/join_as_screen.dart';
import 'presentation/screens/not_found_screen.dart';
import 'presentation/screens/sign_in/sign_in_screen.dart';
import 'presentation/screens/sign_up/sign_up_screen.dart';

Route<dynamic> routes(RouteSettings settings) {
  switch (settings.name) {
    case SignInScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => BlocProvider<SignInCubit>(
          create: (_) => sl<SignInCubit>(),
          child: SignInScreen(),
        ),
      );
      break;
    case JoinAsScreen.routeName:
      return MaterialPageRoute(builder: (_) => JoinAsScreen());
      break;
    case SignupScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => BlocProvider<SignUpCubit>(
          create: (_) => sl<SignUpCubit>(),
          child: SignupScreen(),
        ),
      );
      break;
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => BlocProvider<RecipesCubit>(
          create: (_) => sl<RecipesCubit>()..fetchRecipes(),
          child: HomeScreen(),
        ),
      );
      break;
    case DetailScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => DetailScreen(recipe: settings.arguments),
      );
      break;
    default:
      return MaterialPageRoute(
        builder: (_) => NotFoundScreen(),
      );
  }
}
