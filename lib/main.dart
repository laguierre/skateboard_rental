import 'package:flutter/material.dart';

import 'intro_page/intro_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Snowboard Rental',
      theme: ThemeData(
        fontFamily: 'Mulish',
        primarySwatch: Colors.blue,
      ),
      home: const IntroPage(),
    );
  }
}
