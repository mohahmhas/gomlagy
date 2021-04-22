import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomalgy/providers/shop_cart_provider.dart';
import 'package:gomalgy/widget/text_copon.dart';

class CardPayment extends StatefulWidget {
  static String id = 'CardPayment';

  @override
  _CardPaymentState createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  @override
  Widget build(BuildContext context) {
    int flexNUm, flexBrith, flexCvc;

    funNUmber() {
      setState(() {
        flexNUm = 3;
        flexBrith = 1;
        flexCvc = 0;
      });
    }

    funBirth() {
      setState(() {
        flexNUm = 1;
        flexBrith = 1;
        flexCvc = 1;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Card Payment'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Consumer(
              builder: (context, watch, child) {
                final GetpriceProvider = watch(CartItemDataProvider);

                return Container(
                  padding: EdgeInsets.all(8),
                  color: Theme.of(context).primaryColor,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'SUB TOTAL',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            '0.0',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TAX',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            GetpriceProvider.GetListProductCartItem[0].tax
                                .toString(),
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shipping Cost',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            GetpriceProvider.TotalPriceShipping.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'COUPON Discount',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            '0.0',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'GRAND TOTAL',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            GetpriceProvider.TotalPrice.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: 15,
            ),
            Center(
                child: Text(
              'Enter your Credit or debit Card inform to \n complete the checkout and place order',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).textScaleFactor * 16),
              overflow: TextOverflow.ellipsis,
            )),
            SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.grey[300],
              width: MediaQuery.of(context).size.width * 0.95,
              height: 50,
              child: TextFieldsCopon(
                hint: '1234  1234  1234 1234 ',
                icon: Icons.view_stream_rounded,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (c) => AlertDialog(
                              title: Row(
                                children: [
                                  CircularProgressIndicator(),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Please wait.Your Transaction\n is Processing',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: MediaQuery.of(context)
                                                  .textScaleFactor *
                                              14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        barrierDismissible: false);
                  },
                  child: Text('CONFIRM PAYMENT')),
            )
          ],
        ),
      ),
    );
  }
}
