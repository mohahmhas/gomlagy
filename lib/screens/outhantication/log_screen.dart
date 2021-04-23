import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomalgy/providers/localization/app_localizations.dart';
import 'package:gomalgy/screens/outhantication/regist.dart';
import 'package:gomalgy/screens/outhantication/send_code.dart';

import 'package:gomalgy/widget/text_filed_outh.dart';
import 'package:gomalgy/providers/auth.dart';

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
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Consumer(builder: (context, watch, child) {
          final authData = watch(authDataProvider);
          print("Log in Page  " + authData.isAuth.toString());

          return ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(
                        child: Text(
                      AppLocalizations.of(context).translate('my_account'),
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
                        AppLocalizations.of(context).translate('sign_in'),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
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
                                left:
                                    BorderSide(color: Colors.indigo, width: 5),
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
                                        TextFieldsOuth(
                                          valed: (value) {
                                            String pattern =
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                                            RegExp regExp = new RegExp(pattern);
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
                                              .translate('email_is_required'),
                                        ),
                                        TextFieldsOuth(
                                          valed: (value) {
                                            String pattern =
                                                r'^(?=.*?[0-9]).{6,}$';
                                            RegExp regExp = new RegExp(pattern);

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
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25, right: 25),
                                          child: Container(
                                            height: height * 0.06,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Theme.of(context)
                                                      .primaryColor,
                                                  textStyle: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                onPressed: () {
                                                  _submit(context);
                                                },
                                                child: Center(
                                                    child: Center(
                                                        child: Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .translate(
                                                                    'sign_in'))))),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // Navigator.pushNamed(
                                            //     context, SendCode.id);
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
