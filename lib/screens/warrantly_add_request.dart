import 'package:flutter/material.dart';
import 'package:gomlgy/providers/localization/app_localizations.dart';

class WarrantlyAddRequests extends StatelessWidget {
  String appBarName;
  WarrantlyAddRequests(this.appBarName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarName),
        centerTitle: true,
      ),
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppLocalizations.of(context).translate('send_request'),
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        height: MediaQuery.of(context).size.height * 0.09,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          // controller: serchControll,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20),
                              // prefixIcon: Icon(Icons.search) ,
                              hintText: AppLocalizations.of(context)
                                  .translate('reason'),
                              hintStyle:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                              border: InputBorder.none),
                          onChanged: (value) {},
                        ),
                      ),
                      // SizedBox(height: 20,),
                      Text(
                        AppLocalizations.of(context).translate('my_purchases'),
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Center(child: CircularProgressIndicator()),
                ),
              )
            ],
          )),
      floatingActionButton: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          onPressed: () {},
          label: Text(
            AppLocalizations.of(context).translate('send'),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          elevation: 24.0,
          backgroundColor: Colors.orange[800]
          //Theme.of(context).primaryColor,

          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
