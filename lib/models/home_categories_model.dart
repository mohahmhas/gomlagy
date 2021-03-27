import 'package:flutter/foundation.dart';

class ImageSlider {
  final String id;
  final String offerimage;
  final String createdat;
  final String updatedat;
  final String offerimagepath;

  ImageSlider({
    @required this.id,
    @required this.offerimage,
    @required this.createdat,
    @required this.updatedat,
    @required this.offerimagepath,
  });
}

class FeaturedProducts {
  final String name;
  final List<String> photos;
  final String thumbnailImage;
  final double basePrice;
  final double baseDiscountedPrice;
  final double todaysDeal;
  final double featured;
  final double unitPrice;
  final double unitPrice2;
  final double unitPrice3;
  final double discount;
  final String discountType;
  final double rating;
  final double sales;
  final double shippingCost;
  final Map<String, String> links;

  FeaturedProducts(
      {@required this.name,
      this.photos,
      this.thumbnailImage,
      @required this.basePrice,
      this.baseDiscountedPrice,
      this.todaysDeal,
      this.featured,
      this.unitPrice,
      this.unitPrice2,
      this.unitPrice3,
      this.discount,
      this.discountType,
      this.rating,
      this.sales,
      this.shippingCost,
      this.links});
}
