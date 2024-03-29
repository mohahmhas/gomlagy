import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomlgy/providers/localization/app_localizations.dart';
import 'package:gomlgy/screens/outhantication/regist.dart';
import 'package:gomlgy/screens/outhantication/send_code.dart';

import 'package:gomlgy/widget/text_field_auth.dart';
import 'package:gomlgy/providers/auth.dart';

import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _email, _password;
  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Consumer(builder: (context, watch, child) {
          final authData = watch(authDataProvider);
          print("Log in Page  " + authData.isAuth.toString());

          return Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Center(
                          //     child: Text(
                          //   AppLocalizations.of(context).translate('sign_in'),
                          //   style: TextStyle(color: Colors.white, fontSize: 20),
                          // )

                          child: Image.asset(
                        'assets/gomlgy_logo.png',
                        width: mediaQuerySize.width * 0.5,
                        height: mediaQuerySize.height * 0.1,
                        // scale: 5,
                      )),
                    ),
                    SizedBox(
                      height: mediaQuerySize.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context).translate('sign_in'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: 'Lobster'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: mediaQuerySize.height * 0.02,
                    )
                  ],
                ),
                //*********************************************************** */
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.67,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                      color: Colors.indigo, width: 1),
                                  right: BorderSide(
                                      color: Colors.indigo, width: 1),
                                ),
                              ),
                              child: Form(
                                key: _globalKey,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40.0),
                                      child: Column(
                                        children: [
                                          TextFieldsAuth(
                                            validation: (value) {
                                              String pattern =
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                                              RegExp regExp =
                                                  new RegExp(pattern);
                                              regExp.hasMatch(value);
                                              if (value.isEmpty == true ||
                                                  !regExp.hasMatch(value)) {
                                                return "Please enter a vaild e-mail";
                                              }

                                              return null;
                                            },
                                            onClick: (value) {
                                              setState(() {
                                                _email = value;
                                              });
                                            },
                                            icon: Icons.email_outlined,
                                            hint: AppLocalizations.of(context)
                                                .translate('email'),
                                          ),
                                          TextFieldsAuth(
                                            obscureText: true,
                                            validation: (value) {
                                              String pattern =
                                                  r'^(?=.*?[0-9]).{6,}$';
                                              RegExp regExp =
                                                  new RegExp(pattern);

                                              if (value.isEmpty == true) {
                                                return AppLocalizations.of(
                                                        context)
                                                    .translate(
                                                        'password_is_required');
                                              } else if (value.length < 6) {
                                                return AppLocalizations.of(
                                                        context)
                                                    .translate(
                                                        'password_is_required_and_must_be_6_characters_at_least');
                                              } else if (!regExp
                                                  .hasMatch(value)) {
                                                return //"Password should contain 1 UPPERCASE,\n1 lowercase, 1 num6er and 1 special at least."
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            'password_is_required_and_must_be_6_characters_at_least');
                                              }
                                              return null;
                                            },
                                            onClick: (value) {
                                              setState(() {
                                                _password = value;
                                              });
                                              _password = value;
                                            },
                                            icon: Icons.lock,
                                            hint: AppLocalizations.of(context)
                                                .translate('password'),
                                          ),
                                          SizedBox(
                                            height: height * 0.04,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _submit(context);
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      mediaQuerySize.height *
                                                          0.02,
                                                  horizontal: 30),
                                              child: Center(
                                                child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate('sign_in'),
                                                    style: TextStyle(
                                                        fontFamily: 'Lobster',
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .textScaleFactor *
                                                            18,
                                                        color: Colors.white)),
                                              ),
                                              decoration: BoxDecoration(
                                                // gradient: LinearGradient(
                                                //     colors: [
                                                //       primaryColor,
                                                //       secondaryColor
                                                //     ]),
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                  context, ForgetPassword.id);
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .translate('forgot_password'),
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, RegisterScreen.id);
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .translate(
                                                      'no_account_yet_create_one'),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ],
                    //==============================================================
                  ),
                ),
              ],
            ),
          );

          //     Navigator.of(context).pop();
        }));
  }
//cheack validattion **********************************************************

  void _submit(BuildContext context) async {
    print('1');
    if (!_globalKey.currentState.validate()) {
      // Invalid!
      return;
    }
    print('2');

    _globalKey.currentState.save();
    print('3');

    try {
      context.read(authDataProvider).signin(_email, _password).then((value) {
        if (!value) {
          print(context.read(authDataProvider).isVerified);
          if (context.read(authDataProvider).isVerified) {
            Fluttertoast.showToast(
                msg: "Email or password incorrect",
                gravity: ToastGravity.TOP,
                fontSize: MediaQuery.of(context).textScaleFactor * 12);
          } else {
            Navigator.pushNamed(context, SendCode.id);
          }
        } else {
          // signed in
          //Navigator.pushNamed(context, MainPgae.id);
          Navigator.pop(context);
        }
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: "An Error occurred!",
          gravity: ToastGravity.TOP,
          fontSize: MediaQuery.of(context).textScaleFactor * 12);
    }
  }
}
