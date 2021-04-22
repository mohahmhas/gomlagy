import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TextFieldsCopon extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  final Function onchanged;
  final bool boolen;
  // ignore: missing_return
  String _errorMassage(String str) {
    switch (hint) {
      case 'Enter your Email':
        return 'Email is Required !';

      case 'Enter your Password':
        return 'passwoed is Required !';

      case 'Enter your Name':
        return 'Name is Required !';
    }
  }

  TextFieldsCopon(
      {this.onClick,
      @required this.hint,
      this.icon,
      this.onchanged,
      this.boolen});

  String couponCode;
  final TextControllerCoupon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width -
              (MediaQuery.of(context).size.width / 3.5),
          height: 60,
          child: TextFormField(
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return _errorMassage(hint);
              }
            },
            // focusNode: ,
            onSaved: onClick,
            onChanged: (value) {
              couponCode = value;
            },
            controller: TextControllerCoupon,
            obscureText: hint == 'Enter your Password' ? true : false,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.grey,
              ), //icon
              filled: true,
              fillColor: Colors.grey[300],
              hintText: hint,

              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]),
              ),
              border: InputBorder.none,

              labelStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            keyboardType: TextInputType.text,
          ),
        ),
        boolen == true
            ? Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 3.5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    TextControllerCoupon.clear();
                    showDialog(
                        context: context,
                        builder: (c) => AlertDialog(
                              title: Row(
                                children: [
                                  CircularProgressIndicator(),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Please wait.Your Request\n is Processing',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: MediaQuery.of(context)
                                                  .textScaleFactor *
                                              14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        barrierDismissible: false);
                  },
                  child: Text('Apply Order'),
                ),
              )
            : Card(),
      ],
    );
  }
}
