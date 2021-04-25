import 'package:flutter/material.dart';
import 'package:gomalgy/helpers/base_url.dart';
import 'package:gomalgy/models/product_categories_model.dart';
import 'package:gomalgy/models/subProduct_categories_model.dart';
import 'package:gomalgy/providers/api/product_api.dart';
import 'package:gomalgy/providers/localization/app_localizations.dart';
import 'package:gomalgy/screens/details_prodect/details_page.dart';
import 'package:gomalgy/screens/seeAll_products.dart';
import 'package:gomalgy/widget/product_card/allProductItem.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllProducts extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  int category_id = 5;
  String appBarName = 'اكسسوارات موبايل';

  @override
  Widget build(BuildContext context) {
    var categoriesNames =
        context.read(categoriesApiProvider).categoriesNamesItems['categories'];
    var subCategoriesData = context.read(categoriesApiProvider);
    return Container(
      color: Colors.grey[300],
      // height: 200,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          /////////////////////////// edit here
          Container(
            margin: EdgeInsets.only(right: 5, left: 5),
            width: MediaQuery.of(context).size.width / 4,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: categoriesNames.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: TextButton(
                        child: Center(
                            child: Text(
                          categoriesNames[index].name,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        )),
                        onPressed: () {
                          if (categoriesNames[index].id == 9) {
                            setState(() {
                              category_id = 9;
                              appBarName = categoriesNames[index].name;
                              print('category_id ${categoriesNames[index].id}');
                            });
                          } else if (categoriesNames[index].id == 6) {
                            setState(() {
                              category_id = 6;
                              appBarName = categoriesNames[index].name;
                              print(
                                  'category_id = ${categoriesNames[index].id}');
                            });
                          } else if (categoriesNames[index].id == 8) {
                            setState(() {
                              category_id = 8;
                              appBarName = categoriesNames[index].name;
                              print('category_id ${categoriesNames[index].id}');
                            });
                          } else {
                            setState(() {
                              category_id = 5;
                              appBarName = categoriesNames[index].name;
                              print(
                                  'category_id = ${categoriesNames[index].id}');
                            });
                          }

                          //       print('AppBarName = $appBarName');
                        },
                      ),
                    );
                  }),
            ),
          ),
          // right outer container
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 15),
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate('all_products'),
                            style: TextStyle(fontSize: 18),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              // navigate to all products in categories
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SeeAllProducts(
                                      appBarName: appBarName,
                                      url: Urls.api +
                                          '/products/category/$category_id'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    // container for repeating each item
                    child: Container(
                      child: FutureBuilder<List<CategoriesData>>(
                        future: context
                            .read(categoriesApiProvider)
                            .getCategoriesNames(
                                endPoint:
                                    '/sub-category-products?category_id=$category_id'),
                        builder: (context, snapShot) {
                          if (snapShot.hasData) {
                            return ListView.builder(
                                itemCount: snapShot.data.length,
                                itemBuilder: (context, int index) {
                                  print('name = ${snapShot.data[index].name}');
                                  return Container(
                                    color: Colors.white,
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 4),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapShot.data[index].name,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SeeAllProducts(
                                                        appBarName: snapShot
                                                            .data[index].name,
                                                        url: snapShot
                                                            .data[index]
                                                            .links
                                                            .products,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  /* 'See All', */
                                                  AppLocalizations.of(context)
                                                      .translate('see_all'),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.red[300]),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 3.0,
                                          thickness: 2.0,
                                          color: Colors.grey[300],
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          //color: Colors.blue,
                                          child: FutureBuilder<List<Products>>(
                                            future: subCategoriesData
                                                .getSubCategoriesData(
                                                    endPoint:
                                                        '/sub-category-products?category_id=$category_id',
                                                    index: index),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                print(
                                                    'data is ${snapshot.data}');
                                                List<Widget> list = [];
                                                list = List.from(
                                                  snapshot.data
                                                      .take(6)
                                                      .map((e) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        print('id ${e.id}');
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        initDetailsPage(),
                                                                settings: RouteSettings(
                                                                    arguments: e
                                                                        .id
                                                                        .toString())));
                                                      },
                                                      child:
                                                          AllProductItemContainer(
                                                        name: e.name,
                                                        thumbnailPath:
                                                            e.thumbnailPath[0],
                                                      ),
                                                    );
                                                  }),
                                                );

                                                return Wrap(
                                                  direction: Axis.horizontal,
                                                  spacing: 8.0,
                                                  children: list,
                                                );
                                              } // end if
                                              else {
                                                print('No data ');
                                                return Center(
                                                  child: Container(),
                                                  //CircularProgressIndicator(),
                                                );
                                              } // end else
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }, // end builder
                      ),
                      margin: EdgeInsets.only(bottom: 35),
                    ),
                  ),

                  // SizedBox(height:MediaQuery.of(context).size.height/17,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  } // end build
} // end class
