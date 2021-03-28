import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatelessWidget {
  final double itemSize;
  final double initialRating;
  const Rating({Key key, this.itemSize, this.initialRating}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 10,
      //width: 2,
      child: RatingBar.builder(
        initialRating: initialRating,
        minRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: false,
        ignoreGestures: true,
        updateOnDrag: false,
        tapOnlyMode: true,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
          size: 2,
        ),
        onRatingUpdate: (rating) {
          print(rating);
        },
        itemSize: itemSize,
      ),
    );
  }
}
