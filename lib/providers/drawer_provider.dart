import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomlgy/models/drawer_model.dart';
import 'package:http/http.dart' as http;
import '../helpers/http_exception.dart';
import '../helpers/base_url.dart' as baseurl;

final drawerProvider = ChangeNotifierProvider<DrawerData>((ref) {
  return DrawerData();
});

class DrawerData with ChangeNotifier {
  List<DrawerModel> _drawerData = [];
  get drawerData {
    return [..._drawerData];
  }

  Future<bool> fetchAndSetDrawerdData() async {
    var url = baseurl.Urls.api + '/sub-category-products?category_id=5';

    try {
      final response = await http.get(Uri.parse(url));
      //  print(response.body);
      final extractedData = json.decode(response.body) as Map<String, Object>;
      print(extractedData);
      print('ef---------------------------');

      if (response.statusCode >= 400) {
        throw HttpException('An error occurred');
      }
      if (extractedData == null) {
        return false;
      }
      // extractedData.forEach((id, data) {
      // final prodactData = jsonDecode(json.encode(data));
      // print('productsData');
      // print(prodactData);
      var data = (extractedData['data'] as List).map((data) {
        final extractedData = data as Map<String, dynamic>;
        print('drawer item id = ${extractedData['id']}');
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

      _drawerData = data;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      // throw HttpException('An error occurred');
      return false;

      // throw e;
    }
  }
}
