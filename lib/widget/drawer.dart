import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomalgy/screens/outhantication/log_screen.dart';
import 'package:gomalgy/screens/outhantication/regist.dart';
import 'package:gomalgy/providers/drawer_provider.dart';

final drawerProvider = ChangeNotifierProvider<DrawerData>((ref) {
  return DrawerData();
});

class CustomDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final drawerData = watch(drawerProvider);
//  final int id;
    //final String name;
    //final int categoryid;
    //final Map<String, String> links;
    //final String image;

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
            FutureBuilder(
                future: drawerData.fetchAndSetCatdData(),
                builder: (ctx, snaptshot) {
                  if (snaptshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<Widget> list = [];
                  list = List.from(snaptshot.data.map((e) {
                    return drawerItem(
                      id: e.id,
                      image: e.image,
                      name: e.name,
                    );
                  }));

                  return Wrap(
                    //verticalDirection: tr,
                    children: list,
                  );
                })
          ],
        ),
      ),
    );
  }
}

class drawerItem extends StatelessWidget {
  final String image;
  final String name;
  final int id;

  drawerItem({this.image, this.name, this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //id
      },
      child: ListTile(
        leading: Image.network(
          image,
          scale: 20,
        ),
        title: Text(name),
      ),
    );
  }
}
