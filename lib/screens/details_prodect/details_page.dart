import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomalgy/widget/home_category_widgets/image_slider_first_item.dart';
import 'dart:io';

import 'package:flutter/material.dart';

class Details_page extends StatefulWidget {
  @override
  _Details_pageState createState() => _Details_pageState();
}

class _Details_pageState extends State<Details_page> {
  String ProdectName = "Prodect name";
  bool Fav_Flag = false;

  final String Modelname = "ss";
  int quantityNumber;
  final mycontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mycontroller.text = '0';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ProdectName,
        ),
        leading: null,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                /*   SliderWidget(
                  imageList: [],
                ),*/
                Row(
                  children: [
                    Text(
                      ProdectName,
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Fav_Flag ? Colors.red : Colors.white,
                        ),
                        onPressed: () {
                          Fav_Flag != Fav_Flag;
                        }),
                  ],
                ),
                /*  Row(
                  children: [],
                ),*/
                Row(
                  children: [
                    ColumnPrice(),
                    ColumnPrice(),
                  ],
                ),
                Row(
                  children: [
                    ColumnPrice(),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text("Color")),
                      DataColumn(label: Text("Model")),
                      DataColumn(label: Text("Quantity")),
                      DataColumn(label: Text("Price")),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(
                            Color(),
                          ),
                          DataCell(
                            Text(Modelname),
                          ),

                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    mycontroller.text =
                                        (int.parse(mycontroller.text) + 1)
                                            .toString();
                                  },
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  child: TextField(
                                    controller: mycontroller,
                                    // onChanged: (value) {
                                    //   quantityNumber = int.parse(value);
                                    // },
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(

                                        //hintText: quantityNumber.toString(),
                                        ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      if (int.parse(mycontroller.text) > 0) {
                                        mycontroller.text =
                                            (int.parse(mycontroller.text) - 1)
                                                .toString();
                                      }
                                    }),
                              ],
                            ),
                          ),

                          //price
                          DataCell(
                            Text("Price"),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Color(),
                          ),
                          DataCell(
                            Text(Modelname),
                          ),

                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    mycontroller.text =
                                        (int.parse(mycontroller.text) + 1)
                                            .toString();
                                  },
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  child: TextField(
                                    controller: mycontroller,
                                    // onChanged: (value) {
                                    //   quantityNumber = int.parse(value);
                                    // },
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(

                                        //hintText: quantityNumber.toString(),
                                        ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      if (int.parse(mycontroller.text) > 0) {
                                        mycontroller.text =
                                            (int.parse(mycontroller.text) - 1)
                                                .toString();
                                      }
                                    }),
                              ],
                            ),
                          ),

                          //price
                          DataCell(
                            Text("Price"),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Color(),
                          ),
                          DataCell(
                            Text(Modelname),
                          ),

                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    mycontroller.text =
                                        (int.parse(mycontroller.text) + 1)
                                            .toString();
                                  },
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  child: TextField(
                                    controller: mycontroller,
                                    // onChanged: (value) {
                                    //   quantityNumber = int.parse(value);
                                    // },
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(

                                        //hintText: quantityNumber.toString(),
                                        ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      if (int.parse(mycontroller.text) > 0) {
                                        mycontroller.text =
                                            (int.parse(mycontroller.text) - 1)
                                                .toString();
                                      }
                                    }),
                              ],
                            ),
                          ),

                          //price
                          DataCell(
                            Text("Price"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  "Products you might also like",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 14,
              color: Theme.of(context).primaryColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                    onPressed: () {},
                    child: Flexible(
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Flexible(
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
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

  Widget Color() {
    return Container(
      child: DropDown(),
    );
  }

  Widget ColumnPrice() {
    return Column(
      children: [
        Text(
          "20 E.G",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
        ),
        Text(
          "1 - 20 piece",
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  Widget RowCo() {
    int quantityNumber;
    final mycontroller = TextEditingController();
    mycontroller.text = '0';
    /* Widget QuantityRow() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                mycontroller.text =
                    (int.parse(mycontroller.text) + 1).toString();
              }),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 50,
            width: 50,
            child: TextField(
              controller: mycontroller,
              // onChanged: (value) {
              //   quantityNumber = int.parse(value);
              // },
              textAlign: TextAlign.center,
              decoration: InputDecoration(

                  //hintText: quantityNumber.toString(),
                  ),
              keyboardType: TextInputType.number,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                if (int.parse(mycontroller.text) > 0) {
                  mycontroller.text =
                      (int.parse(mycontroller.text) - 1).toString();
                }
              }),
        ),
        SizedBox(
          width: 5,
        ),
      ],
    );
  }*/

    return Row(
      children: [
        Expanded(flex: 1, child: Color()),
        SizedBox(
          width: 8,
        ),
        Expanded(flex: 1, child: Text(Modelname)),
        Expanded(
          flex: 1,
          child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                mycontroller.text =
                    (int.parse(mycontroller.text) + 1).toString();
              }),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 50,
            width: 50,
            child: TextField(
              controller: mycontroller,
              // onChanged: (value) {
              //   quantityNumber = int.parse(value);
              // },
              textAlign: TextAlign.center,
              decoration: InputDecoration(

                  //hintText: quantityNumber.toString(),
                  ),
              keyboardType: TextInputType.number,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                if (int.parse(mycontroller.text) > 0) {
                  mycontroller.text =
                      (int.parse(mycontroller.text) - 1).toString();
                }
              }),
        ),
        Expanded(flex: 2, child: Text("Price")),
        //  Expanded(flex: 1, child: QuantityRow()),
      ],
    );
  }
}

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  List<String> listOfColors = ['red', 'green', 'black'];

  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.black,
    Colors.white,
    Colors.grey,
    Colors.pink
  ];
  var select_Color;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<dynamic>> dropdownList = listOfColors.map((element) {
      return DropdownMenuItem(
        value: findColor(element),
        child: Container(width: 30, height: 30, color: findColor(element)),
      );
    }).toList();
    return Container(
      child: DropdownButton(
        value: select_Color,
//        style: TextStyle(color: select_Color == null ? null : select_Color),
        onChanged: (d) {
          setState(() {
            print(d);
            select_Color = d;
          });
        },
        items: dropdownList,
      ),
    );
  }

  Color findColor(String color) {
    switch (color) {
      case 'red':
        {
          return Colors.red;
        }
      case 'black':
        {
          return Colors.black;
        }
        break;
      case 'green':
        {
          return Colors.green;
        }
        break;
      default:
        {
          //statements;
        }
        break;
    }
  }
}
