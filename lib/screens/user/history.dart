import 'package:flutter/material.dart';
import 'package:gomlgy/providers/history_provider.dart';
import 'package:gomlgy/providers/localization/app_localizations.dart';
import 'package:gomlgy/screens/user/history_temp.dart';
import 'package:gomlgy/widget/navigationBar.dart';
import 'package:gomlgy/widget/navigationBar.dart';

class HistoryPage extends StatefulWidget {
  static String id = 'HistoryPage';

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Navigat()));
  }

  @override
  Widget build(BuildContext context) {
    PurchasesHistory apiHistory = PurchasesHistory();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate('purchase_history')),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Navigat()));
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        children: [
          FutureBuilder(
              future: apiHistory.fetchPurchaseHistory(),
              builder: (ctx, snaptshot) {
                if (snaptshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                List<Widget> list = [];
                list = List.from(snaptshot.data.map((e) {
                  //  print('object11122==>' + e.grand_total);
                  return HistoryTemp(
                    code: e.code.toString(),
                    date: e.date.toString(),
                    paymentStatus: e.paymentStatus.toString(),
                    grandTotal: e.grandTotal,
                    address: e.address.toString(),
                    city: e.city.toString(),
                    country: e.country.toString(),
                    payment_type: e.payment_type.toString(),
                    coupon_discount: double.parse(e.coupon_discount.toString()),
                    shipping_cost: double.parse(e.shipping_cost.toString()),
                    subtotal: double.parse(e.subtotal.toString()),
                    tax: double.parse(e.tax.toString()),
                    link: e.link,
                  );
                }));

                return Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.start,

                  alignment: WrapAlignment.start,

                  //textDirection: TextDirection.rtl,
                  runAlignment: WrapAlignment.start,
                  runSpacing: 3.0,
                  spacing: 5.0,

                  // verticalDirection: VerticalDirection.up,
                  children: list.length > 0 ? list : Container(),
                );
              }),
        ],
      ),
    );
  }
}
