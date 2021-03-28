import 'package:flutter/material.dart';
import 'package:gomalgy/widget/home_category_widgets/home_horizental_cats.dart';
import 'package:gomalgy/widget/home_category_widgets/image_slider_first_item.dart';
import 'package:gomalgy/widget/home_category_widgets/product_best_selling.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 130,
      ),
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height - 180,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SliderWidget(),
                  Container(height: 250, child: HomeHorizentalCat())
                ],
              ),
            ),
          )),
    );
  }
}
