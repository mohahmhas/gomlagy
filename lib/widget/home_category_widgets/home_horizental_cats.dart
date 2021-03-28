import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomalgy/providers/home_categories.dart' as homeCat;
import 'package:gomalgy/widget/product_card/product_cart_%20horizontal.dart';

final featuredCatData = ChangeNotifierProvider<homeCat.FeaturedCatData>((ref) {
  return homeCat.FeaturedCatData();
});

class HomeHorizentalCat extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // Listens to the value exposed by counterProvider

    final featuredData = watch(featuredCatData);
    //featuredData.fetchAndSetProducts();

    return Column(
      children: [
        Row(
          children: [
            Text(
              'Featured Products',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: Theme.of(context).primaryColor),
            )
          ],
        ),
        FutureBuilder(
            future: featuredData.fetchAndSetFeaturedData(),
            builder: (ctx, snaptshot) {
              if (snaptshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              print(snaptshot.data);

              return Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  //  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),

                  itemCount: snaptshot.data.length,
                  itemBuilder: (ctx, i) => ProductCardHorizental(
                    name: snaptshot.data[i].name,
                    rating: snaptshot.data[i].rating,
                    thumbnailImage: snaptshot.data[i].thumbnailImage,
                    unitPrice: snaptshot.data[i].unitPrice,
                    unitPrice2: snaptshot.data[i].unitPrice2,
                    unitPrice3: snaptshot.data[i].unitPrice3,
                  ),
                ),
              );
            }),
      ],
    );

    // imgList == null || imgList.length == 0
    //     ? CircularProgressIndicator()
    //     : SliderWidgetView(imgList: imgList);
  }
}
