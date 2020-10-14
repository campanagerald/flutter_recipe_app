import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final textTheme = GoogleFonts.poppinsTextTheme();

const kPrimaryColor = Colors.white;
const kAccentColor = Color(0xFFd7bc19);

final kPrimaryTextFieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(30),
  borderSide: BorderSide(color: Colors.white),
);

final kPrimaryTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  contentPadding: EdgeInsets.symmetric(horizontal: 20),
  border: kPrimaryTextFieldBorder,
  enabledBorder: kPrimaryTextFieldBorder,
  focusedBorder: kPrimaryTextFieldBorder,
  errorBorder: kPrimaryTextFieldBorder,
  focusedErrorBorder: kPrimaryTextFieldBorder,
  errorStyle: textTheme.caption.copyWith(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
);

abstract class Role {
  static String user;
  static String chef;
}

abstract class RecipeType {
  static const String mainCourse = "main course";
  static const String sideDish = "side dish";
  static const String dessert = "dessert";
  static const String appetizer = "appetizer";
  static const String salad = "salad";
  static const String bread = "bread";
  static const String breakfast = "breakfast";
  static const String soup = "soup";
  static const String beverage = "beverage";
  static const String sauce = "sauce";
  static const String marinade = "marinade";
  static const String fingerfood = "fingerfood";
  static const String snack = "snack";
  static const String drink = "drink";
}
