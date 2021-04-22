import 'package:flutter/material.dart';
import 'package:gomalgy/providers/history_provider.dart';
import 'package:gomalgy/providers/localization/app_localizations.dart';

import 'package:gomalgy/providers/orderDetailsProvider.dart';
import 'package:gomalgy/screens/user/orderDetailsTemp.dart';

class OrdarDetails extends StatelessWidget {
  static String id = 'OrdarDetails';
  String paymentStatus;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    final data =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    OederDetailsTemp mod = OederDetailsTemp();
    PurchasesHistory methodApi = PurchasesHistory();
    OrderDetailsProvider orderApi = OrderDetailsProvider();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppLocalizations.of(context).translate('order_details')),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: orderApi.fetchHistoryDetails(data['link']),
            builder: (context, snapShot) {
              print(snapShot.data);
              print('object');
              if (snapShot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapShot.hasData) {
                List<Widget> listup = List.from(snapShot.data.map((e) {
                  print('snapShot.data');
                  print(snapShot.data);
                  return OederDetailsTemp(
                    quantity: e.quantity,
                    product: e.product,
                    paymentStatus: e.payment_type,
                    subtotal: e.subtotal,
                    tax: e.tax,
                    price: e.price,
                    shipping_cost: e.shipping_cost,
                    coupon_discount: e.coupon_discount,
                  );
                }));
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          BuildRow(
                            context: context,
                            text1: 'order code ',
                            text2: data['code'],
                            colorstext2: true,
                            text3: "Shipping Method",
                            text4: 'flat Shipping rate',
                            colorstext4: false,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          BuildRow(
                              context: context,
                              text1: 'order Date ',
                              text2: data['date'],
                              colorstext2: false,
                              colorstext4: false,
                              text3: 'Shipping Method ',
                              text4: data['paymentStatus']),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          BuildRow(
                            context: context,
                            text1: 'Payment Status',
                            text2: data['payment_type'],
                            colorstext2: true,
                            text3: 'Total Amount',
                            text4: data['grandTotal'].toString() + 'ج.م',
                            colorstext4: true,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                    .translate('shipping_address'),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  data['address'] ?? '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  ',' + data['city'] ?? '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  ',' + data['country'] ?? '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                    .translate('ordered_products'),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                          Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            alignment: WrapAlignment.center,
                            children: listup,
                          ),
                          Column(
                            children: [
                              SubTitel(
                                  fText: 'SUB TOTAL',
                                  sText: ' ' + data['subtotal'].toString(),
                                  tText: 'ج.م',
                                  colorstext4: false,
                                  context: context),
                              SubTitel(
                                  fText: 'TAX',
                                  sText: ' ' + data['tax'].toString(),
                                  tText: 'ج.م',
                                  colorstext4: false,
                                  context: context),
                              SubTitel(
                                  fText: 'Shipping Cost',
                                  sText: ' ' +
                                      data['shipping_cost'].toStringAsFixed(2),
                                  tText: 'ج.م',
                                  colorstext4: false,
                                  context: context),
                              SubTitel(
                                  fText: 'DISCOUND',
                                  sText:
                                      ' ' + data['coupon_discount'].toString(),
                                  tText: 'ج.م',
                                  colorstext4: false,
                                  context: context),
                              SubTitel(
                                  fText: 'GRAND TOTAL',
                                  sText: ' ' + data['grandTotal'].toString(),
                                  tText: 'ج.م',
                                  colorstext4: true,
                                  context: context),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Text('try again');
              }
            },
          ),
        ));
  }

  Widget BuildRow({
    BuildContext context,
    String text1,
    String text2,
    String text3,
    String text4,
    bool colorstext2,
    bool colorstext4,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text1 ?? '',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            Text(
              text2 ?? '',
              style: TextStyle(
                fontWeight: colorstext4 ? FontWeight.w900 : FontWeight.w900,
                color:
                    colorstext2 ? Theme.of(context).primaryColor : Colors.grey,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text3 ?? '',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            Text(
              text4 ?? '',
              style: TextStyle(
                fontWeight: colorstext4 ? FontWeight.w900 : FontWeight.w900,
                color:
                    colorstext4 ? Theme.of(context).primaryColor : Colors.grey,
              ),
            ),
          ],
        ),
      ],
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
