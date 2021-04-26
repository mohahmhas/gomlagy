import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomlgy/helpers/keys.dart';
import 'package:gomlgy/providers/account_information.dart';
import '../helpers/base_url.dart' as baseurl;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/http_exception.dart';
import 'auth.dart';

final checkOutDataProvider = ChangeNotifierProvider<CheckOutProvider>((ref) {
  return CheckOutProvider();
});

class CheckOutProvider extends ChangeNotifier {
  Future<void> SendCouponCode({String Code}) async {
    final url = baseurl.Urls.api + '/coupon/apply';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: Map<String, String>.from(
          {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' +
                Keys.navKey.currentContext.read(authDataProvider).token,
          },
        ),
        body: json.encode(
          {
            'code': Code,
            'user_id': Keys.navKey.currentContext.read(authDataProvider).userId,
          },
        ),
      );
      //  print("ResAddAAddress  : ${response.body} ");
      final responseData = json.decode(response.body);
      //   print("data   $responseData ");
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (response.statusCode >= 400) {
        throw HttpException('An Error occurred!');
      }
    } catch (e) {
      print("E  " + e);
      throw e;
    }
  }

  Future<bool> payonDelivary({
    double GrandTotal,
  }) async {
    final url = baseurl.Urls.api + '/payments/pay/cod';

    final selectedaddress =
        Keys.navKey.currentContext.read(accountDataProvider).selectedAddress;
/*
    print("Test");
    //print(selectedaddress['city']);
    print(selectedaddress.addressdetails);
    print(selectedaddress.city);
    print(selectedaddress.country);
    print(selectedaddress.postalCode);
    print(selectedaddress.phone);
    print("*********************************************");
    print(Keys.navKey.currentContext.read(authDataProvider).email.toString());
    print(
        Keys.navKey.currentContext.read(authDataProvider).username.toString());
    print(int.parse(
        Keys.navKey.currentContext.read(authDataProvider).userId.toString()));
    print("*********************************************");
    print("Test");
*/
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: Map<String, String>.from(
          {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' +
                Keys.navKey.currentContext.read(authDataProvider).token,
          },
        ),
        body: json.encode(
          {
            'payment_type': 'cod',
            'payment_status': 'unpaid',
            'grand_total': GrandTotal,
            'user_id': int.parse(Keys.navKey.currentContext
                .read(authDataProvider)
                .userId
                .toString()),
            'coupon_discount': 0.0,
            'coupon_code': " ",
            'shipping_address': json.encode({
              'name': Keys.navKey.currentContext
                  .read(authDataProvider)
                  .username
                  .toString(),
              'email': Keys.navKey.currentContext
                  .read(authDataProvider)
                  .email
                  .toString(),
              'address': selectedaddress.addressdetails.toString(),
              'country': selectedaddress.country.toString(),
              'city': selectedaddress.city.toString(),
              'postal_code': selectedaddress.postalCode.toString(),
              'phone': selectedaddress.phone.toString(),
              'checkout_type': 'logged',
            }),
          },
        ),
      );
      // print("ResAddAAddress  : ${response.body} ");
      final responseData = json.decode(response.body);
      // print("data   $responseData ");
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (response.statusCode >= 400) {
        throw HttpException('An Error occurred!');
      }

      if (responseData["message"] ==
          "Your order has been placed successfully") {
        // print('successfully');
        SendEmail();
        return true;
      }
      return true;
    } catch (e) {
      print("E  " + e);
      return false;
    }
  }

  Future<void> SendEmail() async {
    final url = baseurl.Urls.api + '/send-email';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: Map<String, String>.from(
          {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' +
                Keys.navKey.currentContext.read(authDataProvider).token,
          },
        ),
        body: json.encode(
          {
            'user_id': Keys.navKey.currentContext.read(authDataProvider).userId,
          },
        ),
      );
      //  print("ResAddAAddress  : ${response.body} ");
      final responseData = json.decode(response.body);
      //   print("data   $responseData ");
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (response.statusCode >= 400) {
        throw HttpException('An Error occurred!');
      }
    } catch (e) {
      print("E  " + e);
      throw e;
    }
  }
}
