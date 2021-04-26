import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomlgy/providers/auth.dart';
import 'package:gomlgy/providers/localization/app_localizations.dart';
import 'package:gomlgy/screens/shipping_information.dart';
import 'package:gomlgy/providers/shop_cart_provider.dart';
import 'package:gomlgy/widget/shop_card/shop_cart_items_container.dart';
import 'package:fluttertoast/fluttertoast.dart';

ShopCartProvider _shopCartProvider = new ShopCartProvider();

class ShopCartPage extends StatefulWidget {
  @override
  _ShopCartPageState createState() => _ShopCartPageState();
}

class _ShopCartPageState extends State<ShopCartPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read(CartItemDataProvider).getShopCartItems();
  }

  @override
  Widget build(BuildContext context) {
    final heightsize = MediaQuery.of(context).size.height;
    print("height  $heightsize");
    if (!context.read(authDataProvider).isAuth) {
      return Center(
        child: Text(
          AppLocalizations.of(context).translate('not_authorized'),
          style: TextStyle(
            fontSize: MediaQuery.of(context).textScaleFactor * 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return Consumer(
        builder: (context, watch, child) {
          final TotalDataProvider = watch(CartItemDataProvider);

          if (TotalDataProvider.TotalPrice != 0.0) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    height: (heightsize <= 800)
                        ? (heightsize <= 600)
                            ? MediaQuery.of(context).size.height / 2.3
                            : MediaQuery.of(context).size.height / 1.9
                        : MediaQuery.of(context).size.height / 1.6,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(8),
                      child: CartItemsBuilder(),
                    ),
                  ),
                  TotalContainerBuilder(),
                ],
              ),
            );
          } else {
            return Center(
              child: Container(
                child: Text(
                  "Your Cart is Empty",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).textScaleFactor * 20),
                ),
              ),
            );
          }
        },
      );
    }
  }
}

class TotalContainerBuilder extends StatefulWidget {
  @override
  _TotalContainerBuilderState createState() => _TotalContainerBuilderState();
}

class _TotalContainerBuilderState extends State<TotalContainerBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context).translate('total_amount'),
                style: TextStyle(
                  fontSize: MediaQuery.of(context).textScaleFactor * 16,
                ),
              ),
              Consumer(
                builder: (context, watch, child) {
                  final TotalDataProvider = watch(CartItemDataProvider);

                  return Text(
                    "${TotalDataProvider.TotalPrice} ج.م",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).textScaleFactor * 18,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),
          Consumer(
            builder: (context, watch, child) {
              final TotalDataProvider = watch(CartItemDataProvider);

              return MaterialButton(
                onPressed: () {
                  if (TotalDataProvider.TotalPrice != 0.0) {
                    Navigator.push(
                      (context),
                      MaterialPageRoute(
                        builder: (context) => ShippingInformation(),
                      ),
                    );
                  } else {
                    Fluttertoast.showToast(msg: "Cart is empty");
                  }
                },
                child: Text(
                  AppLocalizations.of(context).translate('proceed_to_checkout'),
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).textScaleFactor * 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CartItemsBuilder extends StatefulWidget {
  @override
  _CartItemsBuilderState createState() => _CartItemsBuilderState();
}

class _CartItemsBuilderState extends State<CartItemsBuilder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read(CartItemDataProvider).getShopCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final ListItemstatues = watch(CartItemDataProvider);
        int numOfItems = 0;
        List<Widget> list = [];
        list = List.from(
          ListItemstatues.GetListProductCartItem.map((e) {
            return ShopCartItemsContainer(
              viration: e.variation ?? " - ",
              image: e.productimage,
              price: e.price,
              cartId: e.id,
              productname: e.productname,
              quantity: e.quantity,
              shippingcost: e.shippingCost,
              index: numOfItems++,
            );
          }),
        );

        return SizedBox(
          child: ListItemstatues.GetListProductCartItem.length > 0
              ? Wrap(
                  children: list,
                )
              : Center(
                  child: Container(
                    child: Text(
                      "Cart is Empty",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              MediaQuery.of(context).textScaleFactor * 20),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
