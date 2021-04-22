import 'package:flutter/material.dart';

class TextFieldsOuth extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  final Function valed;
  final Function change;
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

  TextFieldsOuth(
      {this.onClick,
      @required this.hint,
      @required this.icon,
      this.valed,
      this.change});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 15.0, bottom: 0, right: 8, left: 8),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              onChanged: change,
              // ignore: missing_return
              validator: valed,
              // (value) {
              //   if (value.isEmpty) {
              //     return _errorMassage(hint);
              //   }
              // },
              onSaved: onClick,

              obscureText: icon == Icons.lock ? true : false,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: Colors.black,
                ), //icon
                filled: true,
                fillColor: Colors.grey,
                hintText: hint,

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[600]),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[600]),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[600]),
                ),
                border: InputBorder.none,

                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
