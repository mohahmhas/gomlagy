import 'package:flutter/material.dart';
import 'package:gomalgy/screens/payment/checkout.dart';

class CustomPaymentWidget extends StatefulWidget {
  String image;
  String text;
  final checked;
  Function ststate;
  PaymentWays id;
  CustomPaymentWidget(
      {this.image, this.text, this.checked, this.id, this.ststate});

  @override
  CustomPaymentWidget_State createState() => CustomPaymentWidget_State();
}

class CustomPaymentWidget_State extends State<CustomPaymentWidget> {
  bool checkMe = false;
  void _checkmy(bool value) {
    setState(() {
      widget.checked.forEach((k, v) => widget.checked[k] = false);

      widget.checked[widget.id] = value;
      widget.ststate();
      print(widget.checked);

      //  checkMe = widget.checked[widget.id];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      //  color: Colors.grey.withOpacity(0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 100,
            height: MediaQuery.of(context).size.height * 0.16,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                widget.image,
                // baseurl.Urls.public_api + '/' + thumbnailImage,
              ),
              fit: BoxFit.fill,
              onError: (o, e) {
                print(o);
              },
            )),
          ),
          Text(
            widget.text,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Checkbox(value: widget.checked[widget.id], onChanged: _checkmy),
        ],
      ),
    );
  }
}
