import 'package:math_expressions/math_expressions.dart';
import 'package:calculator/custom_color.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double firstNumber = 0.0;
  double secondNumber = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputsize = 34.0;

  onButtonClick(value) {


    if (value == "AC") {
      input = "";
      output = "";
    } else if (value == "C") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
      return;
    } else if (value == "=") {

      if(value.toString() == "")

      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser parser = Parser();
        Expression expression = parser.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputsize = 52;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputsize = 34.0;
    }
    setState(() {});
  }

  Widget customButton(
      {text, flx, color = Colors.white, btnBgColor = Colors.white24}) {
    return Expanded(
        flex: flx,
        child: Container(
            margin: const EdgeInsets.all(8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: btnBgColor,
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () => onButtonClick(text),
                child: Text(
                  "${text}",
                  style: TextStyle(color: color),
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.themeBgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hideInput ? "" : input,
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
                const MySizeBox(
                  space: 20,
                ),
                Text(
                  "${output}",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7), fontSize: outputsize),
                ),
              ],
            ),
          )),
          const MySizeBox(space: 20.3),
          Row(
            children: [
              customButton(text: "AC", flx: 1, color: CustomColor.txtColor),
              customButton(text: "C", flx: 1, color: CustomColor.txtColor),
              customButton(text: "%", flx: 1, color: CustomColor.txtColor),
              customButton(text: "/", flx: 1, color: CustomColor.txtColor),
            ],
          ),
          Row(
            children: [
              customButton(text: "7", flx: 1),
              customButton(text: "8", flx: 1),
              customButton(text: "9", flx: 1),
              customButton(text: "x", flx: 1, color: CustomColor.txtColor),
            ],
          ),
          Row(
            children: [
              customButton(text: "4", flx: 1),
              customButton(text: "5", flx: 1),
              customButton(text: "6", flx: 1),
              customButton(text: "-", flx: 1, color: CustomColor.txtColor),
            ],
          ),
          Row(
            children: [
              customButton(text: "1", flx: 1),
              customButton(text: "2", flx: 1),
              customButton(text: "3", flx: 1),
              customButton(text: "+", flx: 1, color: CustomColor.txtColor),
            ],
          ),
          Row(
            children: [
              customButton(text: "0", flx: 2),
              customButton(text: ".", flx: 1, color: CustomColor.txtColor),
              customButton(text: "=", flx: 1, btnBgColor: CustomColor.txtColor),
            ],
          ),
        ],
      ),
    );
  }
}

class MySizeBox extends StatelessWidget {
  final double? space;

  const MySizeBox({Key? key, this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: space,
    );
  }
}
