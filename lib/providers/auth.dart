import 'dart:convert';
import 'dart:convert' as convert;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../helpers/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/base_url.dart' as baseurl;

final authDataProvider = ChangeNotifierProvider<Auth>((ref) {
  return Auth();
});

class Auth extends ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  Map<String, dynamic> _user;
  Timer _authTimer;
  bool _isVerified = false;
  bool get isAuth {
    return token != null;
  }

  bool get isVerified {
    return _isVerified;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _user['id'].toString();
  }

  String get username {
    return _user['name'];
  }

  String get email {
    return _user['email'];
  }

  Future<bool> _authenticateLogin(String email, String password) async {
    final url = baseurl.Urls.api + '/auth/login';

    try {
      final response = await http.post(Uri.parse(url),
          headers: Map<String, String>.from({
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }),
          body: json.encode({
            'email': email,
            'password': password,
          }));
      print(response.body.toString());
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (response.statusCode >= 400) {
        print(response.body);

        throw HttpException('An Error occurred!');
      }
      // {"message":"Please verify your account","is_verified":0}
      if (responseData['is_verified'] == 0) {
        _isVerified = false;
        notifyListeners();

        return false;
      }
      _isVerified = true;

      _token = responseData['access_token'];
      print(_token);
      _user = responseData['user'];
      print(_user['id']);
      print(_user);

      _expiryDate = DateTime.parse(responseData['expires_at']);

      _autoLogout();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final userData = json.encode({
        'token': _token,
        'user': _user,
        'expiryDate': _expiryDate.toIso8601String()
      });

      prefs.setString('userData', userData);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> sendCode(String code) async {
    final url = baseurl.Urls.api + '/auth/check_code';

    try {
      var map = new Map<String, dynamic>();
      map['code'] = code;

      final response = await http.post(
        Uri.parse(url),
        headers: Map<String, String>.from({
          'Content-Type': 'application/x-www-form-urlencoded',
        }),
        body: map,
      );
      print(response.body.toString());
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (response.statusCode >= 400) {
        print(response.body);

        throw HttpException('An Error occurred!');
      }
      // {"message":"Please verify your account","is_verified":0}
      if (responseData['message'] == "True") {
        _isVerified = true;

        notifyListeners();

        return true;
      }

      return false;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> _authenticateRegister(
      String email, String password, String name) async {
    final url = baseurl.Urls.api + '/auth/signup';

    try {
      final response = await http.post(Uri.parse(url),
          headers: Map<String, String>.from({
            'Content-Type': 'application/json',
            'Charset': 'utf-8',
          }),
          body: json
              .encode({'email': email, 'password': password, 'name': name}));
      final responseData = json.decode(response.body);
      if (response.body
          .contains(new RegExp(r'<!DOCTYPE html>', caseSensitive: false))) {
        throw HttpException('An error Accourd');
      }

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (response.statusCode >= 400) {
        print(response.body);

        throw HttpException('An Error occurred!');
      }
      //json.decode(responseData['message']);
      print(responseData['message']);
      if (responseData['message'] ==
          'Registration Successful. Please verify and log in to your account.') {
        _isVerified = false;
        notifyListeners();
        return true;
      } else {
        print('object------------------');
        return false;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> signup(String email, String password, String name) async {
    return _authenticateRegister(email, password, name).then((value) {
      if (value) {
        return true;
      }
      return false;
    }).catchError((e) {
      print(e);
      return false;
    });
  }

  Future<bool> signin(String email, String password) async {
    return _authenticateLogin(email, password).then((value) {
      if (value) {
        return true;
      }
      return false;
    }).catchError((e) {
      return false;
    });
  }

  Future<bool> tryAutoSignin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedEncryptedUserData = prefs.getString('userData');
    //print("extractedEncryptedUserData");
    //print(extractedEncryptedUserData);

    final extractedUserData =
        json.decode(extractedEncryptedUserData) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData['token'];
    _user = extractedUserData['user'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  void logout() async {
    _token = null;
    _user = {};
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
//    Keys.navKey.currentState.pushReplacementNamed('/');

    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    print(timeToExpiry);
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
