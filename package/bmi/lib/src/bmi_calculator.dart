

import 'package:intl/intl.dart';

double calculateBMI(double weight, double height) {
  return weight / (height * height);
}

String formattedBmi(double bmi) {
  final formatter = NumberFormat('###.#');
  return formatter.format(bmi);
}