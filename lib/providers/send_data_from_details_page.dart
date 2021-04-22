import 'package:gomalgy/helpers/base_url.dart' as baseurl;
import 'package:gomalgy/helpers/keys.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gomalgy/helpers/http_exception.dart';

import 'auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendDataToCartClass {
  static Future<bool> SendDataToCart({
    int quantity,
    String variation,
    String productId,
  }) async {
    final url = baseurl.Urls.api + '/carts/add';
    //print("Name is:  ${name}");
    // print(url);
    print("Var $variation");
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: Map<String, String>.from({
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
          'Authorization': 'Bearer ' +
              Keys.navKey.currentContext.read(authDataProvider).token,
        }),
        body: json.encode(
          {
            'user_id': Keys.navKey.currentContext.read(authDataProvider).userId,
            'id': productId,
            'quantity': quantity,
            'variant': variation,
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

      print("Send Successfully to cart");
      return true;
    } catch (e) {
      print("E  " + e);
      throw e;
    }
  }
}
