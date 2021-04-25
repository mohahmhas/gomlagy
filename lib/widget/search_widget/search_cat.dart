import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomalgy/widget/product_card/product_item_vertical.dart';
import '../../providers/search_provider.dart';
// '/products/search?key=&scope=product&page=1'

class SearchCats extends StatefulWidget {
  @override
  _SearchCatsState createState() => _SearchCatsState();
}

class _SearchCatsState extends State<SearchCats> {
  @override
  ScrollController _scrollController = ScrollController();

  bool firstLoad = true;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (ctx, watch, child) {
      final providerCatData = watch(provider);
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          // _getMoreData();
          providerCatData.fetchAndSetdData('', fromListener: true);
        }
      });
      if (firstLoad) {
        providerCatData.fetchAndSetdData(
          '',
        );
        firstLoad = false;
      }

      return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemBuilder: (ctx, i) => ProductItemVertical(
                  id: providerCatData.items[i].id,
                  name: providerCatData.items[i].name,
                  rating: providerCatData.items[i].rating,
                  image: providerCatData.items[i].thumbnailImage,
                  unitPrice: providerCatData.items[i].unitPrice,
                  unitPrice2: providerCatData.items[i].unitPrice2,
                  unitPrice3: providerCatData.items[i].unitPrice3,
                ),
                itemCount: providerCatData.items.length,
              ),
            ),
          ],
        ),
      );
    });
  }
}
