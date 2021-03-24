import 'package:flutter/material.dart';
import 'text_fields.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
    @required this.drawerKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> drawerKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      color: Colors.orange[900],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 16, 15, 10),
            child: Container(
              //**===========================================>//Icons AppBar
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        drawerKey.currentState.openDrawer();
                      },
                      child: Icon(
                        (Icons.menu),
                        color: Colors.white,
                      )),
                  // Image.asset('assets/gomlgy_logo.png'),

                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  )
                ],
              ),
              //**======================================>//TextFiled and search Icon AppBar
            ),
          ),
          TextFields(
            icon: Icons.search,
            hint: 'what are you looking for?',
          ),
          //**============================================================>
        ],
      ),
    );
  }
}
