import 'package:flutter/material.dart';

SnackBar snack(String displayText,Color color) {
  return SnackBar(
    content: Text(displayText),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(milliseconds: 1000),
    backgroundColor:color ,
  );
}
