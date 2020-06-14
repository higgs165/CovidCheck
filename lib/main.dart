import 'package:flutter/material.dart';
import 'stats_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.blue.shade900,
    ),
    home: Covid(),
  ));
}



