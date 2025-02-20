import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';

  // Buttons in Calculator
  final List<String> buttons = [
    'AC',
    '%',
    'DEL',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '00',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  Color buttonColor = Colors.blueGrey;
                  if (buttons[index] == 'AC' ||
                      buttons[index] == '%' ||
                      buttons[index] == 'DEL' ||
                      buttons[index] == '/' ||
                      buttons[index] == 'x' ||
                      buttons[index] == '-' ||
                      buttons[index] == '+') {
                    buttonColor = Colors.grey;
                  } else {
                    buttonColor = Colors.orange;
                  }
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        handleExpression(buttons[index]);
                      });
                    },
                    buttonText: buttons[index],
                    color: buttonColor,
                    textColor: Colors.white,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  // This function will calculate the input mathematical operations
  void equalPressed() {
    try {
      String finalUserInput = userInput.replaceAll('x', '*');
      GrammarParser p = GrammarParser();
      Expression exp = p.parse(finalUserInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      answer = eval.toString();
    } catch (e) {
      answer = 'Cannot Evaluate Expression';
    }
  }

  //This function will handle the expression. Override the first operator when second operator is written
  void handleExpression(String buttonText) {
    if (buttonText == 'AC') {
      userInput = '';
      answer = '0';
    } else if (buttonText == 'DEL') {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
      }
    } else if (buttonText == '=') {
      equalPressed();
    } else {
      if (userInput.isNotEmpty &&
          isOperator(userInput[userInput.length - 1]) &&
          isOperator(buttonText) &&
          buttonText != '-') {
        userInput = userInput.substring(0, userInput.length - 1) + buttonText;
      } else {
        userInput = userInput + buttonText;
      }
    }
  }
}
