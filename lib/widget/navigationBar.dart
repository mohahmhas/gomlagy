import 'package:flutter/material.dart';
import 'package:curved_bottom_navigation/curved_bottom_navigation.dart';
import 'package:gomalgy/providers/localization/app_localizations.dart';
import 'package:gomalgy/screens/naviation_bottom/Search_all_products.dart';
import 'package:gomalgy/screens/naviation_bottom/all_products.dart';
import 'package:gomalgy/screens/naviation_bottom/home.dart';
import 'package:gomalgy/screens/naviation_bottom/shop_cart_page.dart';
import 'package:gomalgy/screens/naviation_bottom/user_navigation.dart';
import 'package:gomalgy/widget/text_fields.dart';
import 'package:gomalgy/widget/drawer.dart';

class Navigat extends StatefulWidget {
  @override
  _NavigatState createState() => _NavigatState();
}

class _NavigatState extends State<Navigat> {
  var navPos = 0;

  @override
  Widget build(BuildContext context) {
    void changeToSearchPage() {
      if (navPos == 2) {
        return;
      }
      setState(() {
        navPos = 2;
        print(navPos);
      });
    }

    final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 24.0,
        brightness: Brightness.light,
        backgroundColor: Theme.of(context).primaryColor,
        title: /* Image.asset(
          'assets/gomlgy_logo.png',
          width: 100,
          height: 60,
         // scale: 5,
        ), */
        Text('Gomlagy' , style: TextStyle(color: Colors.white , fontSize: 24),),
        centerTitle: true,
        //leading: null,
        actions: [
          IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                //      Navigator.pushNamed(context, );
              }),
        ],
        bottom: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: TextFields(
              icon: Icons.search,
              hint: AppLocalizations.of(context).translate('what_are_you_looking_for'),
              onTap: changeToSearchPage,
            ),
          ),
          preferredSize: Size.fromHeight(80),
        ),
      ),
      key: drawerKey,
      drawer: CustomDrawer(),
      body: Stack(children: [
        //  CustomAppBar(drawerKey: drawerKey),
        IndexedStack(
          index: navPos,
          children: [
            Home(),
            AllProducts(),
            SearchAllProducts(),
            ShopCartPage(),
            UserNav(),
          ],
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
              alignment: Alignment.bottomCenter,
              child: CurvedBottomNavigation(
                navHeight: 50,
                fabSize: 50,
                bgColor: Theme.of(context).primaryColor,
                fabBgColor: Theme.of(context).primaryColor,
                selected: navPos,
                onItemClick: (i) {
                  setState(() {
                    navPos = i;
                  });
                },
                items: [
                  Icon(Icons.home, color: Colors.white),
                  Icon(Icons.view_module_rounded, color: Colors.white),
                  Icon(Icons.search, color: Colors.white),
                  Icon(Icons.shopping_cart, color: Colors.white),
                  Icon(Icons.account_circle_sharp, color: Colors.white),
                ],
              )),
        )
      ]),
    );
  }
}
