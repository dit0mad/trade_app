import 'package:flutter/material.dart';
import 'package:trade_app/webScreen.dart';
import 'package:trade_app/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: WebViewScreen(),
      routes: {
        WebViewScreen.id : (context) => WebViewScreen(),
        WelcomeScreen.id : (context) => WelcomeScreen(),
      },
    );
  }
}

