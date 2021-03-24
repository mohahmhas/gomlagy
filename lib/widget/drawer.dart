import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
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
                    child: Text('SIGN IN /REGISTER'),
                  ),
                ],
              ),
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.charging_station_rounded),
              title: Text('charging'),
            ),
            ListTile(
              leading: Icon(Icons.charging_station_rounded),
              title: Text('charging'),
            ),
            ListTile(
              leading: Icon(Icons.charging_station_rounded),
              title: Text('charging'),
            ),
            ListTile(
              leading: Icon(Icons.charging_station_rounded),
              title: Text('charging'),
            ),
            ListTile(
              leading: Icon(Icons.charging_station_rounded),
              title: Text('charging'),
            ),
            ListTile(
              leading: Icon(Icons.charging_station_rounded),
              title: Text('charging'),
            ),
            ListTile(
              leading: Icon(Icons.charging_station_rounded),
              title: Text('charging'),
            ),
            ListTile(
              leading: Icon(Icons.charging_station_rounded),
              title: Text('charging'),
            ),
          ],
        ),
      ),
    );
  }
}
