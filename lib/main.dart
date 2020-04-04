
import 'package:Minima.list/pages/homepage.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minima.list',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
      ),
      home: SplashScreen(
        'assets/minimalsplash.flr',
        CallHome(),
        startAnimation: 'Untitled',
        backgroundColor: Color(0xFF424242),
      ),
    );
  }
}

class CallHome extends StatefulWidget {
  @override
  _CallHomeState createState() => _CallHomeState();
}

class _CallHomeState extends State<CallHome> {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}


