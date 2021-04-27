import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomlgy/helpers/keys.dart';
import 'package:gomlgy/models/address.dart';
import '../helpers/base_url.dart' as baseurl;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/http_exception.dart';
import 'auth.dart';

final accountDataProvider = ChangeNotifierProvider<AccountInformation>((ref) {
  return AccountInformation();
});

class AccountInformation with ChangeNotifier {
  String _name;
  String _email;
  List<Address> _address = [];
  int _id = 0;

  get id {
    return _id;
  }

  get name {
    return _name;
  }

  get email {
    return _email;
  }

  get address {
    return [..._address];
  }

  get selectedAddress {
    var indexSelected =
        _address.indexWhere((element) => element.setDefault == 1);
    //  print(_address.indexWhere((element) => element.setDefault == 1));
    return _address[indexSelected];
  }

  Future<void> changeAccountInformation({String name}) async {
    final url = baseurl.Urls.api + '/user/info/update';
    print("Name is:  ${name}");
    print(url);
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
            'name': name,
            'user_id': Keys.navKey.currentContext.read(authDataProvider).userId,
          },
        ),
      );
      print("ResAddAAddress  : ${response.body} ");
      final responseData = json.decode(response.body);
      print("data   $responseData ");
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (response.statusCode >= 400) {
        throw HttpException('An Error occurred!');
      }

      if (responseData["message"] ==
          "Profile information has been updated successfully") {
        print('updated');
        _name = name;
        Keys.navKey.currentContext.read(authDataProvider).changeUserName(name);
        notifyListeners();
        Fluttertoast.showToast(msg: "Updated");
      } else {
        Fluttertoast.showToast(msg: "An Error occurred!");
      }
    } catch (e) {
      print("E  " + e);
      throw e;
    }
  }

  Future<void> setDefaultAddress(int id, bool status) {
    int val = 0;
    if (status) {
      val = 1;
      _id = id;
    } else {
      val = 0;
      _id = 0;
    }

    _address.forEach((element_main) {
      _address[_address.indexWhere((element) => element.id == element_main.id)]
          .setDefault = 0;
    });

    _address[_address.indexWhere((element) => element.id == id)].setDefault =
        val;

    notifyListeners();
  }

  //'137'
  Future<String> getAccountInformation() async {
    final url = baseurl.Urls.api +
        '/user/info/' +
        Keys.navKey.currentContext.read(authDataProvider).userId;

    // print(url);
    // print(email);
    // print(password);

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: Map<String, String>.from({
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' +
              Keys.navKey.currentContext.read(authDataProvider).token,
        }),
      );
      //print("URL   : " + url.toString());
      //print("Response1  " + response.body.toString());
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (response.statusCode >= 400) {
        throw HttpException('An Error occurred!');
      }

      _name = responseData["data"][0]['name'];
      _email = responseData["data"][0]['email'];
      //_address = responseData["data"][0]['email'];
      notifyListeners();
    } catch (e) {
      print("E  " + e);
      throw e;
    }
  }

  Future DeleteaccountInformationAddress({int Addressid}) async {
    final url =
        baseurl.Urls.api + '/user/shipping/delete/' + Addressid.toString();

    //print(url);
    // print(email);
    // print(password);
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: Map<String, String>.from({
          'Authorization': 'Bearer ' +
              Keys.navKey.currentContext.read(authDataProvider).token,
        }),
      );

      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (response.statusCode >= 400) {
        throw HttpException('An Error occurred!');
      }

      _address.removeAt(
        _address.indexWhere((element) => element.id == Addressid),
      );
      notifyListeners();
    } catch (e) {
      print("E =  $e");
      throw e;
    }
  }

  Future<void> getAccountInformationAddress() async {
    final url = baseurl.Urls.api +
        '/user/shipping/address/' +
        Keys.navKey.currentContext.read(authDataProvider).userId;
    //print(url);
    // print(email);
    // print(password);

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: Map<String, String>.from({
          'Authorization': 'Bearer ' +
              Keys.navKey.currentContext.read(authDataProvider).token,
        }),
      );
      //print("URL   : " + url.toString());
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

        return Address(
          city: extractedData['city'],
          addressdetails: extractedData['address'],
          country: extractedData['country'],
          postalCode: extractedData['postal_code'],
          userId: extractedData['user_id'],
          id: extractedData['id'],
          phone: extractedData['phone'],
          setDefault: extractedData['set_default'],
        );
      }).toList();

      _address = data;
      notifyListeners();
    } catch (e) {
      print("E  " + e);
      throw e;
    }
  }

  Future<void> addAddressAccountInformation({
    String address,
    String city,
    String country,
    String phone,
    String postal_code,
    String user_id,
  }) async {
    final url = baseurl.Urls.api + '/user/shipping/create';
    //print("Name is:  ${name}");
    print(url);
    try {
      final response = await http.post(Uri.parse(url),
          headers: Map<String, String>.from({
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' +
                Keys.navKey.currentContext.read(authDataProvider).token,
          }),
          body: json.encode({
            'address': address,
            'city': city,
            'country': country,
            'phone': phone,
            'postal_code': postal_code,
            'user_id': Keys.navKey.currentContext.read(authDataProvider).userId,
          }));
      print("ResADDresssss : ${response.body} ");
      final responseData = json.decode(response.body);
      print("dataADDREEESSS   $responseData ");
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (response.statusCode >= 400) {
        throw HttpException('An Error occurred!');
      }

      if (responseData["message"] ==
          "Profile information has been updated successfully") {
        print('updated');
        //    _name = name;

      } else {}
      notifyListeners();
    } catch (e) {
      print("E  " + e);
      throw e;
    }
  }
}
