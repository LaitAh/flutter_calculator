import 'package:calculator/views/calculator_view.dart';
import 'package:flutter/material.dart';

/// Entry point for the calculator application.
///
/// This file contains the main function and the [MyApp] widget,
/// which initializes the Flutter application and sets up the
/// initial route to the [CalculatorView].
void main() {
  runApp(const MyApp());
}

/// The root widget of the calculator application.
///
/// This widget configures the MaterialApp with the necessary
/// settings and sets the initial route to the [CalculatorView].
class MyApp extends StatelessWidget {
  /// Constructor for the MyApp widget.
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      home: CalculatorView(),
    );
  }
}
