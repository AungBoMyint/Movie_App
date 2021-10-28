import 'package:flutter/material.dart';
import 'package:movie_app/pages/home_page.dart';
import 'pages/pages.dart';

class RouteGenerator {
  static const String mainPage = '/';
  static const String detailPage = '/detailPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainPage:
        return MaterialPageRoute(builder: (context) => const MainPage());
      case detailPage:
        return MaterialPageRoute(builder: (context) => const HomePage());
      default:
        throw const FormatException();
    }
  }
}
