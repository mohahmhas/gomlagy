import 'package:flutter/material.dart';

class OederDetailsTemp extends StatelessWidget {
  static String id = 'OederDetailsTemp';

  final String code;
  final String date;
  final String paymentStatus;
  final double grandTotal;
  final String address;
  final String city;
  final String country;
  final String payment_type;
  final double subtotal;
  final double coupon_discount;
  final double tax;
  final double shipping_cost;
  final String product;
  final double price;
  final int quantity;

  final String linke; //

  const OederDetailsTemp({
    Key key,
    this.code,
    this.date,
    this.paymentStatus,
    this.grandTotal,
    this.address,
    this.city,
    this.country,
    this.payment_type,
    this.subtotal,
    this.coupon_discount, //
    this.tax, //
    this.shipping_cost, //
    this.product, //
    this.price, //
    this.quantity, //
    this.linke,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final data =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    print('data______');

    //print(data['subdata']);
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      //size loop
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product ?? '',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                quantity.toString() ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SubTitel(
              fText: 'PENDING',
              sText: price.toString() ?? '',
              tText: 'ج.م',
              colorstext4: true,
              context: context),
        ],
      ),
    );
  }

  Widget SubTitel(
      {colorstext4, String fText, String sText, String tText, context}) {
    return Row(
      children: [
        Text(
          fText ?? '',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorstext4 ? Theme.of(context).primaryColor : Colors.black,
          ),
        ),
        Text(
          sText ?? '',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorstext4 ? Theme.of(context).primaryColor : Colors.black,
          ),
        ),
        Text(
          tText ?? '',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorstext4 ? Theme.of(context).primaryColor : Colors.black,
          ),
        ),
      ],
    );
  }
}
