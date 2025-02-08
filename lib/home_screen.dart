import 'package:calculator/components/my_botton.dart';
import 'package:calculator/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userInput = '';
  var answer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              // Display area for user input and answer.
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        userInput,
                        style: const TextStyle(
                          fontSize: 48,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        answer,
                        style: const TextStyle(
                          fontSize: 36,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Button area.
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    // First row of buttons.
                    Row(
                      children: [
                        MyButton(
                          title: 'Ac',
                          onPress: () {
                            setState(() {
                              userInput = '';
                              answer = '';
                            });
                          },
                          color: Colors.grey,
                        ),
                        MyButton(
                          title: '+/-',
                          onPress: () {
                            setState(() {
                              userInput += '+/-';
                            });
                          },
                          color: Colors.grey,
                        ),
                        MyButton(
                          title: '%',
                          onPress: () {
                            setState(() {
                              userInput += '%';
                            });
                          },
                          color: Colors.grey,
                        ),
                        MyButton(
                          title: '/',
                          onPress: () {
                            setState(() {
                              userInput += '/';
                            });
                          },
                          color: Colors.orange,
                        ),
                      ],
                    ),
                    // Second row of buttons.
                    Row(
                      children: [
                        MyButton(
                          title: '7',
                          onPress: () {
                            setState(() {
                              userInput += '7';
                            });
                          },
                          color: Colors.grey[850]!,
                        ),
                        MyButton(
                          title: '8',
                          onPress: () {
                            setState(() {
                              userInput += '8';
                            });
                          },
                          color: Colors.grey[850]!,
                        ),
                        MyButton(
                          title: '9',
                          onPress: () {
                            setState(() {
                              userInput += '9';
                            });
                          },
                          color: Colors.grey[850]!,
                        ),
                        MyButton(
                          title: 'x',
                          onPress: () {
                            setState(() {
                              userInput += 'x';
                            });
                          },
                          color: Colors.orange,
                        ),
                      ],
                    ),
                    // Third row of buttons.
                    Row(
                      children: [
                        MyButton(
                          title: '4',
                          onPress: () {
                            setState(() {
                              userInput += '4';
                            });
                          },
                          color: Colors.grey[850]!,
                        ),
                        MyButton(
                          title: '5',
                          onPress: () {
                            setState(() {
                              userInput += '5';
                            });
                          },
                          color: Colors.grey[850]!,
                        ),
                        MyButton(
                          title: '6',
                          onPress: () {
                            setState(() {
                              userInput += '6';
                            });
                          },
                          color: Colors.grey[850]!,
                        ),
                        MyButton(
                          title: '-',
                          onPress: () {
                            setState(() {
                              userInput += '-';
                            });
                          },
                          color: Colors.orange,
                        ),
                      ],
                    ),
                    // Fourth row of buttons.
                    Row(
                      children: [
                        MyButton(
                          title: '1',
                          onPress: () {
                            setState(() {
                              userInput += '1';
                            });
                          },
                          color: Colors.grey[850]!,
                        ),
                        MyButton(
                          title: '2',
                          onPress: () {
                            setState(() {
                              userInput += '2';
                            });
                          },
                          color: Colors.grey[850]!,
                        ),
                        MyButton(
                          title: '3',
                          onPress: () {
                            setState(() {
                              userInput += '3';
                            });
                          },
                          color: Colors.grey[850]!,
                        ),
                        MyButton(
                          title: '+',
                          onPress: () {
                            setState(() {
                              userInput += '+';
                            });
                          },
                          color: Colors.orange,
                        ),
                      ],
                    ),
                    // Fifth row of buttons.
                    Row(
                      children: [
                        MyButton(
                          title: '0',
                          onPress: () {
                            setState(() {
                              userInput += '0';
                            });
                          },
                          color: Colors.grey[850]!,
                        ),
                        MyButton(
                          title: '.',
                          onPress: () {
                            setState(() {
                              userInput += '.';
                            });
                          },
                          color: Colors.grey[850]!,
                        ),
                        MyButton(
                          title: 'Del',
                          onPress: () {
                            setState(() {
                              if (userInput.isNotEmpty) {
                                userInput = userInput.substring(0, userInput.length - 1);
                                answer = '';
                              }
                            });
                          },
                          color: Colors.grey,
                        ),
                        MyButton(
                          title: '=',
                          onPress: () {
                            equalPress();
                            setState(() {});
                          },
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void equalPress() {
    try {
      String finalUserInput = userInput;
      // Replace 'x' with '*' for multiplication.
      finalUserInput = finalUserInput.replaceAll('x', '*');
      Parser p = Parser();
      Expression expression = p.parse(finalUserInput);
      ContextModel contextModel = ContextModel();
      double eval = expression.evaluate(EvaluationType.REAL, contextModel);
      answer = eval.toString();
    } catch (e) {
      answer = 'Error';
    }
  }
}