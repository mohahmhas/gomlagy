class SeeAllProductsModel {
  List<SeeAllDataModel> data;
  OuterLinks links;
  Meta meta;
  bool success;
  int status;

  SeeAllProductsModel(
      {this.data, this.links, this.meta, this.success, this.status});

  SeeAllProductsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SeeAllDataModel>[];
      json['data'].forEach((v) {
        data.add(new SeeAllDataModel.fromJson(v));
      });
    }
    links = json['links'] != null ? new OuterLinks.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class SeeAllDataModel {
  String name;
  List<String> photos;
  String thumbnailImage;
  int basePrice;
  int baseDiscountedPrice;
  int todaysDeal;
  int featured;
  int unitPrice;
  int unitPrice2;
  int unitPrice3;
  int discount;
  String discountType;
  int rating;
  int sales;
  int shippingCost;
  Links links;

  SeeAllDataModel(
      {this.name,
      this.photos,
      this.thumbnailImage,
      this.basePrice,
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

  SeeAllDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    photos = json['photos'].cast<String>();
    thumbnailImage = json['thumbnail_image'];
    basePrice = json['base_price'];
    baseDiscountedPrice = json['base_discounted_price'];
    todaysDeal = json['todays_deal'];
    featured = json['featured'];
    unitPrice = json['unit_price'];
    unitPrice2 = json['unit_price2'];
    unitPrice3 = json['unit_price3'];
    discount = json['discount'];
    discountType = json['discount_type'];
    rating = json['rating'];
    sales = json['sales'];
    shippingCost = json['shipping_cost'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['photos'] = this.photos;
    data['thumbnail_image'] = this.thumbnailImage;
    data['base_price'] = this.basePrice;
    data['base_discounted_price'] = this.baseDiscountedPrice;
    data['todays_deal'] = this.todaysDeal;
    data['featured'] = this.featured;
    data['unit_price'] = this.unitPrice;
    data['unit_price2'] = this.unitPrice2;
    data['unit_price3'] = this.unitPrice3;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['rating'] = this.rating;
    data['sales'] = this.sales;
    data['shipping_cost'] = this.shippingCost;
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    return data;
  }
}

class Links {
  String details;
  String reviews;
  String related;
  String topFromSeller;

  Links({this.details, this.reviews, this.related, this.topFromSeller});

  Links.fromJson(Map<String, dynamic> json) {
    details = json['details'];
    reviews = json['reviews'];
    related = json['related'];
    topFromSeller = json['top_from_seller'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['details'] = this.details;
    data['reviews'] = this.reviews;
    data['related'] = this.related;
    data['top_from_seller'] = this.topFromSeller;
    return data;
  }
}

class OuterLinks {
  String first;
  String last;
  String prev;
  String next;

  OuterLinks({this.first, this.last, this.prev, this.next});

  OuterLinks.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  String path;
  int perPage;
  int to;
  int total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
