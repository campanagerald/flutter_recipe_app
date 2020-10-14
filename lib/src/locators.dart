import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_app/src/business_logic/cubit/sign_up/sign_up_cubit.dart';

import 'business_logic/cubit/authentication/authentication_cubit.dart';
import 'business_logic/cubit/recipes/recipes_cubit.dart';
import 'business_logic/cubit/sign_in/sign_in_cubit.dart';
import 'config_reader.dart';
import 'data/data_providers/firebase_api.dart';
import 'data/data_providers/spoonacular_api.dart';
import 'data/repositories/authentication_repository.dart';
import 'data/repositories/recipe_repository.dart';

final sl = GetIt.I;

Future<void> setupLocators() async {
  // Externals
  final dio = new Dio(BaseOptions(baseUrl: 'https://api.spoonacular.com'));
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        return options
          ..queryParameters
              .addAll({"apiKey": ConfigReader.getSpoonacularApiKey()});
      },
    ),
  );

  sl.registerLazySingleton<Dio>(() => dio);

  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Data providers
  sl.registerLazySingleton<ISpoonacularApi>(
      () => SpoonacularApi(dio: sl<Dio>()));

  sl.registerLazySingleton<IFirebaseApi>(() => FirebaseApi(
      auth: sl<FirebaseAuth>(), firestore: sl<FirebaseFirestore>()));

  // Repositories
  sl.registerLazySingleton<IRecipeRepository>(
      () => RecipeRepository(spoonacularApi: sl<ISpoonacularApi>()));

  sl.registerLazySingleton<IAuthenticationRepository>(
      () => AuthenticationRepository(firebaseDataSource: sl<IFirebaseApi>()));

  // Bloc/Cubit
  sl.registerFactory<RecipesCubit>(
      () => RecipesCubit(recipeRepository: sl<IRecipeRepository>()));

  sl.registerFactory<AuthenticationCubit>(() => AuthenticationCubit(
      authenticationRepository: sl<IAuthenticationRepository>()));

  sl.registerFactory<SignInCubit>(() =>
      SignInCubit(authenticationRepository: sl<IAuthenticationRepository>()));

  sl.registerFactory<SignUpCubit>(() =>
      SignUpCubit(authenticationRepository: sl<IAuthenticationRepository>()));
}
