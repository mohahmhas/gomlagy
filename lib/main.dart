import 'package:flutter/material.dart';
import 'package:gomalgy/mainPage.dart';
import 'package:gomalgy/screens/outhantication/log_screen.dart';
import 'package:gomalgy/screens/outhantication/regist.dart';
import 'package:gomalgy/screens/outhantication/send_code.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange[900],
      ),
      initialRoute: MainPgae.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        SendCode.id: (context) => SendCode(),
      },
      home: MainPgae(),
    );
  }
}
