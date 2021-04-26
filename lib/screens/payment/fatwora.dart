import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomlgy/providers/localization/app_localizations.dart';
import 'package:gomlgy/providers/shop_cart_provider.dart';
import 'package:gomlgy/screens/payment/checkout.dart';
import 'package:intl/intl.dart';

class Fatwora extends StatelessWidget {
  final String addressDetails, cityName, country;
  Fatwora({this.addressDetails, this.cityName, this.country});
  static String id = 'Fatwora';

  String GetCurrentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Gomlgy',
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).textScaleFactor * 22,
          ),
        ),
        leading: null,
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: height * .03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('fatwora'),
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).textScaleFactor * 20,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('order_date'),
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).textScaleFactor * 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ": ${GetCurrentDate()}",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).textScaleFactor * 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).textScaleFactor * 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ':  $addressDetails , $cityName , $country',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).textScaleFactor * 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ordered Products',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).textScaleFactor * 24,
                          color: Colors.orange[900],
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                ///////////////////
                TableBuilder(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Text(
                  'total',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).textScaleFactor * 24,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),

                Consumer(
                  builder: (context, watch, child) {
                    final GetTotalPriceShipping = watch(CartItemDataProvider);

                    return Row(
                      children: [
                        Text(
                          'Shipping Cost: ',
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          GetTotalPriceShipping.TotalPriceShipping.toString(),
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(
                  height: height * 0.04,
                ),
                Consumer(
                  builder: (context, watch, child) {
                    final GetTotalPrice = watch(CartItemDataProvider);

                    return Row(
                      children: [
                        Text(
                          'Total Amount: ',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          GetTotalPrice.TotalPrice.toString(),
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).textScaleFactor * 18,
                              color: Colors.red,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
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
                  Navigator.pushNamed(context, CheckOut.id);
                },
                child: Text(
                  'PROCEED TO CHECKOUT',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).textScaleFactor * 18,
                  ),
                )),
          ),
        ),
      ]),
    );
  }
}

class TableBuilder extends StatelessWidget {
  List<DataRow> DataRowItem = [];

  Color getColor(Set<MaterialState> states) {
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final CartItemList = watch(CartItemDataProvider);

        DataRowItem = datarowbuilder(CartItemList, context);

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: MaterialStateProperty.resolveWith(getColor),
            columns: [
              DataColumn(
                  label: Text(
                " Product Name ",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).textScaleFactor * 18,
                ),
              )),
              DataColumn(
                  label: Text(
                " Price",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).textScaleFactor * 18,
                ),
              )),
              DataColumn(
                  label: Text(
                " Shipping cost",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).textScaleFactor * 18,
                ),
              )),
              DataColumn(
                  label: Text(
                " Quantity",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).textScaleFactor * 18,
                ),
              )),
            ],
            rows: DataRowItem,
          ),
        );
      },
    );
  }

  List<DataRow> datarowbuilder(
      ShopCartProvider CartItemList, BuildContext context) {
    for (int i = 0; i < CartItemList.GetListProductCartItem.length; i++) {
      // print("test");
      // print(CartItemList.GetListProductCartItem[i].shippingCost);
      // print("test");
      DataRowItem.add(
        DataRow(
          cells: [
            DataCell(
              Text(
                CartItemList.GetListProductCartItem[i].productname,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).textScaleFactor * 16,
                ),
              ),
            ),
            DataCell(
              Text(
                CartItemList.GetListProductCartItem[i].price.toString(),
                style: TextStyle(
                  fontSize: MediaQuery.of(context).textScaleFactor * 16,
                ),
              ),
            ),
            DataCell(
              Text(
                CartItemList.GetListProductCartItem[i].shippingCost.toString(),
                style: TextStyle(
                  fontSize: MediaQuery.of(context).textScaleFactor * 16,
                ),
              ),
            ),
            DataCell(
              Text(
                CartItemList.GetListProductCartItem[i].quantity.toString(),
                style: TextStyle(
                  fontSize: MediaQuery.of(context).textScaleFactor * 16,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return DataRowItem;
  }
}
