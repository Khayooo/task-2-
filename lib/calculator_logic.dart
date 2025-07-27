import 'package:math_expressions/math_expressions.dart';

class CalculatorLogic {
  static String evaluateExpression(String expression) {
    expression = expression.replaceAll('×', '*').replaceAll('÷', '/');

    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      return result.toString();
    } catch (e) {
      return 'Error';
    }
  }
}
