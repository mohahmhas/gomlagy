import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomlgy/providers/auth.dart';
import 'package:gomlgy/providers/localization/app_localizations.dart';
import 'package:gomlgy/screens/outhantication/log_screen.dart';
import 'package:gomlgy/widget/text_field_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendCode extends StatefulWidget {
  static String id = 'SendCode';
  @override
  _SendState createState() => _SendState();
}

class _SendState extends State<SendCode> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _code;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // if (context.read(authDataProvider).isVerified) {
    //   Navigator.pop(context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: [
          Column(
            children: [
              Center(
                  child: Image.asset(
                'assets/gomlgy_logo.png',
                width: mediaQuerySize.width * 0.5,
                height: mediaQuerySize.height * 0.1,
                // scale: 5,
              )),
              SizedBox(
                height: mediaQuerySize.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('send_code'),
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
                  key: _globalKey,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Column(
                          children: [
                            TextFieldsAuth(
                              onClick: (value) {
                                setState(() {
                                  _code = value;
                                });
                              },
                              validation: (value) {
                                if (value.isEmpty == true) {
                                  return AppLocalizations.of(context)
                                      .translate('send_code');
                                }
                                return null;
                              },
                              icon: Icons.email_outlined,
                              hint: AppLocalizations.of(context)
                                  .translate('send_code'),
                            ),
                            SizedBox(
                              height: height * 0.04,
                            ),
                            InkWell(
                              onTap: () {
                                _validate(context);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.symmetric(
                                    vertical: mediaQuerySize.height * 0.02,
                                    horizontal: 30),
                                child: Center(
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate('confirm'),
                                      style:
                                          TextStyle(
                                              fontFamily: 'Lobster',
                                              fontSize: MediaQuery.of(context)
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
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ], //
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
//cheack validattion **********************************************************

  void _validate(BuildContext context) async {
    print('1');
    if (!_globalKey.currentState.validate()) {
      // Invalid!
      return;
    }
    print('2');

    _globalKey.currentState.save();
    print('3');

    try {
      context.read(authDataProvider).sendCode(_code).then((value) {
        if (!value) {
          Fluttertoast.showToast(
              msg: "Wrong code",
              gravity: ToastGravity.TOP,
              fontSize: MediaQuery.of(context).textScaleFactor * 12);
        } else {
          // signed in
          Navigator.pushReplacementNamed(context, LoginScreen.id);

          // Navigator.pop(context);
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
