import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomlgy/providers/auth.dart';
import 'package:gomlgy/providers/localization/app_language.dart';
import 'package:gomlgy/providers/localization/app_localizations.dart';
import 'package:gomlgy/screens/account_information/account_information_page.dart';
import 'package:gomlgy/screens/my_wishlist_screen.dart';
import 'package:gomlgy/screens/naviation_bottom/warrantly.dart';
import 'package:gomlgy/screens/outhantication/log_screen.dart';
import 'package:gomlgy/screens/user/history.dart';
import 'package:gomlgy/screens/wallet/Wallet_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wave_transition/wave_transition.dart';

class UserNav extends StatefulWidget {
  @override
  _UserNavState createState() => _UserNavState();
}

class _UserNavState extends State<UserNav> {
  String langType;
  final _url = 'https://gomlgy.com/shops/create';
  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(6),
        height: MediaQuery.of(context).size.height - 180,
        child: ListView(
          children: [
            viewListTile(
                name: AppLocalizations.of(context).translate('my_wishlist'),
                icon: Icons.thumb_up_alt_outlined,
                onpressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => MyWishListScreen()));
                  /* Navigator.pushNamed(
                      context,
                      context.read(authDataProvider).isAuth
                          ? MyWishListScreen.id
                          : LoginScreen.id);

*/
                  Navigator.push(
                      context,
                      WaveTransition(
                        child: context.read(authDataProvider).isAuth
                            ? MyWishListScreen()
                            : LoginScreen(),
                        center: FractionalOffset(0.90, 0.90),
                        duration: Duration(milliseconds: 3000), // optional
                      ));
                }),
            SizedBox(
              height: 10,
            ),
            viewListTile(
              name: AppLocalizations.of(context).translate('purchase_history'),
              icon: Icons.receipt_long_rounded,
              onpressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => HistoryPage()));
                //
                /*     Navigator.pushNamed(
                    context,
                    context.read(authDataProvider).isAuth
                        ? HistoryPage.id
                        : LoginScreen.id);
*/

                Navigator.push(
                    context,
                    WaveTransition(
                      child: context.read(authDataProvider).isAuth
                          ? HistoryPage()
                          : LoginScreen(),
                      center: FractionalOffset(0.90, 0.90),
                      duration: Duration(milliseconds: 3000), // optional
                    ));
              },
            ),
            SizedBox(
              height: 10,
            ),
            viewListTile(
                name: AppLocalizations.of(context).translate('my_wallet'),
                icon: Icons.wallet_travel,
                onpressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => WalletPage()));
                  /*      Navigator.pushNamed(
                      context,
                      context.read(authDataProvider).isAuth
                          ? WalletPage.id
                          : LoginScreen.id);
                  */

                  Navigator.push(
                      context,
                      WaveTransition(
                        child: context.read(authDataProvider).isAuth
                            ? WalletPage()
                            : LoginScreen(),
                        center: FractionalOffset(0.90, 0.90),
                        duration: Duration(milliseconds: 3000), // optional
                      ));
                }),
            SizedBox(
              height: 10,
            ),
            viewListTile(
              name:
                  AppLocalizations.of(context).translate('account_information'),
              icon: Icons.info_outline,
              onpressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => AccountInformationPage()));
                /*              Navigator.pushNamed(
                    context,
                    context.read(authDataProvider).isAuth
                        ? AccountInformationPage.id
                        : LoginScreen.id);
*/

                Navigator.push(
                    context,
                    WaveTransition(
                      child: context.read(authDataProvider).isAuth
                          ? AccountInformationPage()
                          : LoginScreen(),
                      center: FractionalOffset(0.90, 0.90),
                      duration: Duration(milliseconds: 3000), // optional
                    ));
              },
            ),
            SizedBox(
              height: 10,
            ),
            viewListTile(
                name: AppLocalizations.of(context).translate('warranty'),
                icon: Icons.person,
                onpressed: () {
                  /*    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                         context.read(authDataProvider).isAuth
                              ? WarrantlyRequests(AppLocalizations.of(context)
                                  .translate('warranty'))
                              : LoginScreen()));
*/

                  Navigator.push(
                      context,
                      WaveTransition(
                        child: context.read(authDataProvider).isAuth
                            ? WarrantlyRequests(AppLocalizations.of(context)
                                .translate('warranty'))
                            : LoginScreen(),
                        center: FractionalOffset(0.90, 0.90),
                        duration: Duration(milliseconds: 3000), // optional
                      ));
                }),
            SizedBox(
              height: 10,
            ),
            viewListTile(
                name: AppLocalizations.of(context).translate('language'),
                icon: Icons.language_outlined,
                onpressed: () {
                  showAlertDialog(context);
                }),
            SizedBox(
              height: 10,
            ),
            viewListTile(
                name:
                    AppLocalizations.of(context).translate('join_as_a_trader'),
                icon: Icons.attach_money_outlined,
                onpressed: () {
                  _launchURL();
                }),
            SizedBox(
              height: 10,
            ),
            Consumer(builder: (ctx, watch, child) {
              var auth = watch(authDataProvider);
              print('Auth   ' + auth.isAuth.toString());
              return auth.isAuth
                  ? viewListTile(
                      name: AppLocalizations.of(context).translate('logout'),
                      icon: Icons.logout,
                      onpressed: () {
                        context.read(authDataProvider).logout();
                      })
                  : Container();
            })
          ],
        ));
  }

  Widget viewListTile({String name, IconData icon, Function onpressed}) {
    return GestureDetector(
      onTap: onpressed,
      child: ListTile(
        title: Text(name),
        leading: Icon(icon),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  } // end viewListTile()

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        AppLocalizations.of(context).translate('choose_Language'),
        textAlign: TextAlign.center,
      ),
      actions: [
        Column(
          children: [
            TextButton(
              child: Text(
                "عربي",
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                context
                    .read(appLanguageDataProvider)
                    .changeLanguage(Locale("ar"));
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "English",
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                context
                    .read(appLanguageDataProvider)
                    .changeLanguage(Locale("en"));
                Navigator.of(context).pop();
              },
            ),
          ],
        )
      ],
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  } //  end showAlertDialog()
/*     showAlertDialog(BuildContext context) {
  // set up the AlertDialog
 // var model = AppLanguage().appLocal ;
  AlertDialog alert = AlertDialog(  
    
    title: Text("Change Language"),
    actions: [
      Column(
        children: [
             RadioListTile(
        /* value: model,   
        groupValue: appLocal, */
        value: 'عربي',   
        groupValue: langType,    
    title : Text("عربي" , style: TextStyle(fontSize: 24),),
    onChanged: (newValue) {
      //model = newValue ;
      context.read(appLanguageDataProvider).changeLanguage(Locale("ar"));
      Navigator.of(context).pop();
     },
  ) ,
   RadioListTile(
        /* value: model,   
        groupValue: appLocal, */
        value: 'English',   
        groupValue: langType,    
    title : Text("English" , style: TextStyle(fontSize: 24),),
    onChanged: (newValue) {
      //model = newValue ;
      context.read(appLanguageDataProvider).changeLanguage(Locale("en"));
      Navigator.of(context).pop();
     },
  ) ,
        ],
      ) 
    ],
    elevation: 1,
    shape: RoundedRectangleBorder
    (borderRadius: BorderRadius.circular(20.0)
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
} //  end showAlertDialog() */
} // end class
