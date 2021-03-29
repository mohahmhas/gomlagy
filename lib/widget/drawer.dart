import 'package:flutter/material.dart';
import 'package:gomalgy/screens/outhantication/log_screen.dart';
import 'package:gomalgy/screens/outhantication/regist.dart';

class CustomDrawer extends StatelessWidget {
  final String name;
  final String image;

  const CustomDrawer({
    this.image,
    this.name,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 250,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.orange[200], Colors.orange[900]]),
              ),
              height: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/icons8_male_user_100_black.png',
                    width: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                          child: Text('SIGN IN '),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RegisterScreen.id);
                            },
                            child: Text('/REGISTER'))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Image.network('assets/icons8_male_user_100_black.png'),
              title: Text('name'),
            ),
          ],
        ),
      ),
    );
  }
}
