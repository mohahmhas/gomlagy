import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomlgy/helpers/base_url.dart';
import 'package:gomlgy/screens/details_prodect/details_page.dart';
import 'package:gomlgy/screens/outhantication/log_screen.dart';
import 'package:gomlgy/screens/outhantication/regist.dart';
import 'package:gomlgy/providers/drawer_provider.dart';
import 'package:gomlgy/screens/seeAll_products.dart';
import '../providers/auth.dart';

class CustomDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final drawerData = watch(drawerProvider);
//  final int id;
    //final String name;
    //final int categoryid;
    //final Map<String, String> links;
    //final String image;
    List<Widget> list = [];
    list = List.from(context.read(drawerProvider).drawerData.map((e) {
      return drawerItem(
        id: e.id,
        image: e.image,
        name: e.name,
      );
    }));
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
                    child: Consumer(builder: (context, watch, child) {
                      final auth = watch(authDataProvider);
                      return auth.isAuth
                          ? Text(auth.username)
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, LoginScreen.id);
                                  },
                                  child: Text('SIGN IN '),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RegisterScreen.id);
                                    },
                                    child: Text('/REGISTER'))
                              ],
                            );
                    }),
                  ),
                ],
              ),
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            // FutureBuilder(
            //     future: drawerData.fetchAndSetCatdData(),
            //     builder: (ctx, snaptshot) {
            //       if (snaptshot.connectionState == ConnectionState.waiting) {
            //         return Center(child: CircularProgressIndicator());
            //       }

            Wrap(
              //verticalDirection: tr,
              children: list,
            )
            //   })
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
        print('id printed $id'); //id
        print('id printed $name'); //name
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SeeAllProducts(
              appBarName: name,
              // https://www.gomlgy.com/api/v1/products/sub-category/
              url: Urls.api + '/products/sub-category/' + id.toString(),
            ),
          ),
        );
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
