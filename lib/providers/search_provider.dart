import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomlgy/helpers/http_exception.dart';
import 'package:gomlgy/widget/product_card/product_cart_%20vertical.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/base_url.dart' as baseurl;

final provider = ChangeNotifierProvider<SearchProvider>((ref) {
  return SearchProvider();
});

class SearchProvider with ChangeNotifier {
  List<ProductCardvertical> _items = [];
  int _currentPage = 1;
  int _lastPage;
  get items {
    return _items;
  }

  get currentPage {
    return _currentPage;
  }

  get lastPage {
    return _lastPage;
  }

  Future<void> fetchAndSetdData(String filter,
      {bool fromListener = false, bool fromSearch = false}) async {
    // if (_currentPage == _lastPage && filter != '') {
    //   return;
    // }
    if (fromListener) {
      _currentPage = _currentPage + 1;
    }

    var url = baseurl.Urls.api +
        '/products/search?key=' +
        filter +
        '&scope=product&page=' +
        _currentPage.toString();
    print(url);
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
        return [];
      }
      // extractedData.forEach((id, data) {
      // final prodactData = jsonDecode(json.encode(data));
      // print('productsData');
      // print(prodactData);
      var metaData = (extractedData['meta'] as Map<String, dynamic>);
      _lastPage = metaData['last_page'];
      var productsData = (extractedData['data'] as List).map((data) {
        final extractedData = data as Map<String, dynamic>;
        print('---------search ' + extractedData.toString());

        var linksData = extractedData['links']['details'];
        String id = linksData.substring(
            linksData.lastIndexOf("/") + 1, linksData.length);

        return ProductCardvertical(
            id: id,
            name: extractedData['name'],
            unitPrice: double.parse(extractedData['unit_price'].toString()),
            unitPrice2: double.parse(extractedData['unit_price2'].toString()),
            unitPrice3: double.parse(extractedData['unit_price3'].toString()),
            rating: double.parse(extractedData['rating'].toString()),
            thumbnailImage: extractedData['thumbnail_image']);
      }).toList();
      print('ef---------------------------');

      //  _items = productsData;
      // });
      // return productsData;
      print('filter: ' + filter);
      if (fromSearch) {
        _items = productsData;
        print('filter !=');
      } else {
        _items.addAll(productsData);
        print('filter ==');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw HttpException('An error occurred');

      // throw e;
    }
  }
}
