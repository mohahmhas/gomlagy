import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomalgy/widget/product_card/product_item_vertical.dart';

class HomeVerticalCats extends ConsumerWidget {
  final catData;
  final String url;
  HomeVerticalCats({this.catData, this.url});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final providerCatData = watch(catData);

    return FutureBuilder(
        future: providerCatData.fetchAndSetCatdData(url),
        builder: (ctx, snaptshot) {
          if (snaptshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          print(snaptshot.data);
          return Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.26,
            child: ListView.builder(
              itemBuilder: (ctx, i) => ProductItemVertical(
                name: snaptshot.data[i].name,
                rating: snaptshot.data[i].rating,
                image: snaptshot.data[i].thumbnailImage,
                unitPrice: snaptshot.data[i].unitPrice,
                unitPrice2: snaptshot.data[i].unitPrice2,
                unitPrice3: snaptshot.data[i].unitPrice3,
              ),
              itemCount: snaptshot.data.lengthj,
            ),
          );
        });
  }
}
