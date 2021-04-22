import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomalgy/mainPage.dart';
import 'package:gomalgy/providers/drawer_provider.dart';
import 'package:gomalgy/providers/localization/app_localizations.dart';
import 'package:gomalgy/screens/account_information/account_information_page.dart';
import 'package:gomalgy/screens/my_wishlist_screen.dart';

import 'package:gomalgy/screens/outhantication/log_screen.dart';
import 'package:gomalgy/screens/outhantication/regist.dart';
import 'package:gomalgy/screens/outhantication/send_code.dart';
import 'package:gomalgy/screens/payment/card_Payment.dart';
import 'package:gomalgy/screens/payment/checkout.dart';
import 'package:gomalgy/screens/user/history.dart';
import 'package:gomalgy/screens/user/orderdetailshistory.dart';
import 'package:gomalgy/screens/wallet/Wallet_page.dart';
import 'package:splashscreen/splashscreen.dart';
import './providers/auth.dart';
import './providers/localization/app_language.dart';
import 'helpers/keys.dart';
import 'providers/home_categories.dart' as homeDataProvider;
import 'package:gomalgy/screens/details_prodect/details_page.dart';
import 'package:gomalgy/providers/api/product_api.dart';

//wellcom
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(MyApp(
    appLanguage: appLanguage,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final AppLanguage appLanguage;

  MyApp({this.appLanguage});
  bool firstLoad = true;
  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: Consumer(
      builder: (ctx, watch, child) {
        /////////////////////////////////////////////////////////
        final model = watch(appLanguageDataProvider);
        firstLoad = false;

        return MaterialApp(
          navigatorKey: Keys.navKey,
          locale: firstLoad ? appLanguage.appLocal : model.appLocal,
          supportedLocales: [
            Locale('en', 'US'),
            Locale('ar', ''),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.orange[900],
          ),
          routes: {
            LoginScreen.id: (context) => LoginScreen(),
            RegisterScreen.id: (context) => RegisterScreen(),
            SendCode.id: (context) => SendCode(),
            CheckOut.id: (context) => CheckOut(),
            CardPayment.id: (context) => CardPayment(),
            MainPgae.id: (context) => MainPgae(),
            MyWishListScreen.id: (context) => MyWishListScreen(),
            WalletPage.id: (context) => WalletPage(),
            AccountInformationPage.id: (context) => AccountInformationPage(),
            HistoryPage.id: (context) => HistoryPage(),
            OrdarDetails.id: (context) => OrdarDetails(),
            initDetailsPage.id: (context) => initDetailsPage(),
          },
          home: SplashWidget(),
        );
      },
    ));
  }
}

class SplashWidget extends StatelessWidget {
  const SplashWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Widget> loadFromFuture() async {
      await context.read(authDataProvider).tryAutoSignin();
      //  print(result);
      await context.read(drawerProvider).fetchAndSetDrawerdData();
      await context
          .read(homeDataProvider.imageSliderProvider)
          .fetchAndSetSliderData(
            sliderUrl: '/offers',
            arrayKey: 'offers',
          );
      await context
          .read(homeDataProvider.catDataProvider)
          .fetchAndSetCatdData('/products/featured', arrayKey: 'featured');
      await context.read(homeDataProvider.catDataProvider).fetchAndSetCatdData(
          '/products/best-seller',
          arrayKey: 'best-seller');
      await context.read(homeDataProvider.catDataProvider).fetchAndSetCatdData(
          '/products/todays-deal',
          arrayKey: 'todays-deal');
      await context.read(homeDataProvider.catDataProvider).fetchAndSetCatdData(
          '/get-product?category_id=5&sub_category_id=23',
          arrayKey: 'glass_protector');
      await context.read(homeDataProvider.catDataProvider).fetchAndSetCatdData(
          '/get-product?category_id=5&sub_category_id=21',
          arrayKey: 'cover');
      await context.read(homeDataProvider.catDataProvider).fetchAndSetCatdData(
          '/get-product?category_id=5&sub_category_id=22',
          arrayKey: 'headphone');
      await context.read(categoriesApiProvider).getAndSetAllProductData();
      print('result');

      // <fetch data from server. ex. login>

      return Future.value(new MainPgae());
    }

    return SplashScreen(
      navigateAfterFuture: loadFromFuture(),
      //routeName: MainPgae.id,
      photoSize: 100,
      image: Image.asset("assets/logo_o_foreground.png"),
      // text: "Normal Text",
      //  textType: TextType.NormalText,

      backgroundColor: Color(0xffeb6824),
    );
  }
}
