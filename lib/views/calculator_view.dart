import 'package:calculator/widgets/calculator_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

/// Widget representing a calculator view.
///
/// This widget displays a calculator interface with buttons for performing
/// calculations. Users can input numbers and mathematical operations, and view
/// the result in real-time.
class CalculatorView extends StatefulWidget {
  /// Creates a [CalculatorView].
  const CalculatorView({Key? key}) : super(key: key);

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  /// Default parameters
  String calcul = "0";
  String result = "0";
  String expression = "";
  double calculFontSize = 30.0;
  double resultFontSize = 40.0;

  /// Function to handle button presses.
  ///
  /// This function is called when any button in the calculator view is pressed.
  /// It takes the [buttonText] as input, representing the text displayed
  /// on the button.
  buttonPressed(String buttonText) {
    /// Checks if the result contains a decimal point and removes trailing zeros
    ///
    /// Parameters:
    ///   - result: The result to be checked for a decimal point and trailing zeros.
    /// Returns:
    ///   - A string representing the result with trailing zeros removed, if any.
    String checkDecimal(dynamic result) {
      if (result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if (!(int.parse(splitDecimal[1]) > 0)) {
          return result = splitDecimal[0].toString();
        }
      }
      return result;
    }

    setState(() {
      if (buttonText == "AC") {
        calcul = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        calcul = calcul.substring(0, calcul.length - 1);
        if (calcul == "") {
          calcul = "0";
        }
      } else if (buttonText == "+/-") {
        if (calcul[0] != '-') {
          calcul = '-$calcul';
        } else {
          calcul = calcul.substring(1);
        }
      } else if (buttonText == "=") {
        expression = calcul;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '%');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          if (expression.contains('%')) {
            result = checkDecimal(result);
          }
        } catch (e) {
          result = "Error";
        }
      } else {
        if (calcul == "0") {
          calcul = buttonText;
        } else {
          calcul = calcul + buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 233, 30, 99),
          title: const Text("Calculator"),
        ),
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Calculation result display area
            Align(
              alignment: Alignment.bottomRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(result,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Colors.pink, fontSize: 80))),
                        const Icon(Icons.more_vert,
                            color: Colors.pink, size: 30),
                        const SizedBox(width: 20),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(calcul,
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.pink[100]!,
                              )),
                        ),
                        IconButton(
                          icon: const Icon(Icons.backspace_outlined,
                              color: Colors.pink, size: 30),
                          onPressed: () {
                            buttonPressed("⌫");
                          },
                        ),
                        const SizedBox(width: 20),
                      ],
                    )
                  ],
                ),
              ),
            ),
            // Button display area
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorButton(
                    'AC', Colors.pink[100]!, () => buttonPressed('AC')),
                calculatorButton(
                    '%', Colors.pink[100]!, () => buttonPressed('%')),
                calculatorButton(
                    '÷', Colors.pink[100]!, () => buttonPressed('÷')),
                calculatorButton(
                    "x", Colors.pink[100]!, () => buttonPressed('x')),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorButton(
                    '7', Colors.pink[200]!, () => buttonPressed('7')),
                calculatorButton(
                    '8', Colors.pink[200]!, () => buttonPressed('8')),
                calculatorButton(
                    '9', Colors.pink[200]!, () => buttonPressed('9')),
                calculatorButton(
                    '-', Colors.pink[100]!, () => buttonPressed('-')),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorButton(
                    '4', Colors.pink[200]!, () => buttonPressed('4')),
                calculatorButton(
                    '5', Colors.pink[200]!, () => buttonPressed('5')),
                calculatorButton(
                    '6', Colors.pink[200]!, () => buttonPressed('6')),
                calculatorButton(
                    '+', Colors.pink[100]!, () => buttonPressed('+')),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              // TODO : Fix the display which adds a margin around the row and shifts the columns relative to those above
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        calculatorButton(
                            '1', Colors.pink[200]!, () => buttonPressed('1')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04),
                        calculatorButton(
                            '2', Colors.pink[200]!, () => buttonPressed('2')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04),
                        calculatorButton(
                            '3', Colors.pink[200]!, () => buttonPressed('3')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        calculatorButton('+/-', Colors.pink[200]!,
                            () => buttonPressed('+/-')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04),
                        calculatorButton(
                            '0', Colors.pink[200]!, () => buttonPressed('0')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04),
                        calculatorButton(
                            '.', Colors.pink[200]!, () => buttonPressed('.')),
                      ],
                    ),
                  ],
                ),
                calculatorButton('=', Colors.pink, () => buttonPressed('=')),
              ],
            )
          ],
        )));
  }
}
