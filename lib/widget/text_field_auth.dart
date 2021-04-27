import 'package:flutter/material.dart';

class TextFieldsAuth extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  final Function validation;
  final Function change;
  final obscureText;

  TextFieldsAuth(
      {this.onClick,
      @required this.hint,
      @required this.icon,
      this.validation,
      this.change,
      this.obscureText = false});

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
              validator: validation,
              onSaved: onClick,
              obscureText: obscureText,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: Colors.black,
                ), //icon
                filled: true,
                fillColor: Colors.grey.withOpacity(0.3),
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
