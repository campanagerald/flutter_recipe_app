import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class ISpoonacularApi {
  Future<List<Map<String, dynamic>>> complexSearch(
      Map<String, dynamic> parameters,
      {int offset = 0,
      int number = 10});

  Future<List<Map<String, dynamic>>> randomRecipes();
}

class SpoonacularApi implements ISpoonacularApi {
  final Dio _dio;
  final String _basePath = '/recipes';

  SpoonacularApi({@required Dio dio}) : _dio = dio;

  @override
  Future<List<Map<String, dynamic>>> complexSearch(
    Map<String, dynamic> parameters, {
    int offset = 0,
    int number = 10,
  }) async {
    final response = await _dio.get('$_basePath/complexSearch',
        queryParameters: parameters
          ..addAll({
            "offset": offset,
            "number": number,
          }));

    return List<Map<String, dynamic>>.from(response.data["results"]);
  }

  @override
  Future<List<Map<String, dynamic>>> randomRecipes() async {
    final response =
        await _dio.get('$_basePath/random', queryParameters: {"number": 10});

    return List<Map<String, dynamic>>.from(response.data["recipes"]);
  }
}
