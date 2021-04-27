import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomlgy/providers/search_provider.dart';

class TextFields extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  final Function onTap;

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

  TextFields({this.onClick, @required this.hint, this.icon, this.onTap});
  //final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // _focusNode.addListener(() {
    //   onTap();
    // });
    return Padding(
      padding: const EdgeInsets.only(right: 18 , left: 18 ),
      child: Container(
        
          height: 50,
          child: Consumer(builder: (ctx, watch, child) {
            return TextFormField(
              textAlignVertical: TextAlignVertical.center,
              onChanged: (val) {
                print(val);
                context
                    .read(provider)
                    .fetchAndSetdData(val, fromSearch: true);
              },
              // focusNode: _focusNode,
              onTap: onTap,
              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) {
                  return _errorMassage(hint);
                }
              },
              onSaved: onClick,
              obscureText: hint == 'Enter your Password' ? true : false,
              decoration: InputDecoration(
                
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                prefixIcon: Icon(
                  icon,
                  color: Colors.black,
                  size: 30,
                ), //icon
                filled: true,
                fillColor: Colors.white,
                hintText: hint,

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                border: InputBorder.none,

                labelStyle: TextStyle(
                  color: Colors.white70,
                ),
              ),
            );
          })),
    );
  }
}
