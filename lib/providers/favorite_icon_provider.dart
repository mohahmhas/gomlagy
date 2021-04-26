import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomlgy/helpers/keys.dart';
import 'package:http/http.dart' as http;
import '../helpers/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/base_url.dart' as baseurl;
import 'package:fluttertoast/fluttertoast.dart';

import 'auth.dart';

final favDataProvider = ChangeNotifierProvider<FavoriteIconProvider>((ref) {
  return FavoriteIconProvider();
});

class FavoriteIconProvider extends ChangeNotifier {
  bool _iconstatues = false;
  int _wishlistid;

  int get wishlistid => _wishlistid;

  bool get iconstatues => _iconstatues;

  Future changeStateIcon({String ProductId}) async {
    // print("_iconstatues");
    // print(_iconstatues);
    // print("_iconstatues");

    if (_iconstatues) {
      final url = baseurl.Urls.api + '/wishlists/' + _wishlistid.toString();
      try {
        final response = await http.delete(
          Uri.parse(url),
          headers: Map<String, String>.from({
            'Content-Type': 'application/json ;charset=UTF-8',
            'Charset': 'utf-8',
            'Authorization': 'Bearer ' +
                Keys.navKey.currentContext.read(authDataProvider).token,
          }),
        );

        print("Resresssss : ${response.body.toString()} ");
        final responseData = json.decode(response.body);
        //  print("dataADDREEESSS   $responseData ");
        if (responseData['error'] != null) {
          throw HttpException(responseData['error']['message']);
        }
        if (response.statusCode >= 400) {
          throw HttpException('An Error occurred!');
        }

        _iconstatues = false;
        Fluttertoast.showToast(msg: "Remove from Favorite List");
        notifyListeners();
      } catch (e) {
        print("E  " + e);
        throw e;
      }
    } else {
      final url = baseurl.Urls.api + '/wishlists';
      try {
        final response = await http.post(Uri.parse(url),
            headers: Map<String, String>.from({
              'Content-Type': 'application/json ;charset=UTF-8',
              'Charset': 'utf-8',
              'Authorization': 'Bearer ' +
                  Keys.navKey.currentContext.read(authDataProvider).token,
            }),
            body: json.encode({
              'user_id':
                  Keys.navKey.currentContext.read(authDataProvider).userId,
              'product_id': ProductId,
            }));

        //   print("Resresssss : ${response.body.toString()} ");
        final responseData = json.decode(response.body);
        //  print("dataADDREEESSS   $responseData ");
        if (responseData['error'] != null) {
          throw HttpException(responseData['error']['message']);
        }

        _iconstatues = true;
        Fluttertoast.showToast(msg: "Add to Favorite List");
        notifyListeners();
      } catch (e) {
        print("E  " + e);
        throw e;
      }
    }
  }

  Future<bool> checkproductfavorite({String ProductId}) async {
    final url = baseurl.Urls.api + '/wishlists/check-product';
    //print("Name is:  ${name}");
    // print(url);
    try {
      final response = await http.post(Uri.parse(url),
          headers: Map<String, String>.from({
            'Content-Type': 'application/json ;charset=UTF-8',
            'Charset': 'utf-8',
            'Authorization': 'Bearer' +
                Keys.navKey.currentContext.read(authDataProvider).token,
          }),
          body: json.encode({
            'user_id': Keys.navKey.currentContext.read(authDataProvider).userId,
            'product_id': ProductId,
          }));

      print("Resresssss : ${response.body.toString()} ");
      final responseData = json.decode(response.body);
      //  print("dataADDREEESSS   $responseData ");
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (response.statusCode >= 400) {
        throw HttpException('An Error occurred!');
      }
      //print(responseData["is_in_wishlist"]);
      _iconstatues = responseData["is_in_wishlist"];
      if (responseData["is_in_wishlist"]) {
        _wishlistid = responseData["wishlist_id"];
      }
      notifyListeners();
    } catch (e) {
      print("E  " + e.toString());
      throw e;
    }
  }
}
