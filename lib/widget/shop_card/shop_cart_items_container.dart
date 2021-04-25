import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomalgy/screens/naviation_bottom/shop_cart_page.dart';
import '../../helpers/base_url.dart' as baseurl;
import 'package:gomalgy/providers/shop_cart_provider.dart';

class ShopCartItemsContainer extends StatelessWidget {
  final String productname;
  final String image;
  final int quantity;
  final String viration;
  final int price;
  final int shippingcost;
  String color;
  String modelname;
  final int index;
  final int cartId;

  ShopCartItemsContainer({
    this.cartId,
    this.index,
    this.viration,
    this.productname,
    this.image,
    this.quantity,
    this.color,
    this.modelname,
    this.price,
    this.shippingcost,
  });

  void splitvarition() {
    if (viration != null) {
      List<String> s1 = viration.split('-');
      color = s1[0];
      modelname = s1[1];
      //  print("New String: ${color}");
      //  print("New String: ${modelname}");
    } else {
      color = '';
      modelname = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final heightsize = MediaQuery.of(context).size.height;
    splitvarition();
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        //print(direction);
        context.read(CartItemDataProvider).DeleteCartItem(Cartid: cartId);
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        height: heightsize <= 600
            ? MediaQuery.of(context).size.height / 4
            : MediaQuery.of(context).size.height / 5,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 3.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(baseurl.Urls.public_api + '/' + image),
                  fit: BoxFit.cover,
                  onError: (o, e) {
                    print(o);
                  },
                )),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    " $productname ",
                    //   textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).textScaleFactor * 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Row(
                    children: [
                      Container(
                        color: Color(int.parse(color)),
                        height: 30,
                        width: 30,
                      ),
                      Text("  "),
                      Text(modelname),
                    ],
                  ),
                  Text(
                    ' $price ج.م',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).textScaleFactor * 16,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "$shippingcostج.م",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).textScaleFactor * 14,
                        ),
                      ),
                      Text(
                        "Shipping Cost",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            changeColumnBulider(
              cartId: cartId,
              index: index,
            ),
          ],
        ),
      ),
    );
  }
}

class changeColumnBulider extends StatefulWidget {
  final int index;
  final int cartId;
  changeColumnBulider({this.index, this.cartId});

  @override
  _changeColumnBuliderState createState() => _changeColumnBuliderState();
}

class _changeColumnBuliderState extends State<changeColumnBulider> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final ListItemstatues = watch(CartItemDataProvider);

        return Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  //    borderRadius: BorderRadius.all(Radius.circular(200)),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        ListItemstatues.EditNumOfquantity(
                          Cart_id: widget.cartId,
                          New_quantity: ++ListItemstatues
                              .GetListProductCartItem[widget.index].quantity,
                        );

                        print(
                            "added is ${ListItemstatues.GetListProductCartItem[widget.index].quantity}");
                      });
                    },
                  ),
                ),
              ),
              Text(
                ListItemstatues.GetListProductCartItem[widget.index].quantity
                    .toString(),
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: MediaQuery.of(context).textScaleFactor * 18),
              ),
              Container(
                width: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        ListItemstatues.EditNumOfquantity(
                          Cart_id: widget.cartId,
                          New_quantity: --ListItemstatues
                              .GetListProductCartItem[widget.index].quantity,
                        );

                        print(
                            "muins is ${ListItemstatues.GetListProductCartItem[widget.index].quantity}");
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
