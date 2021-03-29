import 'package:flutter/material.dart';

class UserNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 130,
      ),
      child: Container(
          padding: EdgeInsets.all(6),
          height: MediaQuery.of(context).size.height - 180,
          child: ListView(
            children: [
              viewListTile('Wishlist',Icons.thumb_up_alt_outlined) ,
              SizedBox(height: 10,) ,
              viewListTile('Purchase History',Icons.receipt_long_rounded) ,
              SizedBox(height: 10,) ,
              viewListTile('My Wallet',Icons.wallet_travel) ,
              SizedBox(height: 10,) ,
              viewListTile('Account Information',Icons.info_outline) ,
              SizedBox(height: 10,) ,
              viewListTile('Warrantly',Icons.person) ,
              SizedBox(height: 10,) ,
              viewListTile("Language",Icons.language_outlined ) ,
              SizedBox(height: 10,) ,
              viewListTile('Join as a trader',Icons.attach_money_outlined ) ,
              SizedBox(height: 10,) ,
              viewListTile('Logout',Icons.logout ) ,

              
            ],
          )),
    );
  }


  Widget viewListTile (String name , IconData icon){

            return  GestureDetector(
              onTap: (){

              },
              child: ListTile(
                  title: Text(name),
                  leading: Icon(icon),
                  trailing: Icon(Icons.arrow_forward_ios)
                ),
            );
  }
}
