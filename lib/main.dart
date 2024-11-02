import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '';

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        // Clear the input
        input = '';
        result = '';
      } else if (buttonText == '=') {
        // Calculate the result
        try {
          result = _calculate(input).toString();
        } catch (e) {
          result = 'Error';
        }
      } else {
        // Append the pressed button to input
        input += buttonText;
      }
    });
  }

  double _calculate(String input) {
    List<String> tokens = _tokenize(input);
    double total = double.parse(tokens[0]);

    for (int i = 1; i < tokens.length; i += 2) {
      String operator = tokens[i];
      double operand = double.parse(tokens[i + 1]);

      switch (operator) {
        case '+':
          total += operand;
          break;
        case '-':
          total -= operand;
          break;
        case '*':
          total *= operand;
          break;
        case '/':
          if (operand != 0) {
            total /= operand;
          } else {
            throw Exception("Division by zero");
          }
          break;
      }
    }
    return total;
  }

  List<String> _tokenize(String input) {
    List<String> tokens = [];
    String number = '';

    for (int i = 0; i < input.length; i++) {
      String character = input[i];
      if ('0123456789.'.contains(character)) {
        number += character; // Build the number string
      } else {
        if (number.isNotEmpty) {
          tokens.add(number);
          number = '';
        }
        tokens.add(character); // Add the operator
      }
    }
    if (number.isNotEmpty) {
      tokens.add(number); // Add the last number
    }
    return tokens;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF6A5ACD),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6A5ACD), // Slate Blue
              Color(0xFF00CED1), // Dark Turquoise
            ], // Top to bottom gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                input,
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton('7', Colors.black),
                      _buildButton('8', Colors.black),
                      _buildButton('9', Colors.black),
                      _buildButton('÷', Colors.black),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton('4', Colors.black),
                      _buildButton('5', Colors.black),
                      _buildButton('6', Colors.black),
                      _buildButton('×', Colors.black),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton('1', Colors.black),
                      _buildButton('2', Colors.black),
                      _buildButton('3', Colors.black),
                      _buildButton('-', Colors.black),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton('0', Colors.black),
                      _buildButton('C', Colors.black), // Clear button
                      _buildButton('=', Colors.black), // Equals button
                      _buildButton('+', Colors.black),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String buttonText, Color buttonColor) {
    return ElevatedButton(
      onPressed: () => buttonPressed(buttonText),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        backgroundColor: buttonColor, // Button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
      ),
      child: Text(buttonText,
          style: const TextStyle(fontSize: 24, color: Color(0xFF6A5ACD))),
    );
  }
}
