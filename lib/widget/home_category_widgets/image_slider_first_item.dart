import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomalgy/providers/home_categories.dart';

final imageSlider = ChangeNotifierProvider<ImagesSlider>((ref) {
  return ImagesSlider();
});

class SliderWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // Listens to the value exposed by counterProvider

    final sliderData = watch(imageSlider);
    sliderData.fetchAndSetProducts();
    return Container(
      child: Center(
        child: Text(sliderData.items[0].offerimagepath),
      ),
    );
  }
}
