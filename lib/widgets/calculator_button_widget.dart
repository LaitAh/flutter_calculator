import 'package:flutter/material.dart';

/// Widget representing a custom button for a calculator.
///
/// This widget generates a custom button for a calculator, suitable for
/// various operations. It allows specifying the text displayed on the button,
/// its color, and a function to execute when pressed.
///
/// Example usage:
/// ```dart
/// calculatorButton(
///   '=', // Button text
///   Colors.blue, // Button color
///   () { // Function to execute when clicked
///     // Logic to execute when the "=" button is clicked
///   },
/// )
Widget calculatorButton(
    String buttonText, Color buttonColor, void Function()? buttonPressed) {
  return Container(
    width: 80,
    height: buttonText == '='
        ? 160
        : 75, // The equal button is twice the height of the other buttons
    padding: const EdgeInsets.all(0),
    child: ElevatedButton(
      onPressed: buttonPressed,
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          backgroundColor: buttonColor),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 25, color: Colors.white),
      ),
    ),
  );
}
