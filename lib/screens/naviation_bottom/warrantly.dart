import 'package:flutter/material.dart';
import 'package:gomalgy/screens/warrantly_add_request.dart';
class WarrantlyRequests extends StatelessWidget {
  String appBarName ;
  WarrantlyRequests(this.appBarName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () { 
          Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WarrantlyAddRequests(appBarName)
                  ));
         },
        ),
    );
  }
}