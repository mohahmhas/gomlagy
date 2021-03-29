import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomalgy/mainPage.dart';
import 'package:gomalgy/screens/outhantication/log_screen.dart';
import 'package:gomalgy/screens/outhantication/regist.dart';
import 'package:gomalgy/screens/outhantication/send_code.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

//wellcom
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.orange[900],
        ),
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          SendCode.id: (context) => SendCode(),
        },
        home: SplashScreenView(
          home: MainPgae(),
          duration: 3000,
          imageSize: 100,
          imageSrc: "assets/logo_o_foreground.png",
          // text: "Normal Text",
          textType: TextType.NormalText,
          textStyle: TextStyle(
            fontSize: 30.0,
          ),
          backgroundColor: Colors.orange[900],
        ),
      ),
    );
  }
}
