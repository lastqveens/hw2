import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = "0";
  double firstOperand = 0;
  double secondOperand = 0;
  String operator = "";
  bool resetDisplay = false;

  // Method to handle button taps
  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _clear();
      } else if ("+-*/".contains(value)) {
        _setOperator(value);
      } else if (value == "=") {
        _calculateResult();
      } else {
        _appendNumber(value);
      }
    });
  }

  // Method to clear the display and reset variables
  void _clear() {
    display = "0";
    firstOperand = 0;
    secondOperand = 0;
    operator = "";
    resetDisplay = false;
  }

  // Method to set the operator
  void _setOperator(String value) {
    if (operator.isEmpty) {
      firstOperand = double.parse(display);
    } else {
      _calculateResult();
    }
    operator = value;
    resetDisplay = true;
  }

  // Method to append numbers to the display
  void _appendNumber(String value) {
    if (resetDisplay) {
      display = value;
      resetDisplay = false;
    } else {
      display = display == "0" ? value : display + value;
    }
  }

  // Method to calculate the result based on the operator
  void _calculateResult() {
    if (operator.isEmpty) return;

    secondOperand = double.parse(display);

    switch (operator) {
      case "+":
        display = (firstOperand + secondOperand).toString();
        break;
      case "-":
        display = (firstOperand - secondOperand).toString();
        break;
      case "*":
        display = (firstOperand * secondOperand).toString();
        break;
      case "/":
        if (secondOperand == 0) {
          display = "Error";
        } else {
          display = (firstOperand / secondOperand).toString();
        }
        break;
    }

    operator = "";
    resetDisplay = true;
  }

  // UI method to create the calculator button grid
  Widget _buildButton(String value) {
    return Expanded(
      child: InkWell(
        onTap: () => _onButtonPressed(value),
        child: Container(
          height: 70,
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display area
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(
                display,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            // Number and operator buttons
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildButton("7"),
                      _buildButton("8"),
                      _buildButton("9"),
                      _buildButton("/"),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("4"),
                      _buildButton("5"),
                      _buildButton("6"),
                      _buildButton("*"),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("1"),
                      _buildButton("2"),
                      _buildButton("3"),
                      _buildButton("-"),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("0"),
                      _buildButton("C"),
                      _buildButton("="),
                      _buildButton("+"),
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
}
