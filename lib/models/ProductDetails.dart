import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:gomalgy/helpers/http_exception.dart';
import 'package:http/http.dart' as http;

class ProductDetails {
  ProductDetails({
    this.id,
    this.name,
    this.addedBy,
    this.user,
    this.category,
    this.subCategory,
    this.brand,
    this.photos,
    this.thumbnailImage,
    this.tags,
    this.priceLower,
    this.priceHigher,
    this.choiceOptions,
    // this.choiceOptionsName,
    //   this.choiceOptionsnumber,
    this.colors,
    this.variantColors,
    this.todaysDeal,
    this.featured,
    this.currentStock,
    this.unit,
    this.discount,
    this.discountType,
    this.tax,
    this.taxType,
    this.shippingType,
    this.shippingCost,
    this.numberOfSales,
    this.rating,
    this.ratingCount,
    this.description,
    this.unitPrice,
    this.minQuantity1,
    this.maxQuantity1,
    this.unitPrice2,
    this.minQuantity2,
    this.maxQuantity2,
    this.unitPrice3,
    this.minQuantity3,
    this.maxQuantity3,
    this.productStocks,
    this.links,
  });

  final int id;
  final String name;
  final String addedBy;
  final User user;
  final Category category;
  final SubCategory subCategory;
  final Brand brand;
  final List<dynamic> photos;
  final String thumbnailImage;
  final List<dynamic> tags;
  final int priceLower;
  final int priceHigher;
  final List<dynamic> choiceOptions;
  final List<dynamic> colors;
  final List<dynamic> variantColors;
  final int todaysDeal;
  final int featured;
  final int currentStock;
  final String unit;
  final int discount;
  final String discountType;
  final int tax;
  final dynamic taxType;
  final dynamic shippingType;
  final int shippingCost;
  final int numberOfSales;
  final int rating;
  final int ratingCount;
  final dynamic description;
  final int unitPrice;
  final int minQuantity1;
  final int maxQuantity1;
  final int unitPrice2;
  final int minQuantity2;
  final int maxQuantity2;
  final int unitPrice3;
  final int minQuantity3;
  final int maxQuantity3;
  final List<dynamic> productStocks;
  final Map<String, dynamic> links;
}

class Brand {
  Brand({
    this.name,
    this.logo,
    this.links,
  });

  final String name;
  final String logo;
  final BrandLinks links;
}

class BrandLinks {
  BrandLinks({
    this.products,
  });

  final String products;
}

class Category {
  Category({
    this.name,
    this.banner,
    this.icon,
    this.links,
  });

  final String name;
  final String banner;
  final String icon;
  final CategoryLinks links;
}

class CategoryLinks {
  CategoryLinks({
    this.products,
    this.subCategories,
  });

  final String products;
  final String subCategories;
}

class ChoiceOption {
  ChoiceOption({
    this.name,
    this.title,
    this.options,
  });

  final String name;
  final String title;
  final List<String> options;
}

class WelcomeLinks {
  WelcomeLinks({
    this.reviews,
    this.related,
  });

  final String reviews;
  final String related;
}

class ProductStock {
  ProductStock({
    this.id,
    this.productId,
    this.variant,
    this.sku,
    this.price,
    this.qty,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final int productId;
  final String variant;
  final dynamic sku;
  final dynamic price;
  final int qty;
  final DateTime createdAt;
  final DateTime updatedAt;
}

class SubCategory {
  SubCategory({
    this.name,
    this.links,
  });

  final String name;
  final BrandLinks links;
}

class User {
  User({
    this.name,
    this.email,
    this.avatar,
    this.avatarOriginal,
    this.shopName,
    this.shopLogo,
    this.shopLink,
  });

  final String name;
  final String email;
  final dynamic avatar;
  final String avatarOriginal;
  final String shopName;
  final String shopLogo;
  final String shopLink;
}

class VariantColor {
  VariantColor({
    this.color,
    this.name,
  });

  final String color;
  final String name;
}
