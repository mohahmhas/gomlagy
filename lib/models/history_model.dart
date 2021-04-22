class HistoryModel {
  String code;
  String date;
  String paymentStatus;
  double grandTotal;
  String address;
  String city;
  String country;
  String payment_type;
  double coupon_discount;
  double shipping_cost;
  double subtotal;
  double tax;
  String link;

  HistoryModel({
    this.code,
    this.date,
    this.paymentStatus,
    this.grandTotal,
    this.address,
    this.city,
    this.country,
    this.payment_type,
    this.coupon_discount,
    this.shipping_cost,
    this.subtotal,
    this.tax,
    this.link,
  });
}

class HistoryDetails {
  final String payment_type;
  final double subtotal;
  final double coupon_discount;
  final double tax;
  final double shipping_cost;
  final String product;
  final double price;
  final int quantity;

  HistoryDetails({
    this.payment_type,
    this.coupon_discount,
    this.price,
    this.product,
    this.shipping_cost,
    this.subtotal,
    this.tax,
    this.quantity,
  });
}
