import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomlgy/screens/payment/fatwora.dart';
import 'package:wave_transition/wave_transition.dart';
import '../providers/account_information.dart';
import 'package:gomlgy/providers/localization/app_localizations.dart';

class ShippingInformation extends StatefulWidget {
//  AccountInformation accountInformation ;
  @override
  _ShippingInformationState createState() => _ShippingInformationState();
}

class _ShippingInformationState extends State<ShippingInformation> {
  int isDefualt;
  String addressDetails, cityName, country;

  @override
  Widget build(BuildContext context) {
    context.read(accountDataProvider).getAccountInformationAddress();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context).translate('shipping_information')),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * .030,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .01),
              child: Text(
                AppLocalizations.of(context)
                    .translate('choose_a_shipping_address'),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Consumer(
            builder: (context, watch, child) {
              final accountInformation = watch(accountDataProvider);

              List<Widget> list = [];
              list = List.from(
                accountInformation.address.map((e) {
                  int id = e.id;
                  isDefualt = e.setDefault;
                  if (isDefualt == 1) {
                    addressDetails = e.addressdetails;
                    cityName = e.city;
                    country = e.country;
                  }
                  // print('id = $id') ;
                  print(addressDetails);
                  print(cityName);
                  print(country);
                  print('isDefualt = $isDefualt');
                  return Container(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * .03),
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * .02,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.addressdetails),
                            Text(e.city),
                            Text(e.postalCode),
                            Text(e.country),
                            Text(e.phone),
                          ],
                        ),
                        Checkbox(
                            value: isDefualt == 1 ? true : false,
                            onChanged: (bool newValue) {
                              context
                                  .read(accountDataProvider)
                                  .setDefaultAddress(id, newValue);
                            }),
                      ],
                    ),
                  );
                }),
              );
              return Container(
                height: MediaQuery.of(context).size.height * .78,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 8.0,
                    children: list,
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              print('id = ${context.read(accountDataProvider).id}');
              context.read(accountDataProvider).id > 0
                  ?
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => Fatwora(
                  //           addressDetails: addressDetails,
                  //           cityName: cityName,
                  //           country: country,
                  //         )))

                  Navigator.push(
                      context,
                      WaveTransition(
                          child: Fatwora(
                            addressDetails: addressDetails,
                            cityName: cityName,
                            country: country,
                          ),
                          center: FractionalOffset(0.90, 0.90),
                          duration: Duration(milliseconds: 3000) // optional
                          ))
                  : Fluttertoast.showToast(msg: 'choose one');
            },
            child: Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * .03),
                height: MediaQuery.of(context).size.height * .065,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).primaryColor,
                child: Text(
                  AppLocalizations.of(context).translate('proceed_to_payment'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
          ),
        ],
      ),
    );
  }
}
