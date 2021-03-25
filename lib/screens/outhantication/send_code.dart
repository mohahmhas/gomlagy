import 'package:flutter/material.dart';
import 'package:gomalgy/screens/outhantication/regist.dart';

import 'package:gomalgy/widget/text_filed_outh.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                    child: Text(
                  'My Account',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
              ),
              SizedBox(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'SING IN',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Stack(
              children: [
                Container(
                  height: height * 0.67,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0),
                    ),
                    color: Colors.white,
                    border: Border(
                      left: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFieldsOuth(
                            icon: Icons.email_outlined,
                            hint: 'Enter Your email',
                          ),
                          TextFieldsOuth(
                            icon: Icons.lock,
                            hint: 'Enter Your password',
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: Container(
                              height: height * 0.06,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).primaryColor,
                                    textStyle: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    // Bottom Logins
                                  },
                                  child: Center(
                                      child: Center(child: Text('SING IN')))),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          GestureDetector(
                            onTap: () {
                              //  Navigator.pushNamed(context, ForgotPasswoed.id);
                            },
                            child: Text(
                              'Forgot Passwoed?',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RegisterScreen.id);
                            },
                            child: Text(
                              'No account yet Create one',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
