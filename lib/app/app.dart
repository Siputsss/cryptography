import 'package:flutter/material.dart';
import '../ui_screens/a.home/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cryptography',
        debugShowCheckedModeBanner: false,
        // theme: ThemeData.dark(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Scaffold(
          body: HomePage(),
        ));
  }
}
