import 'package:pedomanku/page/ayatkursi_page.dart';
import 'package:pedomanku/page/bacaantahlil.dart';
import 'package:flutter/material.dart';
import 'package:pedomanku/page/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        home: const BerandaPage(),
      ),
    );
  }
}
