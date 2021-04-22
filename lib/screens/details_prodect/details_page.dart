import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomalgy/models/ProductDetails.dart';
import 'package:gomalgy/providers/auth.dart';
import 'package:gomalgy/providers/favorite_icon_provider.dart';
import 'package:gomalgy/providers/localization/app_localizations.dart';
import 'package:gomalgy/providers/products.dart';
import 'package:gomalgy/providers/send_data_from_details_page.dart';
import 'package:gomalgy/screens/naviation_bottom/shop_cart_page.dart';
import 'package:gomalgy/screens/outhantication/log_screen.dart';
import 'package:gomalgy/widget/home_category_widgets/home_horizental_cats_grid.dart';
import 'package:gomalgy/widget/home_category_widgets/image_slider_first_item.dart';
import 'package:gomalgy/providers/home_categories.dart' as homeCat;
import 'package:gomalgy/widget/rating.dart';
import 'package:gomalgy/models/ProductDetailsList.dart';
import 'package:fluttertoast/fluttertoast.dart';

////Product Provider instance
final productDataProvider = ChangeNotifierProvider<Products>((ref) {
  return Products();
});
////SliderProvider instance
final imageSlider = ChangeNotifierProvider<homeCat.ImagesSlider>((ref) {
  return homeCat.ImagesSlider();
});

/// List of objects used in add to cart
List<ProductDetailsList> productdetailslist = [];

class initDetailsPage extends ConsumerWidget {
  static String id = 'initDetailsPage';

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    String ProductId = ModalRoute.of(context).settings.arguments;
    // Listens to the value exposed by counterProvider
    final productdata = watch(productDataProvider);
    productdetailslist = [];

    return FutureBuilder(
      future: productdata.fetchAndSetProductData(product_id: ProductId),
      builder: (ctx, snaptshot) {
        if (snaptshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snaptshot.data == null) {
          return Center(
            child: Text(
              AppLocalizations.of(context).translate('nodata'),
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
            ),
          );
        }

        return Details_page(
          productDetails: snaptshot.data,
          productProvider: productdata,
        );
      },
    );
  }
}

class Details_page extends StatefulWidget {
  final ProductDetails productDetails;
  final productProvider;
  const Details_page({Key key, this.productDetails, this.productProvider})
      : super(key: key);

  @override
  _Details_pageState createState() => _Details_pageState();
}

class _Details_pageState extends State<Details_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.productDetails.name,
        ),
        leading: null,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: [
                  SliderWidget(
                    sliderDataProvider: imageSlider,
                    imageList:
                        widget.productDetails.photos.cast<String>().toList(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Main Product name
                      Text(
                        widget.productDetails.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      //Favorite Button Class
                      context.read(authDataProvider).isAuth
                          ? Favorite_list(
                              productDetails: widget.productDetails,
                            )
                          : LoginScreen(),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //Star rate Marker
                      Rating(
                        itemSize: 16.0,
                        initialRating: widget.productDetails.rating.toDouble(),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("\( ${widget.productDetails.rating} \) ")
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Information about Quantity and Price
                      ColumnPrice(
                        price: widget.productDetails.unitPrice,
                        min: widget.productDetails.minQuantity1,
                        max: widget.productDetails.maxQuantity1,
                      ),
                      ColumnPrice(
                        price: widget.productDetails.unitPrice2,
                        min: widget.productDetails.minQuantity2,
                        max: widget.productDetails.maxQuantity2,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Information about Quantity and Price
                      ColumnPrice(
                        price: widget.productDetails.unitPrice3,
                        min: widget.productDetails.minQuantity3,
                        max: widget.productDetails.maxQuantity3,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  quantity_part_selector(),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    AppLocalizations.of(context)
                        .translate('products_you_might_also_like'),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  HomeHorizentalGridCat(productDataProvider,
                      widget.productDetails.links['related'], 4),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)
                        .translate('top_selling_products_from_this_seller'),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                      future: widget.productProvider.fetchTopFromSellingLink(
                          related: widget.productDetails.links['related']),
                      builder: (ctx, snaptshot) {
                        if (snaptshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return HomeHorizentalGridCat(
                            productDataProvider, snaptshot.data, 4);
                      }),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 12,
              color: Theme.of(context).primaryColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                    onPressed: () {
                      // print("length is : ${productdetailslist.length}");
                      // for (int i = 0; i < productdetailslist.length; i++) {
                      //   print(
                      //       "******************************************************************");
                      //   print(
                      //       "The Product name :  ${productdetailslist[i].nameProduct}");
                      //
                      //   print(
                      //       "The Product Model name :  ${productdetailslist[i].namemodel}");
                      //   print(
                      //       "The Product color :  ${productdetailslist[i].color}");
                      //   print(
                      //       "The Product Quantity :  ${productdetailslist[i].numofquantity}");
                      //   print(
                      //       "******************************************************************");
                      // }
                      //
                      if (context.read(authDataProvider).isAuth) {
                        AddtoCartList();
                      } else {
                        Navigator.pushNamed(context, LoginScreen.id);
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('add_to_cart'),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).textScaleFactor * 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (context.read(authDataProvider).isAuth) {
                        AddtoCartList();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShopCartPage()));
                      } else {
                        Navigator.pushNamed(context, LoginScreen.id);
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('buy_now'),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).textScaleFactor * 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void AddtoCartList() async {
    if (productdetailslist.length > 1) {
      for (int i = 0; i < productdetailslist.length; i++) {
        if (productdetailslist[i].numofquantity > 0) {
          if (productdetailslist[i].color != null) {
          } else {
            print("No Color choosed");
            return;
          }
        }
      }
    } else {
      SendDataToCartClass.SendDataToCart(
        quantity: productdetailslist[0].numofquantity,
        variation: null,
      );
      return;
    }

    for (int i = 0; i < productdetailslist.length; i++) {
      if (productdetailslist[i].numofquantity > 0) {
        // print(
        //     "${productdetailslist[i].color.toString()}\-${productdetailslist[i].namemodel}");

        String hexColor = productdetailslist[i].color.toString();
        hexColor = hexColor.substring(6, (hexColor.length - 1));
        // print("Color");
        // print(hexColor);
        // print("Color");
        widget.productDetails.id;
        await SendDataToCartClass.SendDataToCart(
          quantity: productdetailslist[i].numofquantity,
          variation: "${hexColor}-${productdetailslist[i].namemodel}",
        );
      }
    }

    Fluttertoast.showToast(
        msg: AppLocalizations.of(context).translate('add_to_cart'));
  }

/*
  Future<bool> SendDataToCart({
    int quantity,
    String user_id,
    String variation,
  }) async {
    final url = baseurl.Urls.api + '/carts/add';
    //print("Name is:  ${name}");
    // print(url);
    print("Var $variation");
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: Map<String, String>.from({
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjI3MDRlMWYwODIxMDk3ODIyYjMzMDM4NzM0MGE2MDJkNzgxM2RiYWJhMmViZmY1NGIyMDM5NmRlYzg2N2Y4ZTdkZTg0MDNjNzJjZTEyNGE1In0.eyJhdWQiOiIzIiwianRpIjoiMjcwNGUxZjA4MjEwOTc4MjJiMzMwMzg3MzQwYTYwMmQ3ODEzZGJhYmEyZWJmZjU0YjIwMzk2ZGVjODY3ZjhlN2RlODQwM2M3MmNlMTI0YTUiLCJpYXQiOjE2MTc4NzM4MDIsIm5iZiI6MTYxNzg3MzgwMiwiZXhwIjoxNjQ5NDA5ODAyLCJzdWIiOiIxMzciLCJzY29wZXMiOltdfQ.XH6HpOMbSPPogkHHMMYUItf_0T3NactuHLgGQCM7GVUModItAUvj1I8BPBFt3Q3wvNiRwp9xQBHL6TZL9Lq_BSeYTvXt8X2jYbBWHvfeYr3s1486b88f06WFYC7AGP3bXgsxs0zEEholZy20hNMeM4tP29ZR2nnpXIKkIV7JS1aUOqYqLoa3dLfBsQf3KSV9m30CNckLHVwItBZJXynNTcTURAWEDuBoLboqFj1qRcIJvVarSxPisPIKL1S9XkfRYENekMPt3d7uN9AJX7jrE-SoioQ3CPoqxo-ZA88J7MEL2OZjJjXqK6aOEFViN3mBfHSsF4K5gMgRP32q56w8AZ1_907iDGDyq36XeKt_EiAgePsFfLwVVkdn0ZYI8juOM95MadwZHx6EdXbQeX5cHhNerxS61ot-mCeGrIKCFJ-9aGuQz3WIU4FH5-hzqVIxE2BfPcQZ8pj3HyPlGj7zd0puN5ybXjYdI_A4gCQu9M7aTSsa3jWXllALIAQGnRSLggfSkL5CwkiIOWQRG2p_81Z-gA-USoLwG206sFNlo9uoIG31l3dWVXPAiwrIhjGCnyg-XFBFO8H_a8iqUgADQq4IjspcZzIlLKIKDdxKD0p3GDrg77UnudbcW8-2PBGSIxhvkF6gu0VC80pjR4kxXMjPwfAQcSBH01jrSe3F_eo',
        }),
        body: json.encode(
          {
            'user_id': user_id,
            'id': widget.productDetails.id,
            'quantity': quantity,
            'variant': variation,
          },
        ),
      );
//      print("ResADDresssss : ${response.body} ");
      final responseData = json.decode(response.body);
      //    print("ResponseDataUpdate   $responseData ");
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (response.statusCode >= 400) {
        throw HttpException('An Error occurred!');
      }

      print("Send Successfully to cart");
      return true;
    } catch (e) {
      print("E  " + e);
      throw e;
    }
  }
*/
  Widget quantity_part_selector() {
    if (widget.productDetails.choiceOptions.length > 0) {
      return quantity_partMultiRow(
        productDetails: widget.productDetails,
      );
    } else {
      return quantity_partSingleRow(productDetails: widget.productDetails);
    }
  }

  Widget ColumnPrice({int price, int min, int max}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "$price E.G",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Text(
          "$min - $max piece",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

//////
}

class quantity_partMultiRow extends StatefulWidget {
  final ProductDetails productDetails;

  const quantity_partMultiRow({this.productDetails});

  @override
  _quantity_partMultiRowState createState() => _quantity_partMultiRowState();
}

class _quantity_partMultiRowState extends State<quantity_partMultiRow> {
  String price = '0';
  List<DataRow> myDataRowBuilder = [];
  List<TextEditingController> mycontroller = [];
  int choiceOptionsnumber;
  List choiceOptionsName = [];
  bool flag = true;
  int rowSelected = 0;
  bool rowSelectedmark = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    choiceOptionsnumber =
        int.parse(widget.productDetails.choiceOptions[0]["name"]);
    choiceOptionsName = widget.productDetails.choiceOptions[0]["options"];
    //  print("Show");
    // print(choiceOptionsnumber);
    for (int i = 0; i < choiceOptionsnumber; i++) {
      final testcontroller = TextEditingController();
      testcontroller.text = '0';
      mycontroller.add(testcontroller);

      ProductDetailsList obj = new ProductDetailsList(
          nameProduct: widget.productDetails.name,
          productid: widget.productDetails.id.toString(),
          userid: '137');
      productdetailslist.add(obj);
    }

    myDataRowBuilder = datarowbuilder();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(
              label:
                  Text(' ' + AppLocalizations.of(context).translate('color'))),
          DataColumn(
              label:
                  Text(' ' + AppLocalizations.of(context).translate('model'))),
          DataColumn(
              label: Text(' ' +
                  AppLocalizations.of(context).translate('quantity') +
                  "                     " +
                  AppLocalizations.of(context).translate('price'))),
          //    DataColumn(label: Text(" Price")),
        ],
        rows: myDataRowBuilder,
      ),
    );
  }

  List<DataRow> datarowbuilder() {
    if (widget.productDetails.choiceOptions != null) {
      for (int i = 0; i < choiceOptionsnumber; i++) {
        productdetailslist[i].namemodel = choiceOptionsName[i];
        myDataRowBuilder.add(
          DataRow(
            cells: [
              DataCell(
                Color(i),
              ),
              DataCell(
                Text(choiceOptionsName[i]),
              ),
              DataCell(
                QuantityAndPriceButtom(
                  productDetails: widget.productDetails,
                  NumOFIndex: i,
                  mycontroller: mycontroller[i],
                  price: price,
                ),
                /*  Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.add),
                      key: ValueKey(i),
                      onPressed: () {
                        setState(() {
                          mycontroller[i].text =
                              (int.parse(mycontroller[i].text) + 1).toString();

                          print(widget.productDetails.minQuantity2);
                          if ((int.parse(mycontroller[i].text) <=
                              widget.productDetails.maxQuantity1) &&
                              (int.parse(mycontroller[i].text) > 0)) {
                            price = (int.parse(mycontroller[i].text.toString()) *
                                widget.productDetails.unitPrice)
                                .toString();
                          } else if ((int.parse(mycontroller[i].text) <=
                              widget.productDetails.maxQuantity2) &&
                              (int.parse(mycontroller[i].text) >=
                                  widget.productDetails.minQuantity2)) {
                            price = (int.parse(mycontroller[i].text.toString()) *
                                widget.productDetails.unitPrice2)
                                .toString();
                          } else if (int.parse(mycontroller[i].text) >=
                              widget.productDetails.minQuantity3) {
                            price = (int.parse(mycontroller[i].text.toString()) *
                                widget.productDetails.unitPrice3)
                                .toString();
                          }
                          print(price);
                          rowSelected = i;
                        });
                      },
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      child: TextField(
                        controller: mycontroller[i],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (int.parse(mycontroller[i].text) > 0) {
                          mycontroller[i].text =
                              (int.parse(mycontroller[i].text) - 1).toString();
                        }

                        /*   price = (int.parse(testcontroller.text.toString()) *
                              widget.productDetails.unitPrice)
                          .toString();
                      */
                        if ((int.parse(mycontroller[i].text) <=
                            widget.productDetails.maxQuantity1) &&
                            (int.parse(mycontroller[i].text) > 0)) {
                          price = (int.parse(mycontroller[i].text.toString()) *
                              widget.productDetails.unitPrice)
                              .toString();
                        } else if ((int.parse(mycontroller[i].text) <=
                            widget.productDetails.maxQuantity2) &&
                            (int.parse(mycontroller[i].text) >
                                widget.productDetails.minQuantity2)) {
                          price = (int.parse(mycontroller[i].text.toString()) *
                              widget.productDetails.unitPrice2)
                              .toString();
                        } else if (int.parse(mycontroller[i].text) >
                            widget.productDetails.minQuantity3) {
                          price = (int.parse(mycontroller[i].text.toString()) *
                              widget.productDetails.unitPrice3)
                              .toString();
                        }
                        rowSelected = i;

                        print(price);
                      },
                    ),
                  ],
                ),*/
              ),
              /*   DataCell(
                Text(price),
              ),*/
            ],
          ),
        );
      }
      /* myDataRowBuilder[rowSelected] = DataRow(
        cells: [
          DataCell(
            Color(),
          ),
          DataCell(
            Text(choiceOptionsName[rowSelected]),
          ),
          DataCell(
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      print(rowSelected);
                      mycontroller[rowSelected].text =
                          (int.parse(mycontroller[rowSelected].text) + 1)
                              .toString();

                      if ((int.parse(mycontroller[rowSelected].text) <=
                              widget.productDetails.maxQuantity1) &&
                          (int.parse(mycontroller[rowSelected].text) > 0)) {
                        price = (int.parse(
                                    mycontroller[rowSelected].text.toString()) *
                                widget.productDetails.unitPrice)
                            .toString();
                      } else if ((int.parse(mycontroller[rowSelected].text) <=
                              widget.productDetails.maxQuantity2) &&
                          (int.parse(mycontroller[rowSelected].text) >=
                              widget.productDetails.minQuantity2)) {
                        price = (int.parse(
                                    mycontroller[rowSelected].text.toString()) *
                                widget.productDetails.unitPrice2)
                            .toString();
                      } else if (int.parse(mycontroller[rowSelected].text) >=
                          widget.productDetails.minQuantity3) {
                        price = (int.parse(
                                    mycontroller[rowSelected].text.toString()) *
                                widget.productDetails.unitPrice3)
                            .toString();
                      }
                      print(price);
                    });
                  },
                ),
                Container(
                  height: 40,
                  width: 40,
                  child: TextField(
                    controller: mycontroller[rowSelected],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    print(rowSelected);

                    if (int.parse(mycontroller[rowSelected].text) > 0) {
                      mycontroller[rowSelected].text =
                          (int.parse(mycontroller[rowSelected].text) - 1)
                              .toString();
                    }
                    /*   price = (int.parse(testcontroller.text.toString()) *
                              widget.productDetails.unitPrice)
                          .toString();
                      */
                    if ((int.parse(mycontroller[rowSelected].text) <=
                            widget.productDetails.maxQuantity1) &&
                        (int.parse(mycontroller[rowSelected].text) > 0)) {
                      price = (int.parse(
                                  mycontroller[rowSelected].text.toString()) *
                              widget.productDetails.unitPrice)
                          .toString();
                    } else if ((int.parse(mycontroller[rowSelected].text) <=
                            widget.productDetails.maxQuantity2) &&
                        (int.parse(mycontroller[rowSelected].text) >
                            widget.productDetails.minQuantity2)) {
                      price = (int.parse(
                                  mycontroller[rowSelected].text.toString()) *
                              widget.productDetails.unitPrice2)
                          .toString();
                    } else if (int.parse(mycontroller[rowSelected].text) >
                        widget.productDetails.minQuantity3) {
                      price = (int.parse(
                                  mycontroller[rowSelected].text.toString()) *
                              widget.productDetails.unitPrice3)
                          .toString();
                    }

                    print(price);
                  },
                ),
              ],
            ),
          ),
          DataCell(
            Text(price),
          ),
        ],
      );*/
    }

    return myDataRowBuilder;

    /*  return DataRow(
      cells: [
        DataCell(
          Color(),
        ),
        DataCell(
          Text(modelname),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  mycontroller.text =
                      (int.parse(mycontroller.text) + 1).toString();

                  price = (int.parse(mycontroller.text.toString()) *
                          widget.productDetails.unitPrice)
                      .toString();
                  print(price);
                },
              ),
              Container(
                height: 40,
                width: 40,
                child: TextField(
                  controller: mycontroller,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                ),
              ),
              IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (int.parse(mycontroller.text) > 0) {
                      mycontroller.text =
                          (int.parse(mycontroller.text) - 1).toString();
                    }

                    price = (int.parse(mycontroller.text.toString()) *
                            widget.productDetails.unitPrice)
                        .toString();
                  }),
            ],
          ),
        ),
        DataCell(
          Text(price),
        ),
      ],
    );    */
  }

  Widget Color(int indexlist) {
    return Container(
      child: DropDown(
        indexlist: indexlist,
        productcolor: widget.productDetails.colors.cast<String>().toList(),
      ),
    );
  }
}

class QuantityAndPriceButtom extends StatefulWidget {
  final ProductDetails productDetails;
  final int NumOFIndex;
  String price;
  var mycontroller = TextEditingController();

  QuantityAndPriceButtom(
      {this.productDetails, this.NumOFIndex, this.mycontroller, this.price});

  @override
  _QuantityAndPriceButtomState createState() => _QuantityAndPriceButtomState();
}

class _QuantityAndPriceButtomState extends State<QuantityAndPriceButtom> {
  @override
  Widget build(BuildContext context) {
    productdetailslist[widget.NumOFIndex].numofquantity =
        int.parse(widget.mycontroller.text);
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              widget.mycontroller.text =
                  (int.parse(widget.mycontroller.text) + 1).toString();

              NewValueOfPrice();

              print(widget.price);
            });
          },
        ),
        Container(
          height: 40,
          width: 40,
          child: TextField(
            onChanged: (value) {
              setState(() {
                NewValueOfPrice();
              });
            },
            controller: widget.mycontroller,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
        ),
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (int.parse(widget.mycontroller.text) > 0) {
                widget.mycontroller.text =
                    (int.parse(widget.mycontroller.text) - 1).toString();
              }

              /*   price = (int.parse(testcontroller.text.toString()) *
                              widget.productDetails.unitPrice)
                          .toString();
                      */
              NewValueOfPrice();
              print(widget.price);
            });
          },
        ),
        SizedBox(
          width: 20,
        ),
        Text(widget.price),
      ],
    );
  }

  void NewValueOfPrice() {
    if ((int.parse(widget.mycontroller.text) <=
            widget.productDetails.maxQuantity1) &&
        (int.parse(widget.mycontroller.text) > 0)) {
      widget.price = (int.parse(widget.mycontroller.text.toString()) *
              widget.productDetails.unitPrice)
          .toString();
    } else if ((int.parse(widget.mycontroller.text) <=
            widget.productDetails.maxQuantity2) &&
        (int.parse(widget.mycontroller.text) >
            widget.productDetails.minQuantity2)) {
      widget.price = (int.parse(widget.mycontroller.text.toString()) *
              widget.productDetails.unitPrice2)
          .toString();
    } else if (int.parse(widget.mycontroller.text) >
        widget.productDetails.minQuantity3) {
      widget.price = (int.parse(widget.mycontroller.text.toString()) *
              widget.productDetails.unitPrice3)
          .toString();
    }
    if (int.parse(widget.mycontroller.text) == 0) {
      widget.price = "0";
    }
  }
}

class quantity_partSingleRow extends StatefulWidget {
  final ProductDetails productDetails;
  const quantity_partSingleRow({this.productDetails});

  @override
  _quantity_part_selectorState createState() => _quantity_part_selectorState();
}

class _quantity_part_selectorState extends State<quantity_partSingleRow> {
  ProductDetailsList obj = new ProductDetailsList();
  final testcontroller = TextEditingController();
  String price = '0';

  void NewValueOfPrice() {
    if ((int.parse(testcontroller.text) <=
            widget.productDetails.maxQuantity1) &&
        (int.parse(testcontroller.text) > 0)) {
      price = (int.parse(testcontroller.text.toString()) *
              widget.productDetails.unitPrice)
          .toString();
    } else if ((int.parse(testcontroller.text) <=
            widget.productDetails.maxQuantity2) &&
        (int.parse(testcontroller.text) > widget.productDetails.minQuantity2)) {
      price = (int.parse(testcontroller.text.toString()) *
              widget.productDetails.unitPrice2)
          .toString();
    } else if (int.parse(testcontroller.text) >
        widget.productDetails.minQuantity3) {
      price = (int.parse(testcontroller.text.toString()) *
              widget.productDetails.unitPrice3)
          .toString();
    }
    if (int.parse(testcontroller.text) == 0) {
      price = "0";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    testcontroller.text = '0';
    obj.nameProduct = widget.productDetails.name;
    productdetailslist.add(obj);
  }

  @override
  Widget build(BuildContext context) {
    obj.numofquantity = int.parse(testcontroller.text);
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            AppLocalizations.of(context).translate('total'),
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w900, fontSize: 18),
          ),
          Text(
            "$price",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    testcontroller.text =
                        (int.parse(testcontroller.text) + 1).toString();

                    NewValueOfPrice();
                    print(price);

                    /*   price = (int.parse(testcontroller.text.toString()) *
                            widget.productDetails.unitPrice)
                        .toString();

                    // print(widget.productDetails.minQuantity2);
                    // if ((int.parse(testcontroller.text) <=
                    //         widget.productDetails.maxQuantity1) &&
                    //     (int.parse(testcontroller.text) > 0)) {
                    //   price = (int.parse(testcontroller.text.toString()) *
                    //           widget.productDetails.unitPrice)
                    //       .toString();
                    // } else if ((int.parse(testcontroller.text) <=
                    //         widget.productDetails.maxQuantity2) &&
                    //     (int.parse(testcontroller.text) >=
                    //         widget.productDetails.minQuantity2)) {
                    //   price = (int.parse(testcontroller.text.toString()) *
                    //           widget.productDetails.unitPrice2)
                    //       .toString();
                    // } else if (int.parse(testcontroller.text) >=
                    //     widget.productDetails.minQuantity3) {
                    //   price = (int.parse(testcontroller.text.toString()) *
                    //           widget.productDetails.unitPrice3)
                    //       .toString();
*/
                  });
                },
              ),
              Container(
                height: 40,
                width: 40,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      NewValueOfPrice();
                    });
                  },
                  controller: testcontroller,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                ),
              ),
              IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (int.parse(testcontroller.text) > 0) {
                        testcontroller.text =
                            (int.parse(testcontroller.text) - 1).toString();
                      }
                      NewValueOfPrice();
                      print(price);
                      /*   price = (int.parse(testcontroller.text.toString()) *
                              widget.productDetails.unitPrice)
                          .toString();

                      // if ((int.parse(testcontroller.text) <=
                      //         widget.productDetails.maxQuantity1) &&
                      //     (int.parse(testcontroller.text) > 0)) {
                      //   price = (int.parse(testcontroller.text.toString()) *
                      //           widget.productDetails.unitPrice)
                      //       .toString();
                      // } else if ((int.parse(testcontroller.text) <=
                      //         widget.productDetails.maxQuantity2) &&
                      //     (int.parse(testcontroller.text) >
                      //         widget.productDetails.minQuantity2)) {
                      //   price = (int.parse(testcontroller.text.toString()) *
                      //           widget.productDetails.unitPrice2)
                      //       .toString();
                      // } else if (int.parse(testcontroller.text) >
                      //     widget.productDetails.minQuantity3) {
                      //   price = (int.parse(testcontroller.text.toString()) *
                      //           widget.productDetails.unitPrice3)
                      //       .toString();
                      // }
*/
                    });
                  }),
            ],
          ),
        ],
      ),
    );
  }
}

class Favorite_list extends StatefulWidget {
  final ProductDetails productDetails;

  const Favorite_list({this.productDetails});

  @override
  _Favorite_listState createState() => _Favorite_listState();
}

class _Favorite_listState extends State<Favorite_list> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read(favDataProvider).checkproductfavorite(ProductId: '141');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final fav_statues = watch(favDataProvider);

        return IconButton(
            icon: Icon(
              fav_statues.iconstatues ? Icons.favorite : Icons.favorite_border,
              color: fav_statues.iconstatues ? Colors.red : Colors.grey,
              size: 30,
            ),
            onPressed: () {
              print(widget.productDetails.id.toString());
              fav_statues.changeStateIcon(ProductId: '141');
            });
      },
    );
  }
}

class DropDown extends StatefulWidget {
  List<String> productcolor;
  int indexlist;
  DropDown({this.productcolor, this.indexlist});

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  var select_Color;
  var choisedColor;
  int itemcounter = -1;
  @override
  Widget build(BuildContext context) {
    changeColorform();

    List<DropdownMenuItem<dynamic>> dropdownList =
        widget.productcolor.map((element) {
      if ((itemcounter + 1) != widget.productcolor.length) {
        itemcounter++;
      } else {
        itemcounter = 0;
      }
      return DropdownMenuItem(
        value: Color(int.parse(widget.productcolor[itemcounter])),
        child: Container(
          width: 30,
          height: 30,
          color: Color(int.parse(widget.productcolor[itemcounter])),
        ),
      );
    }).toList();

    return Container(
      child: DropdownButton(
        value: select_Color,
        onChanged: (d) {
          setState(() {
            print(d);
            select_Color = d;
            productdetailslist[widget.indexlist].color = select_Color;
          });
        },
        items: dropdownList,
      ),
    );
  }

  void changeColorform() {
    for (int i = 0; i < widget.productcolor.length; i++) {
      widget.productcolor[i] = widget.productcolor[i].replaceAll('#', '0xff');
    }
  }
}

// class Calculate {
//   static void Calculatefun() {}
// }
