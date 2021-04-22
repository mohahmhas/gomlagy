class ProductCategories {
  List<CategoriesData> data;
  bool success;
  int status;

  ProductCategories({this.data, this.success, this.status});

  ProductCategories.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoriesData>[];
      json['data'].forEach((v) {
        data.add(new CategoriesData.fromJson(v));
      });
    }
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class CategoriesData {
  int id;
  String name;
  String banner;
  String icon;
  CategoriesLinks links;

  CategoriesData({this.id, this.name, this.banner, this.icon, this.links});

  CategoriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    banner = json['banner'];
    icon = json['icon'];
    links = json['links'] != null ? new CategoriesLinks.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['banner'] = this.banner;
    data['icon'] = this.icon;
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    return data;
  }
}

class CategoriesLinks {
  String products;
  String subCategories;

  CategoriesLinks({this.products, this.subCategories});

  CategoriesLinks.fromJson(Map<String, dynamic> json) {
    products = json['products'];
    subCategories = json['sub_categories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products'] = this.products;
    data['sub_categories'] = this.subCategories;
    return data;
  }
}
