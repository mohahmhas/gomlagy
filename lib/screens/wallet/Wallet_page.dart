import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gomalgy/helpers/base_url.dart' as baseurl;
import 'package:gomalgy/helpers/keys.dart';
import 'package:gomalgy/providers/auth.dart';
import 'package:gomalgy/providers/localization/app_localizations.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletPage extends StatefulWidget {
  static String id = '/wallet';

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(AppLocalizations.of(context).translate('my_wallet')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              BalanceBuilderContainer(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 14,
              ),
              Text(
                AppLocalizations.of(context)
                    .translate('wallet_recharge_history'),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget BalanceBuilderContainer() {
    return FutureBuilder(
      future: getBalance(),
      builder: (context, snaptshot) {
        if (snaptshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        print("Snap  ${snaptshot.data}");
        return Container(
          child: Column(
            children: [
              Text(
                "${double.parse((snaptshot.data).toString())} EG",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(AppLocalizations.of(context).translate('wallet_balance')),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> getBalance() async {
    // print(email);
    // print(password);

    try {
      final url = baseurl.Urls.api +
          '/wallet/balance/' +
          Keys.navKey.currentContext.read(authDataProvider).userId;
      print(url);
      print('url---------------');

      final response = await http.get(
        Uri.parse(url),
        headers: Map<String, String>.from({
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
          'Authorization': 'Bearer ' +
              Keys.navKey.currentContext.read(authDataProvider).token,
        }),
      );
      print("URL   : " + url.toString());
      print("Response1  " + response.body.toString());
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (response.statusCode >= 400) {
        print(response.body);
        throw HttpException('An Error occurred!');
      }

      print("SSSSSSSSSSS    " + responseData['balance'].toString());
      return responseData['balance'];
    } catch (e) {
      print("E  " + e.toString());
      throw e;
    }
  }
}
