import 'package:flutter/material.dart';
import 'package:gomalgy/models/ProductDetails.dart';
import 'package:gomalgy/models/home_categories_model.dart';
import '../helpers/base_url.dart' as baseurl;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/http_exception.dart';

class Products with ChangeNotifier {
  Future<ProductDetails> fetchAndSetProductData({String product_id}) async {
    var url = baseurl.Urls.api + '/products/' + product_id;
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 400) {
        throw HttpException('An error occurred');
      }
      if (extractedData == null) {
        return null;
      }

      dynamic Productlist = extractedData["data"];

      return ProductDetails(
        id: Productlist[0]['id'],
        name: Productlist[0]['name'],
        addedBy: Productlist[0]['added_by'],
        photos: Productlist[0]['photos'] as List<dynamic>,
        choiceOptions: Productlist[0]['choice_options'],
        //choiceOptionsName:Productlist[0]['choice_options'][0]['options'] as List<dynamic>,
        //  choiceOptionsnumber: Productlist[0]['choice_options'][0]['name'],
        colors: Productlist[0]['colors'] as List<dynamic>,
        variantColors: Productlist[0]['variant_colors'] as List<dynamic>,
        currentStock: Productlist[0]['current_stock'],
        rating: Productlist[0]['rating'],
        unitPrice: Productlist[0]['unit_price'],
        minQuantity1: Productlist[0]['min_quantity1'],
        maxQuantity1: Productlist[0]['max_quantity1'],
        unitPrice2: Productlist[0]['unit_price2'],
        minQuantity2: Productlist[0]['min_quantity2'],
        maxQuantity2: Productlist[0]['max_quantity2'],
        unitPrice3: Productlist[0]['unit_price3'],
        minQuantity3: Productlist[0]['min_quantity3'],
        maxQuantity3: Productlist[0]['max_quantity3'],
        links: Productlist[0]['links'],
      );
      // notifyListeners();
    } catch (e) {
      print(e);
      throw HttpException('An error occurred');
      // throw e;
    }
  }

  Future<String> fetchTopFromSellingLink({String related}) async {
    var url = related;
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 400) {
        throw HttpException('An error occurred');
      }
      if (extractedData == null) {
        return null;
      }

      String topFromTheSellerLink =
          extractedData["data"][0]['links']['top_from_seller'];
      return topFromTheSellerLink;
      // notifyListeners();
    } catch (e) {
      print(e);
      throw HttpException('An error occurred');
      // throw e;
    }
  }

  Future<List> fetchAndSetCatdData(String catUrl) async {
    var url = catUrl;

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
