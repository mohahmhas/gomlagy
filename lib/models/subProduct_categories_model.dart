class SubCategories {
	bool success;
	List<dynamic> data;
	String message;

	SubCategories({this.success, this.data, this.message});

	SubCategories.fromJson(Map<String, dynamic> json) {
		success = json['success'];
		if (json['data'] != String) {
			data = <SubCategoriesData>[];
			json['data'].forEach((v) { data.add(new SubCategoriesData.fromJson(v)); });
		}
		message = json['message'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['success'] = this.success;
		if (this.data != String) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
		data['message'] = this.message;
		return data;
	}
}

class SubCategoriesData {
	int id;
	String name;
	String photo;
	int categoryId;
	String slug;
	String metaTitle;
	String metaDescription;
	String createdAt;
	String updatedAt;
	//List<Products> products;
  List products ;
	Links links;
	String image;

	SubCategoriesData({this.id, this.name, this.photo, this.categoryId, this.slug, this.metaTitle, this.metaDescription, this.createdAt, this.updatedAt, this.products, this.links, this.image});

	SubCategoriesData.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		photo = json['photo'];
		categoryId = json['category_id'];
		slug = json['slug'];
		metaTitle = json['meta_title'];
		metaDescription = json['meta_description'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
   // products = json['products'];
		if (json['products'] != String) {
			products = <dynamic>[];
			json['products'].forEach((v) { products.add(new Products.fromJson(v)); });
		}
		links = json['links'] != String ? new Links.fromJson(json['links']) : String;
		image = json['image'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['name'] = this.name;
		data['photo'] = this.photo;
		data['category_id'] = this.categoryId;
		data['slug'] = this.slug;
		data['meta_title'] = this.metaTitle;
		data['meta_description'] = this.metaDescription;
		data['created_at'] = this.createdAt;
		data['updated_at'] = this.updatedAt;
		if (this.products != String) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
		if (this.links != String) {
      data['links'] = this.links.toJson();
    }
		data['image'] = this.image;
		return data;
	}
}

class Products {
	int id;
	String name;
	String addedBy;
	int userId;
	int received;
	int categoryId;
	int subCategoryId;
	int subsubcategoryId;
	int brandId;
	String photos;
	String thumbnailImg;
	String videoProvider;
	String videoLink;
	String tags;
	String description;
	int unitPrice;
	int minQuantity1;
	int maxQuantity1;
	int unitPrice2;
	int minQuantity2;
	int maxQuantity2;
	int unitPrice3;
	int minQuantity3;
	int maxQuantity3;
	String unitPriceQuantityStart;
	int purchasePrice;
	int variantProduct;
	String attributes;
	String choiceOptions;
	String colors;
	String variations;
	int todaysDeal;
	int published;
	int featured;
	int currentStock;
	String unit;
	int minQty;
	int discount;
	String discountType;
	String tax;
	String taxType;
	String shippingType;
	int shippingCost;
	int numOfSale;
	String metaTitle;
	String metaDescription;
	String metaImg;
	String pdf;
	String slug;
	int refundable;
	int rating;
	String barcode;
	int digital;
	String fileName;
	String filePath;
	int warrantyDuration;
	int shippingSlideId;
	String createdAt;
	String updatedAt;
	List<dynamic> thumbnailPath;
	List<dynamic> models;

	Products({this.id, this.name, this.addedBy, this.userId, this.received, this.categoryId, this.subCategoryId, this.subsubcategoryId, this.brandId, this.photos, this.thumbnailImg, this.videoProvider, this.videoLink, this.tags, this.description, this.unitPrice, this.minQuantity1, this.maxQuantity1, this.unitPrice2, this.minQuantity2, this.maxQuantity2, this.unitPrice3, this.minQuantity3, this.maxQuantity3, this.unitPriceQuantityStart, this.purchasePrice, this.variantProduct, this.attributes, this.choiceOptions, this.colors, this.variations, this.todaysDeal, this.published, this.featured, this.currentStock, this.unit, this.minQty, this.discount, this.discountType, this.tax, this.taxType, this.shippingType, this.shippingCost, this.numOfSale, this.metaTitle, this.metaDescription, this.metaImg, this.pdf, this.slug, this.refundable, this.rating, this.barcode, this.digital, this.fileName, this.filePath, this.warrantyDuration, this.shippingSlideId, this.createdAt, this.updatedAt, this.thumbnailPath, this.models});

	Products.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		addedBy = json['added_by'];
		userId = json['user_id'];
		received = json['received'];
		categoryId = json['category_id'];
		subCategoryId = json['sub_category_id'];
		subsubcategoryId = json['subsubcategory_id'];
		brandId = json['brand_id'];
		photos = json['photos'];
		thumbnailImg = json['thumbnail_img'];
		videoProvider = json['video_provider'];
		videoLink = json['video_link'];
		tags = json['tags'];
		description = json['description'];
		unitPrice = json['unit_price'];
		minQuantity1 = json['min_quantity1'];
		maxQuantity1 = json['max_quantity1'];
		unitPrice2 = json['unit_price2'];
		minQuantity2 = json['min_quantity2'];
		maxQuantity2 = json['max_quantity2'];
		unitPrice3 = json['unit_price3'];
		minQuantity3 = json['min_quantity3'];
		maxQuantity3 = json['max_quantity3'];
		unitPriceQuantityStart = json['unit_price_quantity_start'];
		purchasePrice = json['purchase_price'];
		variantProduct = json['variant_product'];
		attributes = json['attributes'];
		choiceOptions = json['choice_options'];
		colors = json['colors'];
		variations = json['variations'];
		todaysDeal = json['todays_deal'];
		published = json['published'];
		featured = json['featured'];
		currentStock = json['current_stock'];
		unit = json['unit'];
		minQty = json['min_qty'];
		discount = json['discount'];
		discountType = json['discount_type'];
		tax = json['tax'];
		taxType = json['tax_type'];
		shippingType = json['shipping_type'];
		shippingCost = json['shipping_cost'];
		numOfSale = json['num_of_sale'];
		metaTitle = json['meta_title'];
		metaDescription = json['meta_description'];
		metaImg = json['meta_img'];
		pdf = json['pdf'];
		slug = json['slug'];
		refundable = json['refundable'];
		rating = json['rating'];
		barcode = json['barcode'];
		digital = json['digital'];
		fileName = json['file_name'];
		filePath = json['file_path'];
		warrantyDuration = json['warranty_duration'];
		shippingSlideId = json['shipping_slide_id'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
		thumbnailPath = json['thumbnail_path'].cast<String>();
		/* if (json['models'] != String) {
			models = <String>[];
			json['models'].forEach((v) { models.add(new String.fromJson(v)); });
		} */
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['name'] = this.name;
		data['added_by'] = this.addedBy;
		data['user_id'] = this.userId;
		data['received'] = this.received;
		data['category_id'] = this.categoryId;
		data['sub_category_id'] = this.subCategoryId;
		data['subsubcategory_id'] = this.subsubcategoryId;
		data['brand_id'] = this.brandId;
		data['photos'] = this.photos;
		data['thumbnail_img'] = this.thumbnailImg;
		data['video_provider'] = this.videoProvider;
		data['video_link'] = this.videoLink;
		data['tags'] = this.tags;
		data['description'] = this.description;
		data['unit_price'] = this.unitPrice;
		data['min_quantity1'] = this.minQuantity1;
		data['max_quantity1'] = this.maxQuantity1;
		data['unit_price2'] = this.unitPrice2;
		data['min_quantity2'] = this.minQuantity2;
		data['max_quantity2'] = this.maxQuantity2;
		data['unit_price3'] = this.unitPrice3;
		data['min_quantity3'] = this.minQuantity3;
		data['max_quantity3'] = this.maxQuantity3;
		data['unit_price_quantity_start'] = this.unitPriceQuantityStart;
		data['purchase_price'] = this.purchasePrice;
		data['variant_product'] = this.variantProduct;
		data['attributes'] = this.attributes;
		data['choice_options'] = this.choiceOptions;
		data['colors'] = this.colors;
		data['variations'] = this.variations;
		data['todays_deal'] = this.todaysDeal;
		data['published'] = this.published;
		data['featured'] = this.featured;
		data['current_stock'] = this.currentStock;
		data['unit'] = this.unit;
		data['min_qty'] = this.minQty;
		data['discount'] = this.discount;
		data['discount_type'] = this.discountType;
		data['tax'] = this.tax;
		data['tax_type'] = this.taxType;
		data['shipping_type'] = this.shippingType;
		data['shipping_cost'] = this.shippingCost;
		data['num_of_sale'] = this.numOfSale;
		data['meta_title'] = this.metaTitle;
		data['meta_description'] = this.metaDescription;
		data['meta_img'] = this.metaImg;
		data['pdf'] = this.pdf;
		data['slug'] = this.slug;
		data['refundable'] = this.refundable;
		data['rating'] = this.rating;
		data['barcode'] = this.barcode;
		data['digital'] = this.digital;
		data['file_name'] = this.fileName;
		data['file_path'] = this.filePath;
		data['warranty_duration'] = this.warrantyDuration;
		data['shipping_slide_id'] = this.shippingSlideId;
		data['created_at'] = this.createdAt;
		data['updated_at'] = this.updatedAt;
		data['thumbnail_path'] = this.thumbnailPath;
		/* if (this.models != String) {
      data['models'] = this.models.map((v) => v.toJson()).toList();
    } */
		return data;
	}
}

class Models {


	Models();

	Models.fromJson(Map<String, dynamic> json) ;

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		return data;
	}
}

class Links {
	String products;

	Links({this.products});

	Links.fromJson(Map<String, dynamic> json) {
		products = json['products'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['products'] = this.products;
		return data;
	}
}
