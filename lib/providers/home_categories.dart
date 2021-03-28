import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/home_categories_model.dart';
import 'package:http/http.dart' as http;
import '../helpers/http_exception.dart';
import '../helpers/base_url.dart' as baseurl;

class ImagesSlider with ChangeNotifier {
  List<ImageSlider> _items = [];

  List<ImageSlider> get items {
/*     if (_showFavoritesOnly) {
      return _items.where((prodItem) => prodItem.isFavorite).toList();
    } */
    return [..._items];
  }

  Future<List> fetchAndSetSliderData() async {
    var url = baseurl.Urls.api + '/offers';

    try {
      final response = await http.get(url);
      //  print(response.body);
      final extractedData = json.decode(response.body) as Map<String, Object>;

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
      return productsData;
      // notifyListeners();
    } catch (e) {
      print(e);
      throw HttpException('An error occurred');

      // throw e;
    }
  }
}

class CatData with ChangeNotifier {
  Future<List> fetchAndSetCatdData(String catUrl) async {
    var url = baseurl.Urls.api + catUrl;

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
      print('ef---------------------------');

      //  _items = productsData;
      // });
      return productsData;
      // notifyListeners();
    } catch (e) {
      print(e);
      throw HttpException('An error occurred');

      // throw e;
    }
  }
}
