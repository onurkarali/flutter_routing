import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/root_page.dart';
import 'package:flutter_application_1/pages/second_page.dart';
import 'package:flutter_application_1/pages/third_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/root",
      routes: {
        '/root': (context) => const RootPage(title: "Root Page"),
        '/second': (context) => const SecondPage(),
        '/third': (context) => const ThirPage(),
      },
    );
  }
}
