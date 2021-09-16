import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static void goToNextPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext ctx) => page),
    );
  }
}
