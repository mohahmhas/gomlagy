import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomlgy/providers/home_categories.dart' as homeCat;
import 'package:gomlgy/providers/localization/app_localizations.dart';
import 'package:gomlgy/widget/home_category_widgets/home_vertical_cat.dart';
import 'package:gomlgy/widget/wishList_vertical_cat.dart';

final catDataProvider = ChangeNotifierProvider<homeCat.CatData>((ref) {
  return homeCat.CatData();
});

class MyWishListScreen extends StatelessWidget {
  static String id = '/wishlist';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('my_wishlist')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: WishListVerticalCats(
            catData: catDataProvider, countOfItems: 4, url: '/wishlists/'),
      ),
    );
  }
}
