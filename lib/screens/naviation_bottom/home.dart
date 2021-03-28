import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomalgy/widget/home_category_widgets/home_horizental_cats.dart';
import 'package:gomalgy/widget/home_category_widgets/home_vertical_cat.dart';
import 'package:gomalgy/widget/home_category_widgets/image_slider_first_item.dart';
import 'package:gomalgy/providers/home_categories.dart' as homeCat;

final catDataProvider = ChangeNotifierProvider<homeCat.CatData>((ref) {
  return homeCat.CatData();
});

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 130,
      ),
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height - 180,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SliderWidget(),
                  Container(
                    height: 270,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Featured Products',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                        HomeHorizentalCat(
                            catDataProvider, '/products/featured'),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Best Selling',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.orange[900],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        HomeVerticalCats(
                            catData: catDataProvider,
                            url: '/products/best-seller'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
