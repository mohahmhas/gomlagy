import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomalgy/providers/home_categories.dart' as homeCat;
import 'package:flutter_images_slider/flutter_images_slider.dart';

final imageSlider = ChangeNotifierProvider<homeCat.ImagesSlider>((ref) {
  return homeCat.ImagesSlider();
});

class SliderWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // Listens to the value exposed by counterProvider

    final sliderData = watch(imageSlider);
    //sliderData.fetchAndSetProducts();

    return FutureBuilder(
        future: sliderData.fetchAndSetProducts(),
        builder: (ctx, snaptshot) {
          if (snaptshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          List<String> imgList = [];
          imgList = List.from(snaptshot.data.map((e) {
            print(e.offerimagepath);
            return e.offerimagepath;
          }));

          print(imgList.length);
          print('imgList.length');

          return SliderWidgetView(imgList: imgList);
        });

    // imgList == null || imgList.length == 0
    //     ? CircularProgressIndicator()
    //     : SliderWidgetView(imgList: imgList);
  }
}

class SliderWidgetView extends StatefulWidget {
  const SliderWidgetView({
    this.imgList,
  });

  final List<String> imgList;

  @override
  _SliderWidgetViewState createState() => _SliderWidgetViewState();
}

class _SliderWidgetViewState extends State<SliderWidgetView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    int _current = 0;

    print(widget.imgList.length);
    print('widget.imgList');
    return widget.imgList == null || widget.imgList.length == 0
        ? CircularProgressIndicator()
        : ImagesSlider(
            items: map<Widget>(widget.imgList, (index, i) {
              print('object');
              print(i);
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(i), fit: BoxFit.cover)),
              );
            }),
            autoPlay: true,
            viewportFraction: 1.0,
            aspectRatio: 2.0,
            distortion: false,
            align: IndicatorAlign.bottom,
            indicatorWidth: 5,
            updateCallback: (index) {
              print('ffd');
              setState(() {
                _current = index;
              });
            },
          );
  }
}
