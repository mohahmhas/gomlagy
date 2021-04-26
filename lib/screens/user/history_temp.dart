import 'package:flutter/material.dart';
import 'package:gomlgy/providers/localization/app_localizations.dart';
import 'package:gomlgy/screens/user/orderdetailshistory.dart';

class HistoryTemp extends StatelessWidget {
  String code;
  String date;
  String paymentStatus;
  double grandTotal;
  String link;
  String address;
  String city;
  String country;
  String payment_type;
  double coupon_discount;
  double shipping_cost;
  double subtotal;
  double tax;

  HistoryTemp({
    this.code,
    this.date,
    this.paymentStatus,
    this.grandTotal,
    this.link,
    this.address,
    this.city,
    this.country,
    this.payment_type,
    this.coupon_discount,
    this.shipping_cost,
    this.subtotal,
    this.tax,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.98,
      height: MediaQuery.of(context).size.height * 0.12,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, OrdarDetails.id, arguments: {
            'code': code,
            'date': date,
            'city': city,
            'address': address,
            'country': country,
            'paymentStatus': paymentStatus,
            'grandTotal': grandTotal,
            'payment_type': payment_type,
            'coupon_discount': coupon_discount,
            'shipping_cost': shipping_cost,
            'subtotal': subtotal,
            'tax': tax,
            'link': link
          });
        },
        child: Card(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          code,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Row(
                          children: [
                            Text(AppLocalizations.of(context)
                                .translate('data_')),
                            Text(date), //scope
                          ],
                        ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * 0.01,
                        // ),
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .translate('payment_status'),
                            ),
                            Text(paymentStatus), //scope
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${grandTotal} ج.م",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
