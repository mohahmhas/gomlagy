import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 10,
      // width: 10,
      child: RatingBar.builder(
        initialRating: 3,
        minRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: true,
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
      ),
    );
  }
}
