import 'package:flutter/material.dart';
import 'package:gomlgy/providers/localization/app_localizations.dart';
import 'package:gomlgy/screens/payment/checkout.dart';
import 'package:wave_transition/wave_transition.dart';

class Fatwora extends StatelessWidget {
  final String addressDetails, cityName, country;
  Fatwora({this.addressDetails, this.cityName, this.country});
  static String id = 'Fatwora';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[900],
          title: Text(
            'Gomlgy',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        body: Stack(children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .02,
                    ),
                    child: Text(
                      AppLocalizations.of(context).translate('fatwora'),
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.orange[900],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .05,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .01),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .03),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('order_date'),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .03),
                          child: Text(
                            '31--03-2021',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .03),
                          child: Text(
                            AppLocalizations.of(context).translate('address'),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .03),
                          child: Text(
                            '$addressDetails , $cityName , $country',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .03),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('ordered_products'),
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.orange[900],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .01,
                      ),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .006,
                            right: MediaQuery.of(context).size.width * .006),
                        color: Color(0xffC1C2AF),
                        height: height * 0.06,
                        width: width * 9,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          'Product Name',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.4,
                                        color: Colors.white,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .03,
                                        child: Center(
                                          child: Text(
                                            'mobil Cover mobile',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          'price',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.1,
                                        color: Colors.white,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .03,
                                        child: Center(
                                          child: Text(
                                            '20',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          'Shipping',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.3,
                                        color: Colors.white,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .03,
                                        child: Center(
                                          child: Text(
                                            '30',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          'quantity',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.2,
                                        color: Colors.white,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .03,
                                        child: Center(
                                          child: Text(
                                            '7',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: Text(
                            AppLocalizations.of(context).translate('total'),
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.orange[900],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('shipping_cost'),
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            '30',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('total_amount'),
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            '350',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              height: height * 0.06,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    // Navigator.pushNamed(context, CheckOut.id);
                    Navigator.push(
                        context,
                        WaveTransition(
                            child: CheckOut(),
                            center: FractionalOffset(0.90, 0.90),
                            duration: Duration(milliseconds: 3000) // optional
                            ));
                  },
                  child: Text(AppLocalizations.of(context)
                      .translate('proceed_to_checkout'))),
            ),
          ),
        ]),
      ),
    );
  }
}
