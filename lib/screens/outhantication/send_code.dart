import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomalgy/providers/auth.dart';
import 'package:gomalgy/providers/localization/app_localizations.dart';
import 'package:gomalgy/screens/outhantication/log_screen.dart';
import 'package:gomalgy/widget/text_filed_outh.dart';
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
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gomlgy',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 10, bottom: 10),
                    child: Text(
                      AppLocalizations.of(context).translate('send_code'),
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
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
                  key: _globalKey,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Column(
                          children: [
                            TextFieldsOuth(
                              onClick: (value) {
                                setState(() {
                                  _code = value;
                                });
                              },
                              valed: (value) {
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
                                      _validate(context);
                                      // Bottom Logins
                                    },
                                    child: Center(
                                        child: Center(
                                            child: Text(
                                                AppLocalizations.of(context)
                                                    .translate('confirm'))))),
                              ),
                            ),
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
