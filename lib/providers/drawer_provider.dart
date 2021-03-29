import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gomalgy/models/drawer_model.dart';
import 'package:http/http.dart' as http;
import '../helpers/http_exception.dart';
import '../helpers/base_url.dart' as baseurl;

class DrawerData with ChangeNotifier {
  Future<List> fetchAndSetCatdData() async {
    var url = baseurl.Urls.api + '/sub-category-products?category_id=5';

    try {
      final response = await http.get(url);
      //  print(response.body);
      final extractedData = json.decode(response.body) as Map<String, Object>;
      print(extractedData);
      print('ef---------------------------');

      if (response.statusCode >= 400) {
        throw HttpException('An error occurred');
      }
      if (extractedData == null) {
        return [];
      }
      // extractedData.forEach((id, data) {
      // final prodactData = jsonDecode(json.encode(data));
      // print('productsData');
      // print(prodactData);
      var data = (extractedData['data'] as List).map((data) {
        final extractedData = data as Map<String, dynamic>;

        return DrawerModel(
          name: extractedData['name'],
          id: extractedData['id'],
          categoryid: extractedData['category_id'],
          image: extractedData['image'],
          links: extractedData['links'],
        );
      }).toList();
      print('ef---------------------------');

      //  _items = productsData;
      // });

      return data;
      // notifyListeners();
    } catch (e) {
      print(e);
      throw HttpException('An error occurred');

      // throw e;
    }
  }
}
