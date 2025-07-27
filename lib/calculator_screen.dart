import 'package:flutter/material.dart';
import 'calculator_logic.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '0';

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        result = '0';
      } else if (value == '=') {
        try {
          result = CalculatorLogic.evaluateExpression(input);
          input = '';
        } catch (e) {
          result = 'Error';
        }
      } else if (value == '⌫') {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else {
        input += value;
      }
    });
  }

  List<String> buttons = [
    'C', '(', ')', '÷',
    '7', '8', '9', '×',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '⌫', '0', '.', '=',
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Display section
          Container(
            height: screenHeight * 0.35,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.grey[900],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Input text
                Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      input,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Result text
                Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      result,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Buttons section
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  return buildButton(buttons[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(String text) {
    bool isOperator = ['÷', '×', '-', '+', '=', '(', ')'].contains(text);
    bool isSpecial = ['C', '⌫'].contains(text);

    Color buttonColor = Colors.grey[800]!;
    Color textColor = Colors.white;

    if (isOperator) {
      buttonColor = Colors.deepPurple;
    } else if (isSpecial) {
      buttonColor = Colors.blueGrey[700]!;
    }

    if (text == '=') {
      buttonColor = Colors.deepPurpleAccent;
    }

    return GestureDetector(
      onTap: () => buttonPressed(text),
      child: Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}