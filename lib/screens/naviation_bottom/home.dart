import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomalgy/widget/home_category_widgets/home_horizental_cats.dart';
import 'package:gomalgy/widget/home_category_widgets/home_horizental_cats_grid.dart';
import 'package:gomalgy/widget/home_category_widgets/home_vertical_cat.dart';
import 'package:gomalgy/widget/home_category_widgets/image_slider_first_item.dart';
import 'package:gomalgy/providers/home_categories.dart' as homeCat;

final catDataProvider = ChangeNotifierProvider<homeCat.CatData>((ref) {
  return homeCat.CatData();
});

final imageSlider = ChangeNotifierProvider<homeCat.ImagesSlider>((ref) {
  return homeCat.ImagesSlider();
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
          height: MediaQuery.of(context).size.height - 200,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SliderWidget(
                    sliderDataProvider: imageSlider,
                    url: '/offers',
                  ),
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
                  Container(
                    height: 300,
                    child: Column(
                      //    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Today\'s Deal',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.orange[900],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        HomeHorizentalGridCat(
                            catDataProvider, '/products/todays-deal'),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    child: Column(
                      //    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Glass Protector',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.orange[900],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        HomeHorizentalGridCat(catDataProvider,
                            '/get-product?category_id=5&sub_category_id=23'),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    child: Column(
                      //    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Cover',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.orange[900],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        HomeHorizentalGridCat(catDataProvider,
                            '/get-product?category_id=5&sub_category_id=21'),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    child: Column(
                      //    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Headphone',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.orange[900],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        HomeHorizentalGridCat(catDataProvider,
                            '/get-product?category_id=5&sub_category_id=22'),
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
//HomeHorizentalGridCat
///get-product?category_id=5&sub_category_id=23
///get-product?category_id=5&sub_category_id=21
///get-product?category_id=5&sub_category_id=22
