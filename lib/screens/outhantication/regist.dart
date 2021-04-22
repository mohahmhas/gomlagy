import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomalgy/providers/auth.dart';
import 'package:gomalgy/providers/localization/app_localizations.dart';
import 'package:gomalgy/screens/outhantication/log_screen.dart';
import 'package:gomalgy/screens/outhantication/send_code.dart';
import 'package:gomalgy/widget/text_filed_outh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//C:\Users\moham\AppData\Local\Android\Sdk\.temp\PackageOperation02\unzip\platform-tools
class RegisterScreen extends StatefulWidget {
  static String id = 'RegisterScreen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _email, _password, _userName;
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
                    AppLocalizations.of(context).translate('sign_up'),
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
                          left: BorderSide(color: Colors.indigo, width: 5),
                        ),
                      ),
                      child: Form(
                        key: _globalKey,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextFieldsOuth(
                                    onClick: (value) {
                                      setState(() {
                                        _userName = value;
                                      });
                                    },
                                    valed: (value) {
                                      if (value.isEmpty == true) {
                                        return AppLocalizations.of(context)
                                            .translate('name_is_required');
                                      } else if (value.length < 3) {
                                        return "Name must contain at least 3 characters";
                                      }
                                      return null;
                                    },
                                    icon: Icons.ad_units_rounded,
                                    hint: AppLocalizations.of(context)
                                        .translate('name'),
                                  ),
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
                                    hint: '' +
                                        AppLocalizations.of(context)
                                            .translate('email'),
                                  ),
                                  TextFieldsOuth(
                                    valed: (value) {
                                      String pattern = r'^(?=.*?[0-9]).{6,}$';
                                      RegExp regExp = new RegExp(pattern);

                                      if (value.isEmpty == true) {
                                        return AppLocalizations.of(context)
                                            .translate('password_is_required');
                                      } else if (value.length < 6) {
                                        return AppLocalizations.of(context)
                                            .translate(
                                                'password_is_required_and_must_be_6_characters_at_least');
                                      } else if (!regExp.hasMatch(value)) {
                                        return //"Password should contain 1 UPPERCASE,\n1 lowercase, 1 num6er and 1 special at least."
                                            AppLocalizations.of(context).translate(
                                                'password_is_required_and_must_be_6_characters_at_least');
                                      }
                                      return null;
                                    },
                                    onClick: (value) {
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
                                            primary:
                                                Theme.of(context).primaryColor,
                                            textStyle:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            _submit(context);
                                          },
                                          child: Center(
                                              child: Center(
                                                  child: Text(AppLocalizations
                                                          .of(context)
                                                      .translate('sign_up'))))),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  ///////////////////////////////////////////////////////////////
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              //==============================================================
            ),
          ),
        ],
      ),
    );
  }

//cheack validattion **********************************************************
  //ToDO
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
      context
          .read(authDataProvider)
          .signup(_email, _password, _userName)
          .then((value) {
        if (!value) {
          Fluttertoast.showToast(
              msg: "Enter a valid email",
              gravity: ToastGravity.TOP,
              fontSize: MediaQuery.of(context).textScaleFactor * 12);
        } else {
          // signed in
          //Navigator.pushNamed(context, MainPgae.id);
          Navigator.pushReplacementNamed(context, LoginScreen.id);
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
