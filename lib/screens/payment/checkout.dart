import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomalgy/providers/auth.dart';
import 'package:gomalgy/providers/checkout_provider.dart';
import 'package:gomalgy/providers/shop_cart_provider.dart';
import 'package:gomalgy/screens/outhantication/log_screen.dart';
import 'package:gomalgy/screens/payment/card_Payment.dart';
import 'package:gomalgy/screens/user/history.dart';
import 'package:gomalgy/widget/shop_card/custom_payment_widget.dart';
import 'package:gomalgy/widget/text_copon.dart';
import 'package:url_launcher/url_launcher.dart';

enum PaymentWays { paypal, visa, wallet, cash }

class CheckOut extends StatefulWidget {
  static String id = 'CheckOut';

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  Map<PaymentWays, bool> checked = {
    PaymentWays.cash: false,
    PaymentWays.paypal: false,
    PaymentWays.visa: false,
    PaymentWays.wallet: false,
  };

  @override
  Widget build(BuildContext context) {
    CustomPaymentWidget www = CustomPaymentWidget();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Function stState() {
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Checkout',
        ),
        leading: null,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              CustomPaymentWidget(
                image: 'assets/paypal_logo_png_7.png',
                text: 'Checkout With Paypal',
                id: PaymentWays.paypal,
                checked: checked,
                ststate: stState,
              ),
              CustomPaymentWidget(
                image: 'assets/cardpayment.png',
                text: 'Checkout With Card',
                id: PaymentWays.visa,
                ststate: stState,
                checked: checked,
              ),
              CustomPaymentWidget(
                image: 'assets/cod.png',
                text: 'Cach on Delivery',
                id: PaymentWays.cash,
                ststate: stState,
                checked: checked,
              ),
              CustomPaymentWidget(
                image: 'assets/paypal_logo_png_7.png',
                text: 'Wallet Balance',
                id: PaymentWays.wallet,
                ststate: stState,
                checked: checked,
              ),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 8,
            child: TextFieldsCopon(
              hint: 'Coupon Code',
              boolen: true,
            ),
          ),
          Positioned(
            left: 0,
            bottom: MediaQuery.of(context).size.height / 14,
            child: Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).textScaleFactor * 18),
                  ),
                  Consumer(
                    builder: (context, watch, child) {
                      final GetTotalpriceProvider = watch(CartItemDataProvider);

                      return Text(
                        GetTotalpriceProvider.TotalPrice.toString() + ' ج.م',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 18),
                      );
                    },
                  ),
                ],
              ),
            ),
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
                    PaymentWays selectedWay;
                    checked.forEach((k, v) {
                      if (v == true) {
                        selectedWay = k;
                      }
                    });
                    // print("chooooooooooooooose");
                    // print(selectedWay);
                    // print("caaaaaaaaaaaaaaaaaaaaae");
                    _nav(selectedWay);
                    // print("chooooooooooooooose");
                  },
                  child: Text('PROCEED TO CHECKOUT')),
            ),
          ),
        ],
      ),
    );
  }

  _nav(selectedWay) {
    switch (selectedWay) {
      case PaymentWays.paypal:
        return openUrl(
            url:
                'https://www.google.com/search?q=riverpod&authuser=0&sxsrf=ALeKk01B8lsCJkfigMF5PzJ-mYWnmyNx0g%3A1617639039850&source=hp&ei=fzZrYIPPMfTOgwft-4PIDA&iflsig=AINFCbYAAAAAYGtEj_w90-UaywDGbYQTAPQ31qTLyBei&oq=&gs_lcp=Cgdnd3Mtd2l6EAEYAzIHCCMQ6gIQJzIHCC4Q6gIQJzIHCCMQ6gIQJzIHCCMQ6gIQJzIHCCMQ6gIQJzIJCCMQ6gIQJxATMgkIIxDqAhAnEBMyBwgjEOoCECcyCQgjEOoCECcQEzIHCCMQ6gIQJ1AAWABgoCBoAXAAeACAAQCIAQCSAQCYAQCqAQdnd3Mtd2l6sAEK&sclient=gws-wiz');

      case PaymentWays.visa:
        return Navigator.pushNamed(context, CardPayment.id);
      case PaymentWays.cash:
        // print("switch");
        // print(context.read(CartItemDataProvider).TotalPrice);
        return context
            .read(checkOutDataProvider)
            .payonDelivary(
              GrandTotal: context.read(CartItemDataProvider).TotalPrice,
            )
            .then((value) {
          // print("val");
          // print(value);
          if (value == true) {
            Fluttertoast.showToast(msg: "Done");
            //     print("in if");
            return Navigator.pushNamed(context, HistoryPage.id);
          } else {
            //     print("in else");
            Fluttertoast.showToast(msg: "some thing went wrong!!");
          }
        });
      case PaymentWays.wallet:
        return showDialog(
          context: context,
          builder: (c) => AlertDialog(
            title: Row(
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Please wait.Your Request\n is Processing',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: MediaQuery.of(context).textScaleFactor * 14),
                  ),
                ),
              ],
            ),
          ),
          barrierDismissible: false,
        );
    }
  }

  static Future openUrl({String url}) async {
    if (url.trim().isEmpty) {
      await _openUrl('http://google.com');
    } else {
      await _openUrl('http:$url.com');
    }
  }

  static Future _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
