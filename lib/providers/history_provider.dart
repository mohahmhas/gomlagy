import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gomlgy/helpers/base_url.dart' as baseurl;
import 'package:gomlgy/helpers/http_exception.dart';
import 'package:gomlgy/helpers/keys.dart';
import 'package:gomlgy/models/history_model.dart';
import 'package:gomlgy/providers/auth.dart';
import 'package:http/http.dart' as http;
import 'auth.dart';

class PurchasesHistory {
  Future<List> fetchPurchaseHistory() async {
    var url = baseurl.Urls.api + '/purchase-history/137';
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

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // print(response.body);
      if (response.statusCode >= 400) {
        throw HttpException('An error occurred');
      }
      if (extractedData == null) {
        return [];
      }

      var data = (extractedData['data'] as List).map((data) {
        final extractedData = data as Map<String, dynamic>;

        return HistoryModel(
          code: extractedData['code'],
          date: extractedData['date'],
          paymentStatus: extractedData['payment_status'],
          grandTotal: double.parse(extractedData['grand_total'].toString()),
          address: extractedData['shipping_address']['address'],
          city: extractedData['shipping_address']['city'],
          country: extractedData['shipping_address']['country'],
          payment_type: extractedData['payment_type'],
          coupon_discount:
              double.parse(extractedData['coupon_discount'].toString()),
          shipping_cost:
              double.parse(extractedData['shipping_cost'].toString()),
          subtotal: double.parse(extractedData['subtotal'].toString()),
          tax: double.parse(extractedData['tax'].toString()),
          link: extractedData['links']["details"],
        );
      }).toList();

      return data;
    } catch (e) {
      throw HttpException('An error occurred');
    }
  }
}
