import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomlgy/helpers/keys.dart';
import 'package:gomlgy/models/cart_items.dart';
import '../helpers/base_url.dart' as baseurl;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/http_exception.dart';
import 'auth.dart';

final CartItemDataProvider = ChangeNotifierProvider<ShopCartProvider>((ref) {
  return ShopCartProvider();
});

class ShopCartProvider extends ChangeNotifier {
  List<CartItem> _ListProductCartItem = [];
  double _TotalPrice = 0;
  double _TotalPriceShipping = 0;
  List<CartItem> get GetListProductCartItem => _ListProductCartItem;

  double get TotalPrice => _TotalPrice;
  double get TotalPriceShipping => _TotalPriceShipping;

  int CalcTotal() {
    int totalprice = 0;
    //print("length  ${_ListProductCartItem.length}");
    _TotalPriceShipping = 0;
    for (int index = 0; index < _ListProductCartItem.length; index++) {
      // print("in For Loop ");
      totalprice += ((_ListProductCartItem[index].price) +
              (_ListProductCartItem[index].shippingCost)) *
          _ListProductCartItem[index].quantity;

      _TotalPriceShipping += _ListProductCartItem[index].shippingCost;
    }
    //print("Total is ${ShopCartPage.totalprice}");
    return totalprice;
  }

  Future<void> getShopCartItems() async {
    if (!Keys.navKey.currentContext.read(authDataProvider).isAuth) {
      return;
    }
    final url = baseurl.Urls.api +
        '/carts/' +
        Keys.navKey.currentContext.read(authDataProvider).userId;
    //print(url);

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: Map<String, String>.from({
          'Authorization': 'Bearer ' +
              Keys.navKey.currentContext.read(authDataProvider).token,
        }),
      );
      // print("URL   : " + url.toString());
      // print("Response1  " + response.body.toString());

      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (response.statusCode >= 400) {
        throw HttpException('An Error occurred!');
      }

      var data = (responseData['data'] as List).map((data) {
        final extractedData = data as Map<String, dynamic>;

        return CartItem(
          id: extractedData['id'],
          productname: extractedData['product']['name'],
          productimage: extractedData['product']['image'],
          price: extractedData['price'],
          date: extractedData['date'],
          quantity: extractedData['quantity'],
          shippingCost: extractedData['shipping_cost'],
          shippingSlide: extractedData['shipping_slide'],
          tax: extractedData['tax'],
          variation: extractedData['variation'],
        );
      }).toList();

      _ListProductCartItem = data;
      //   print(_ListProductCartItem);
      _TotalPrice = CalcTotal().toDouble();
      notifyListeners();
    } catch (e) {
      print("Error  " + e);
      throw e;
    }
  }

  Future<void> EditNumOfquantity({
    int New_quantity,
    int Cart_id,
  }) async {
    final url = baseurl.Urls.api + '/carts/change-quantity';
    //print("Name is:  ${name}");
    print(url);
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: Map<String, String>.from({
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' +
              Keys.navKey.currentContext.read(authDataProvider).token,
        }),
        body: json.encode(
          {
            'id': Cart_id,
            'quantity': New_quantity,
          },
        ),
      );
//      print("ResADDresssss : ${response.body} ");
      final responseData = json.decode(response.body);
      //    print("ResponseDataUpdate   $responseData ");
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (response.statusCode >= 400) {
        throw HttpException('An Error occurred!');
      }

      _ListProductCartItem.forEach((element_main) {
        _ListProductCartItem[_ListProductCartItem.indexWhere(
                (element) => element.id == Cart_id)]
            .quantity = New_quantity;
      });

      _TotalPrice = CalcTotal().toDouble();
      notifyListeners();
    } catch (e) {
      print("E  " + e);
      throw e;
    }
  }

  Future DeleteCartItem({int Cartid}) async {
    final url = baseurl.Urls.api + '/carts/' + Cartid.toString();
    //print(url);
    // print(email);
    // print(password);

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: Map<String, String>.from(
          {
            'Authorization': 'Bearer ' +
                Keys.navKey.currentContext.read(authDataProvider).token,
          },
        ),
      );
      //print("URL   : " + url.toString());

      print("Response1  " + response.body.toString());
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (response.statusCode >= 400) {
        throw HttpException('An Error occurred!');
      }

      _ListProductCartItem.removeAt(
        _ListProductCartItem.indexWhere((element) => element.id == Cartid),
      );
      //print("len");
      // print(_ListProductCartItem.length);
      _TotalPrice = CalcTotal().toDouble();
      notifyListeners();
    } catch (e) {
      print("E  " + e);
      throw e;
    }
  }
}
