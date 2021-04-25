import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomalgy/helpers/base_url.dart';
import 'package:gomalgy/models/see_all_model.dart';
import 'package:gomalgy/providers/api/product_api.dart';
import 'package:gomalgy/providers/home_categories.dart' as homeCat;
import 'package:gomalgy/widget/home_category_widgets/image_slider_first_item.dart';
import 'package:gomalgy/widget/product_card/product_cart_%20horizontal.dart';
import 'package:gomalgy/widget/product_card/product_cart_%20vertical.dart';

class SeeAllProducts extends StatefulWidget {
  final appBarName;
  final url;
  SeeAllProducts({this.appBarName, this.url});
  @override
  _SeeAllProductsState createState() => _SeeAllProductsState();
}

class _SeeAllProductsState extends State<SeeAllProducts> {
  final imageSlider = ChangeNotifierProvider<homeCat.ImagesSlider>((ref) {
    return homeCat.ImagesSlider();
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.appBarName),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SliderWidget(
              sliderDataProvider: imageSlider,
              url: '/offers',
            ),
            Container(
              child: FutureBuilder<List<SeeAllDataModel>>(
                future: CategoriesApi.SeeAllProducts(widget.url),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<Widget> list = [];
                    list = List.from(snapshot.data.take(20).map((e) {
                      return Container(
                        margin: EdgeInsets.only(left: 30, top: 20),
                        child: ProductCardvertical(
                          id: e.id,
                          name: e.name,
                          thumbnailImage: e.thumbnailImage,
                          rating: double.parse(e.rating.toString()),
                          unitPrice: double.parse(e.unitPrice2.toString()),
                          unitPrice2: double.parse(e.unitPrice2.toString()),
                          unitPrice3: double.parse(e.unitPrice2.toString()),
                        ),
                      );
                    }));

                    return Wrap(
                      direction: Axis.horizontal,
                      crossAxisAlignment: WrapCrossAlignment.start,

                      alignment: WrapAlignment.start,

                      //textDirection: TextDirection.rtl,
                      runAlignment: WrapAlignment.start,
                      runSpacing: 3.0,
                      spacing: 5.0,

                      //runSpacing: 10,
                      //                     spacing: 8.0,
                      children: list,
                    );
                  } // end if
                  else {
                    return Center(
                      child: Container(),
                      //CircularProgressIndicator(),
                    );
                  } // end else ;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
