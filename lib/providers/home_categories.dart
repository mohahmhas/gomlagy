import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:gomalgy/helpers/keys.dart';
import '../models/home_categories_model.dart';
import 'package:http/http.dart' as http;
import '../helpers/http_exception.dart';
import '../helpers/base_url.dart' as baseurl;
import 'auth.dart';

final imageSliderProvider = ChangeNotifierProvider<ImagesSlider>((ref) {
  return ImagesSlider();
});

final catDataProvider = ChangeNotifierProvider<CatData>((ref) {
  return CatData();
});

class ImagesSlider with ChangeNotifier {
  Map<String, dynamic> _items = {};

  Map<String, dynamic> get items {
/*     if (_showFavoritesOnly) {
      return _items.where((prodItem) => prodItem.isFavorite).toList();
    } */
    return _items;
  }

  Future<List> fetchAndSetSliderData(
      {String sliderUrl, String arrayKey = ''}) async {
    var url = baseurl.Urls.api + sliderUrl;
//'/offers'
    try {
      final response = await http.get(Uri.parse(url));
      //  print(response.body);
      final extractedData = json.decode(response.body) as Map<String, Object>;

      if (response.statusCode >= 400) {
        print('print 1 ');
        throw HttpException('An error occurred');
      }
      if (extractedData == null) {
        return [];
      }
      // extractedData.forEach((id, data) {
      // final prodactData = jsonDecode(json.encode(data));
      // print('productsData');
      // print(prodactData);
      var productsData = (extractedData['data'] as List<dynamic>)
          .map((sliderData) => ImageSlider(
              id: sliderData['id'].toString(),
              offerimage: sliderData['offer_image'],
              offerimagepath: sliderData['offer_image_path'],
              updatedat: sliderData['updated_at'],
              createdat: sliderData['created_at']))
          .toList();
      // print(productsData[0]);
      productsData.forEach((element) {
        print(element.offerimagepath);
      });
      //  _items = productsData;
      // });
      if (arrayKey != '') {
        _items[arrayKey] = productsData;
        print('_items[arrayKey]');
        print(_items[arrayKey]);
        notifyListeners();
      }

      return productsData;
    } catch (e) {
      print('print 2 ');
      print(e);
      throw HttpException('An error occurred');

      // throw e;
    }
  }
}

class CatData with ChangeNotifier {
  Map<String, dynamic> _items = {};
  Map<String, dynamic> get items {
    return _items;
  }

  Future<List> fetchAndSetCatdData(String catUrl,
      {String arrayKey = ''}) async {
    var url = baseurl.Urls.api + catUrl;

    try {
      final response = await http.get(Uri.parse(url));
      //  print(response.body);
      final extractedData = json.decode(response.body) as Map<String, Object>;
      print(extractedData);
      print('effffffff---------------------------');

      if (response.statusCode >= 400) {
        print('print 3 ');
        throw HttpException('An error occurred');
      }
      if (extractedData == null) {
        return [];
      }
      // extractedData.forEach((id, data) {
      // final prodactData = jsonDecode(json.encode(data));
      // print('productsData');
      // print(prodactData);
      var productsData = (extractedData['data'] as List).map((data) {
        final extractedData = data as Map<String, dynamic>;

        return FeaturedProducts(
            name: extractedData['name'],
            basePrice: double.parse(extractedData['base_price'].toString()),
            unitPrice: double.parse(extractedData['unit_price'].toString()),
            unitPrice2: double.parse(extractedData['unit_price2'].toString()),
            unitPrice3: double.parse(extractedData['unit_price3'].toString()),
            rating: double.parse(extractedData['rating'].toString()),
            thumbnailImage: extractedData['thumbnail_image']);
      }).toList();
      print('print---------------------------');
      // });
      //
      if (arrayKey != '') {
        _items[arrayKey] = productsData;
        print('_items[arrayKey]');
        print(_items[arrayKey]);
        notifyListeners();
      }
      return productsData;
    } catch (e) {
      print(e);
      print('print 4 ');
      throw HttpException('An error occurred');

      // throw e;
    }
  }

  Future<List> fetchAndSetWishlistData(String urlString) async {
    var url = baseurl.Urls.api +
        urlString +
        '/' +
        Keys.navKey.currentContext.read(authDataProvider).userId;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: Map<String, String>.from({
          'Content-Type': 'application/json ;charset=UTF-8',
          'Charset': 'utf-8',
          'Authorization': 'Bearer ' +
              Keys.navKey.currentContext.read(authDataProvider).token,
        }),
      );
      //  print(response.body);
      final extractedData = json.decode(response.body) as Map<String, Object>;
      print('extractedData = $extractedData');
      print('ef---------------------------');

      if (response.statusCode >= 400) {
        print('print 5 ');
        throw HttpException('An error occurred');
      }
      if (extractedData == null) {
        return [];
      }
      var productsData = (extractedData['data'] as List).map((data) {
        print('data = $data');
        final extractedData = data['product'] as Map<String, dynamic>;

        return FeaturedProducts(
            name: extractedData['name'],
            basePrice: double.parse(extractedData['base_price'].toString()),
            unitPrice: double.parse(extractedData['unit_price'].toString()),
            unitPrice2: double.parse(extractedData['unit_price2'].toString()),
            unitPrice3: double.parse(extractedData['unit_price3'].toString()),
            rating: double.parse(extractedData['rating'].toString()),
            links: extractedData['links'],
            thumbnailImage: extractedData['thumbnail_image']);
      }).toList();
      print('ef---------------------------');

      //  _items = productsData;
      // });
      return productsData;
      // notifyListeners();
    } catch (e) {
      print('print 6 ');
      print(e);
      throw HttpException('An error occurred');

      // throw e;
    }
  }
}
