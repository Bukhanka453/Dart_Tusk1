import 'dart:io';
import 'dart:math';

void main() {
  print('=== Калькулятор с поддержкой арифметики, сравнений и логики ===');
  print('Доступные операторы:');
  print('Арифметика: +, -, *, /, ~/, %, pow');
  print('Сравнения: ==, !=, >, <, >=, <=');
  print('Логика: &&, ||, !');
  print('Для логических операций числа 0 = false, любые другие = true');
  print('Для "!" нужен один операнд, для остальных бинарных — два.\n');

  while (true) {
    try {
      // Запрос оператора
      stdout.write('\nВведите оператор (или "exit" для выхода): ');
      String? operator = stdin.readLineSync()?.trim();
      if (operator == null || operator.toLowerCase() == 'exit') break;

      dynamic result;

      // Унарный оператор "!"
      if (operator == '!') {
        double a = _readNumber('Введите операнд (число): ');
        result = _logicalNot(a);
        print('Результат: $result');
        continue;
      }

      // Бинарные операторы (все остальные)
      double a = _readNumber('Введите первый операнд: ');
      double b = _readNumber('Введите второй операнд: ');

      result = _executeBinary(operator, a, b);
      print('Результат: $result');
    } catch (e) {
      print('Ошибка: $e. Попробуйте снова.');
    }
  }
  print('До свидания!');
}

double _readNumber(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();
    if (input == null) continue;
    try {
      return double.parse(input);
    } catch (_) {
      print('Некорректное число. Повторите ввод.');
    }
  }
}

dynamic _executeBinary(String operator, double a, double b) {
  switch (operator) {
    // Арифметические операции
    case '+':
      return a + b;
    case '-':
      return a - b;
    case '*':
      return a * b;
    case '/':
      if (b == 0) throw Exception('Деление на ноль!');
      return a / b;
    case '~/':
      // Целочисленное деление — приводим к int
      int intA = a.toInt();
      int intB = b.toInt();
      if (intB == 0) throw Exception('Целочисленное деление на ноль!');
      return intA ~/ intB;
    case '%':
      if (b == 0) throw Exception('Остаток от деления на ноль!');
      return a % b;
    case 'pow':
      return pow(a, b); // возвращает num (int/double)

    // Операции сравнения 
    case '==':
      return a == b;
    case '!=':
      return a != b;
    case '>':
      return a > b;
    case '<':
      return a < b;
    case '>=':
      return a >= b;
    case '<=':
      return a <= b;

    // Логические операции
    case '&&':
      return _toBool(a) && _toBool(b);
    case '||':
      return _toBool(a) || _toBool(b);

    default:
      throw Exception('Неизвестный оператор "$operator"');
  }
}

bool _toBool(double x) => x != 0.0; // 0 -> false, иначе true

bool _logicalNot(double a) => !_toBool(a);