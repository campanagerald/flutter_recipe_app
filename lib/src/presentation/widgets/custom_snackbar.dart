import 'package:flutter/material.dart';

import '../../core/constants.dart';

SnackBar customSnackBar(String message) {
  return SnackBar(
    backgroundColor: kAccentColor,
    content: Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
