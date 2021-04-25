import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gomalgy/helpers/base_url.dart';
import 'package:gomalgy/models/product_categories_model.dart';
import 'package:gomalgy/models/see_all_model.dart';
import 'package:gomalgy/models/subProduct_categories_model.dart';

import 'package:http/http.dart';

final categoriesApiProvider = ChangeNotifierProvider<CategoriesApi>((ref) {
  return CategoriesApi();
});

class CategoriesApi extends ChangeNotifier {
  static List<dynamic> list = [];
  static int lengthOfList;

  Map<String, dynamic> _categoriesNamesItems = {};
  Map<String, dynamic> get categoriesNamesItems {
    return _categoriesNamesItems;
  }

  Future<bool> getAndSetAllProductData() async {
    var categoriesNames = await getCategoriesNames(endPoint: '/categories');
    // var subCategoriesData = await getSubCategoriesData(endPoint, index);
    _categoriesNamesItems['categories'] = categoriesNames;

    categoriesNames.forEach((element) {});
  }

  Future<List<CategoriesData>> getCategoriesNames({String endPoint}) async {
    final Response response = await get(Uri.parse(Urls.api + endPoint),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        });
    try {
      if (response.statusCode == 200) {
        // parsing json into List of objects
        final parsed = json.decode(response.body).cast<String, dynamic>();
        notifyListeners();
        return parsed['data']
            .map<CategoriesData>((item) => CategoriesData.fromJson(item))
            .toList();
      }
    } catch (e) {
      print(e);
      return [];
    }
  } // end getCategoriesNames()

  Future<List<Products>> getSubCategoriesData(
      {String endPoint, int index}) async {
    final Response response = await get(Uri.parse(Urls.api + endPoint),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        });
    // print('Response $response');
    try {
      if (response.statusCode == 200) {
        // parsing json into List of objects
        final parsed = json.decode(response.body).cast<String, dynamic>();
        // notifyListeners() ;
        List<Products> productData = [];
        (parsed['data'] as List).forEach((element) {
          productData.addAll(element['products']
              .map<Products>((item) => Products.fromJson(item)));
        });
        return productData;
      }
    } catch (e) {
      print('error = ' + e.toString());
      return [];
    }
  } // end getCategoriesNames()

  static Future<List<SeeAllDataModel>> SeeAllProducts(String url) async {
    final Response response = await get(Uri.parse(url), headers: {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    });
    // print('Response $response');
    try {
      if (response.statusCode == 200) {
        // parsing json into List of objects
        final parsed = json.decode(response.body).cast<String, dynamic>();
        print('parsed of data' + parsed['data'].toString());
        return parsed['data'].map<SeeAllDataModel>((item) {
          var dataItems = item;
          var linksData = item['links']['details'];
          String id = linksData.substring(
              linksData.lastIndexOf("/") + 1, linksData.length);

          dataItems['id'] = id;
          print('------------w' + dataItems['id']);
          return SeeAllDataModel.fromJson(dataItems);
        }).toList();
      } // end if
    } catch (e) {
      print(e);
      return [];
    }
  }
} // end class
