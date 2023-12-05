import 'package:calculator/views/calculator.dart';

class AppRoute {
  AppRoute._();
  static const String calcRoute = "/";

  static getApplicationRoute() {
    return {
      calcRoute: (context) => const Calculator(),
    };
  }
}
