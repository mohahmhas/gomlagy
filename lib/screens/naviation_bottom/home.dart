import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomalgy/providers/home_categories.dart';
import 'package:gomalgy/providers/localization/app_localizations.dart';
import 'package:gomalgy/widget/home_category_widgets/home_horizental_cats.dart';
import 'package:gomalgy/widget/home_category_widgets/home_horizental_cats_grid.dart';
import 'package:gomalgy/widget/home_category_widgets/home_vertical_cat.dart';
import 'package:gomalgy/widget/home_category_widgets/image_slider_first_item.dart';
import 'package:gomalgy/providers/home_categories.dart' as homeCat;

import 'package:flutter/rendering.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height / 1.3,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    flex: 1,
                    child: SliderWidget(
                      sliderDataProvider: imageSliderProvider,
                      url: '/offers',
                      arrayKey: 'offers',
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: Container(
                      height: MediaQuery.of(context).size.height * .28,
                      // color: Colors.grey[600],
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('featured_products'),
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          HomeHorizentalCat(
                            catDataProvider,
                            '/products/featured',
                            arrayKey: 'featured',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('best_selling'),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.orange[900],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          HomeVerticalCats(
                            catData: catDataProvider,
                            countOfItems: 4,
                            url: '/products/best-seller',
                            arrayKey: 'best-seller',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: Container(
                      //     height: 300,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('todays_deal'),
                             // textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.orange[900],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          HomeHorizentalGridCat(
                            catDataProvider,
                            '/products/todays-deal',
                            3,
                            arrayKey: 'todays-deal',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: Container(
                      // height: 300,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('glass_protector'),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.orange[900],
                                  fontWeight: FontWeight.bold),
                             // textAlign: TextAlign.left,
                            ),
                          ),
                          HomeHorizentalGridCat(
                            catDataProvider,
                            '/get-product?category_id=5&sub_category_id=23',
                            3,
                            arrayKey: 'glass_protector',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      // height: 300,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context).translate('cover'),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.orange[900],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          HomeHorizentalGridCat(
                            catDataProvider,
                            '/get-product?category_id=5&sub_category_id=21',
                            3,
                            arrayKey: 'cover',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: Container(
                      //    height: 300,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('headphone'),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.orange[900],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          HomeHorizentalGridCat(
                            catDataProvider,
                            '/get-product?category_id=5&sub_category_id=22',
                            3,
                            arrayKey: 'headphone',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
