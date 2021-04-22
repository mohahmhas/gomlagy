class CartItem {
  CartItem({
    this.id,
    this.productname,
    this.productimage,
    this.variation,
    this.price,
    this.tax,
    this.shippingCost,
    this.shippingSlide,
    this.quantity,
    this.date,
  });

  final int id;
  final String productname;
  final String productimage;
  final String variation;
  final int price;
  final int tax;
  final int shippingCost;
  final int shippingSlide;
  int quantity;
  final String date;
}
