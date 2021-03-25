import 'package:flutter/material.dart';
import 'package:gomalgy/widget/text_filed_outh.dart';

//C:\Users\moham\AppData\Local\Android\Sdk\.temp\PackageOperation02\unzip\platform-tools
class RegisterScreen extends StatefulWidget {
  static String id = 'RegisterScreen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _email, _password;
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
                Form(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFieldsOuth(
                              icon: Icons.lock,
                              hint: 'Name',
                            ),
                            TextFieldsOuth(
                              onClick: (value) {
                                _email = value;
                              },
                              icon: Icons.email_outlined,
                              hint: ' Email',
                            ),
                            TextFieldsOuth(
                              onClick: (value) {
                                _password = value;
                              },
                              icon: Icons.lock,
                              hint: 'Password',
                            ),
                            SizedBox(
                              height: height * 0.04,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
                              child: Container(
                                height: height * 0.06,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      textStyle: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      // Bottom Logins
                                      if (formKey.currentState.validate()) {
                                        formKey.currentState.save();
                                      }
                                    },
                                    child: Center(
                                        child: Center(child: Text('SING UP')))),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
