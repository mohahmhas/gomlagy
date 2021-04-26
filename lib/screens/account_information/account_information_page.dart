import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomlgy/helpers/base_url.dart' as baseurl;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gomlgy/providers/account_information.dart';
import 'package:fluttertoast/fluttertoast.dart';

final nameController = TextEditingController();
final emailController = TextEditingController();
final addressController = TextEditingController();
final cityController = TextEditingController();
final postalCodeControlller = TextEditingController();
final countryControlller = TextEditingController();
final phoneControlller = TextEditingController();

/*
class AccountInformationPage extends StatefulWidget {
  @override
  _AccountInformationPageState createState() => _AccountInformationPageState();
}

class _AccountInformationPageState extends State<AccountInformationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read(accountDataProvider).getAccountInformation(UserId: '137');
    context
        .read(accountDataProvider)
        .getAccountInformationAddress(UserId: '137');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text("Account Information"),
        leading: null,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: ShippingAddress(),
      ),
    );
  }

}
*/
class AccountInformationPage extends StatelessWidget {
  static String id = '/accountInformation';

  @override
  Widget build(BuildContext context) {
    context.read(accountDataProvider).getAccountInformation();
    context.read(accountDataProvider).getAccountInformationAddress();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text("Account Information"),
        leading: null,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Profile Information",
              style: TextStyle(
                fontSize: MediaQuery.of(context).textScaleFactor * 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextBuilderProvider(
              type: "Name",
            ),
            SizedBox(
              height: 10,
            ),
            TextBuilderProvider(
              type: "Email",
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                context.read(accountDataProvider).changeAccountInformation(
                      name: nameController.text,
                    );
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2.8,
                height: MediaQuery.of(context).size.height / 15,
                child: Center(
                  child: Text(
                    "Save Changes",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).textScaleFactor * 16,
                    ),
                  ),
                ),
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Shipping Information",
              style: TextStyle(
                fontSize: MediaQuery.of(context).textScaleFactor * 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            AddressWrapBulider(),
            SizedBox(
              height: 20,
            ),
            Center(
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  size: 32,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Center(
                            child: Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height / 1.8,
                          color: Colors.white,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Sipping Information',
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                              .textScaleFactor *
                                          14),
                                ),
                                TextFiledBuilder(
                                  textEditingController: addressController,
                                  Value: addressController.text,
                                  labletext: 'Address',
                                  context: context,
                                ),
                                TextFiledBuilder(
                                  textEditingController: cityController,
                                  Value: cityController.text,
                                  labletext: 'City',
                                  context: context,
                                ),
                                TextFiledBuilder(
                                  textEditingController: postalCodeControlller,
                                  Value: postalCodeControlller.text,
                                  labletext: 'Postal code',
                                  context: context,
                                ),
                                TextFiledBuilder(
                                  textEditingController: countryControlller,
                                  Value: countryControlller.text,
                                  labletext: 'Country',
                                  context: context,
                                ),
                                TextFiledBuilder(
                                  textEditingController: phoneControlller,
                                  Value: phoneControlller.text,
                                  labletext: 'Phone Number',
                                  context: context,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancel")),
                                    TextButton(
                                        onPressed: () async {
                                          print(phoneControlller.text);
                                          if (phoneControlller.text != '' &&
                                              countryControlller.text != '' &&
                                              cityController.text != '' &&
                                              postalCodeControlller.text !=
                                                  '' &&
                                              addressController.text != '') {
                                            await context
                                                .read(accountDataProvider)
                                                .addAddressAccountInformation(
                                                  phone: phoneControlller.text,
                                                  city: cityController.text,
                                                  address:
                                                      addressController.text,
                                                  country:
                                                      countryControlller.text,
                                                  postal_code:
                                                      postalCodeControlller
                                                          .text,
                                                  user_id: '137',
                                                );

                                            phoneControlller.text = '';
                                            countryControlller.text = '';
                                            cityController.text = '';
                                            postalCodeControlller.text = '';
                                            addressController.text = '';

                                            Navigator.pop(context);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "please,Complete all data");
                                          }
                                        },
                                        child: Text(
                                          "Save",
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
/*
ShippingAddress()
class ShippingAddress extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    //          print("add  ${accountInformationData.address[0].address}");
    //        print("code  ${accountInformationData.address[0].postalCode}");

    List<Widget> list = [];
    final accountInformationData = watch(accountDataProvider);
    list = List.from(
      accountInformationData.address.map((e) {
        return Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.addressdetails),
                  Text(e.city),
                  Text(e.postalCode),
                  Text(e.country),
                  Text(e.phone),
                ],
              ),
              PopupMenuButton(
                onSelected: (result) {
                  print("Deleted");
                  print(result);

                  context
                      .read(accountDataProvider)
                      .DeleteaccountInformationAddress(
                          Addressid: e.id.toString());
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem(
                    value: 'result',
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


      ],
    );
  }

}
*/

Widget TextFiledBuilder(
    {String labletext,
    String Value,
    TextEditingController textEditingController,
    BuildContext context}) {
  textEditingController.text = Value;
  // print("val   $Value");

  return Center(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      width: MediaQuery.of(context).size.width / 1.1,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        enabled: labletext == "E-mail" ? false : true,
        //textDirection: TextDirection.rtl,
        onChanged: (value) {
          // textEditingController
          //   ..text = value
          //   ..selection = TextSelection.collapsed(offset: 0);

          textEditingController.text = value;
          textEditingController.selection =
              TextSelection.fromPosition(TextPosition(offset: value.length));
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          focusColor: Theme.of(context).primaryColor,
          labelText: labletext,
          labelStyle: TextStyle(
            fontSize: MediaQuery.of(context).textScaleFactor * 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        controller: textEditingController,
        //textAlign: TextAlign.center,
      ),
    ),
  );
}

class TextBuilderProvider extends StatefulWidget {
  final String type;

  TextBuilderProvider({this.type});

  @override
  _TextBuilderProviderState createState() => _TextBuilderProviderState();
}

class _TextBuilderProviderState extends State<TextBuilderProvider> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final accountInformationData = watch(accountDataProvider);

        if (widget.type == "Email") {
          return TextFiledBuilder(
            labletext: "E-mail",
            Value: accountInformationData.email,
            textEditingController: emailController,
            context: context,
          );
        } else if (widget.type == "Name") {
          return TextFiledBuilder(
            textEditingController: nameController,
            labletext: "Name",
            Value: accountInformationData.name,
            context: context,
            // getBalance(Userid: '137', databack: 'name').toString(),
          );
        }
      },
    );
  }
}

class AddressWrapBulider extends StatefulWidget {
  @override
  _AddressWrapBuliderState createState() => _AddressWrapBuliderState();
}

class _AddressWrapBuliderState extends State<AddressWrapBulider> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        List<Widget> list = [];
        final accountInformationData = watch(accountDataProvider);
        list = List.from(
          accountInformationData.address.map((e) {
            return Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.addressdetails),
                      Text(e.city),
                      Text(e.postalCode),
                      Text(e.country),
                      Text(e.phone),
                    ],
                  ),
                  PopupMenuButton(
                    onSelected: (result) {
                      // print("Deleted");
                      // print(result);
                      setState(() {
                        context
                            .read(accountDataProvider)
                            .DeleteaccountInformationAddress(Addressid: e.id);
                      });
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem(
                        value: 'result',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        );

        return SizedBox(
          child: accountInformationData.address.length > 0
              ? Wrap(
                  children: list,
                )
              : Container(),
        );
      },
    );
  }
}
