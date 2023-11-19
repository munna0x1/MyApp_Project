import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:math_expressions/math_expressions.dart';

void main() { 
  runApp(CalculatorPage()); 
} 
 
class CalculatorPage extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      title: 'Scientific Calculator', 
      theme: ThemeData( 
        primarySwatch: Colors.blue, 
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
  String input = ''; 
  String output = ''; 
 
void onButtonPressed(String buttonText) {
  setState(() {
    if (buttonText == 'C') {
      input = '';
      output = '';
    } else if (buttonText == '=') {
      try {
        Parser p = Parser();
        Expression exp = p.parse(input);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        output = eval.toString();
        input = output;
      } catch (e) {
        input = 'Error';
        output = '';
      }
    } else if (buttonText == 'AC') { // Handle the "AC" button here
      input = '';
      output = '';
    } else {
      if (buttonText == '×') {
        buttonText = '*';
      } else if (buttonText == '÷') {
        buttonText = '/';
      }
      input += buttonText;
    }
  });
}

  void onScientificFunctionPressed(String buttonText) { 
    if (input.isNotEmpty && !input.endsWith(')')) { 
      input += buttonText + '('; 
    } else { 
      input += buttonText; 
    } 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: Text('Scientific Calculator'), 
      ), 
      body: Column( 
        children: <Widget>[ 
          Expanded( 
            flex: 2, 
            child: Container( 
              padding: EdgeInsets.all(16.0), 
              alignment: Alignment.bottomRight, 
              child: Text( 
                input, 
                style: TextStyle(fontSize: 24), 
              ), 
            ), 
          ), 
          Expanded( 
            flex: 8, 
            child: Container( 
              child: Column( 
                children: <Widget>[ 
                  buildButtonRow(['sin', 'cos', 'tan', '√']), 
                  buildButtonRow(['7', '8', '9', '÷']), 
                  buildButtonRow(['4', '5', '6', '×']), 
                  buildButtonRow(['1', '2', '3', '-']), 
                  buildButtonRow(['AC', '0', '=', '+']), 
                ], 
              ), 
            ), 
          ), 
        ], 
      ), 
    ); 
  } 
 
  Widget buildButtonRow(List<String> buttons) { 
    return Expanded( 
      child: Row( 
        crossAxisAlignment: CrossAxisAlignment.stretch, 
        children: buttons 
            .map( 
              (buttonText) => buildButton( 
                buttonText, 
                buttonText == '=' ? Colors.blue : Color.fromARGB(255, 250, 250, 250), 
              ), 
            ) 
            .toList(), 
      ), 
    ); 
  } 
 
  Widget buildButton(String buttonText, Color color) { 
    return Expanded( 
      child: GestureDetector( 
        onTap: () { 
          if (buttonText == 'sin' || 
              buttonText == 'cos' || 
              buttonText == 'tan' || 
              buttonText == '√') { 
            onScientificFunctionPressed(buttonText); 
          } else { 
            onButtonPressed(buttonText); 
          } 
        }, 
        child: Container( 
          color: color, 
          child: Center( 
            child: Text( 
              buttonText, 
              style: TextStyle(fontSize: 24), 
            ), 
          ), 
        ), 
      ), 
    ); 
  } 
}