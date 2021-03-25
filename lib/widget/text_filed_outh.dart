import 'package:flutter/material.dart';

class TextFieldsOuth extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
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

  TextFieldsOuth({this.onClick, @required this.hint, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 15.0, bottom: 0, right: 8, left: 8),
            child: Container(
              height: 60,
              child: TextFormField(
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return _errorMassage(hint);
                  }
                },
                onSaved: onClick,
                obscureText: hint == 'Enter your Password' ? true : false,
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
        ),
      ],
    );
  }
}
