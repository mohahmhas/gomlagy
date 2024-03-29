import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carousel_slider/carousel_slider.dart';
import '../../helpers/base_url.dart' as baseurl;

class SliderWidget extends ConsumerWidget {
  final sliderDataProvider;
  final String url;
  final List imageList;
  final String arrayKey;
  SliderWidget(
      {this.sliderDataProvider, this.url, this.imageList, this.arrayKey = ''});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // Listens to the value exposed by counterProvider
    final sliderData = watch(sliderDataProvider);
    Future Check() async {
      if (url != null) {
        return arrayKey == ''
            ? await sliderData.fetchAndSetSliderData(sliderUrl: url)
            : sliderData.items[arrayKey];
      }
      return imageList;
    }

    return FutureBuilder(
        future: Check(),
        builder: (ctx, snaptshot) {
          if (snaptshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          List<String> imgList = [];
          imgList = List.from(snaptshot.data.map((e) {
            //  print(e.offerimagepath);
            if (url == null) {
              return baseurl.Urls.public_api + '/' + e;
            }
            return e.offerimagepath;
          }));

          // print(imgList.length);
          // print('imgList.length');

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

    // print(widget.imgList.length);
    // print('widget.imgList');
    return widget.imgList == null || widget.imgList.length == 0
        ? CircularProgressIndicator()
        : Column(children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                //   height: MediaQuery.of(context).size.height * 0.20,
                autoPlay: true,
                enlargeCenterPage: false,
              ),
              items: map<Widget>(widget.imgList, (index, i) {
                // print('object');
                // print(i);
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 0.20),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(i), fit: BoxFit.fill)),
                      // child: Text(
                      //   'text $i',
                      //   style: TextStyle(fontSize: 16.0),
                      // ),
                    );
                  },
                );
              }).toList(),
            ),
          ]);

    /*ImagesSlider(
            items: map<Widget>(widget.imgList, (index, i) {
              print('object');
              print(i);
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(i), fit: BoxFit.cover)),
              );
            }),
            // autoPlay: true,
            // viewportFraction: 1.0,
            // aspectRatio: 2.0,
            // distortion: false,
            align: IndicatorAlign.bottom,
            indicatorWidth: 5,
            updateCallback: (index) {
              print('ffd');
              setState(() {
                _current = index;
              });
            },
          );*/
  }
}
