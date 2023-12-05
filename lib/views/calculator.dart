import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<Calculator> {
  var userQuestion = '';
  var result = '';

  final List<String> buttons = [
    'C',
    '/',
    '*',
    '<--',
    '7',
    '8',
    '9',
    '+',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '*',
    '%',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 8,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(right: 20),
                    child: Text(
                      userQuestion,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(right: 20),
                    child: Text(
                      result,
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 30,
              ),
              itemCount: buttons.length,
              itemBuilder: (BuildContext context, int index) {
                return ButtonsView(
                  buttonText: buttons[index],
                  buttonTapped: () {
                    setState(() {
                      handleButtonTap(index);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void handleButtonTap(int index) {
    // Clear button
    if (index == 0) {
      userQuestion = '';
      result = '';
    }
    // Delete button
    else if (index == 3) {
      userQuestion = userQuestion.substring(0, userQuestion.length - 1);
    }
    // Equal button
    else if (index == buttons.length - 1) {
      result = calculate();
    }
    // Number or decimal point button
    else if (index >= 4 && index <= 18) {
      if (result.isNotEmpty) {
        userQuestion = '';
        result = '';
      }
      userQuestion += buttons[index];
    }
    // Rest of the buttons
    else {
      userQuestion += buttons[index];
    }
  }

  String calculate() {
    try {
      var exp = Parser().parse(userQuestion);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      if (evaluation % 1 == 0) {
        return evaluation.toInt().toString();
      }
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }
}

class ButtonsView extends StatelessWidget {
  final String buttonText;
  final VoidCallback buttonTapped;

  const ButtonsView({
    Key? key,
    required this.buttonText,
    required this.buttonTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: buttonTapped,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(20),
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
