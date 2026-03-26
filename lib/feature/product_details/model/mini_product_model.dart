import 'package:spex/feature/home/model/product_model.dart';

class MiniProductModel {
  int? id;
  String? sku;
  String? name;
  String? price;
  String? regularPrice;
  String? salePrice;
  bool? onSale;
  String? stockStatus;
  bool? inStock;
  String? permalink;
  String? image;
  List<Variations>? variations;
  MiniProductModel({
    this.id,
    this.sku,
    this.name,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.onSale,
    this.stockStatus,
    this.inStock,
    this.permalink,
    this.image,
    this.variations,
  });

  MiniProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] is String ? int.tryParse(json['id']) : json['id'];
    sku = json['sku']?.toString();
    name = json['name']?.toString();
    price = json['price']?.toString();
    regularPrice = json['regular_price']?.toString();
    salePrice = json['sale_price'] == "" || json['sale_price'] == null ? null : json['sale_price']?.toString();
    if (json['variations'] != null) {
      variations = <Variations>[];
      json['variations'].forEach((v) {
        variations!.add(Variations.fromJson(v));
      });
    }
    onSale = json['on_sale'] is bool
        ? json['on_sale']
        : (json['on_sale'] == 'true' ||
            json['on_sale'] == 1 ||
            json['on_sale'] == "1" ||
            (json['sale_price'] != null && json['sale_price'] != ""));
    stockStatus = json['stock_status'] != null
        ? StockStatus.fromString(json['stock_status'].toString()).name
        : (variations != null &&
                variations!.any((v) => v.stockStatus == StockStatus.instock.name)
            ? StockStatus.instock.name
            : null);
    inStock =
        stockStatus != null ? stockStatus == StockStatus.instock.name : null;
    permalink = json['permalink']?.toString();
    image = json['image'] is String ? json['image'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sku'] = sku;
    data['name'] = name;
    data['price'] = price;
    data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    data['on_sale'] = onSale;
    data['stock_status'] = stockStatus;
    // data['inStock'] = inStock;
    data['permalink'] = permalink;
    data['image'] = image;
    if (variations != null) {
      data['variations'] = variations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Variations {
  int? id;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  String? stockStatus;
  bool? inStock;
  String? colorSlug;
  Attributes? attributes;
  String? image;

  Variations(
      {this.id,
      this.sku,
      this.price,
      this.regularPrice,
      this.salePrice,
      this.stockStatus,
      this.inStock,
      this.colorSlug,
      this.attributes,
      this.image});

  Variations.fromJson(Map<String, dynamic> json) {
    id = json['id'] is String ? int.tryParse(json['id']) : json['id'];
    sku = json['sku']?.toString();
    price = json['price']?.toString();
    regularPrice = json['regular_price']?.toString();
    salePrice = json['sale_price']?.toString();
    stockStatus =  json['stock_status'] != null
        ? StockStatus.fromString(json['stock_status'].toString()).name
        : null;
    inStock = stockStatus == StockStatus.instock.name;
    colorSlug = json['color_slug'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
    image = json['image'] is String ? json['image'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['stock_status'] = this.stockStatus;
    // data['inStock'] = this.inStock;
    data['color_slug'] = this.colorSlug;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    data['image'] = this.image;
    return data;
  }
}

class Attributes {
  PaSize? paSize;
  PaSize? paColor;

  Attributes({this.paSize, this.paColor});

  Attributes.fromJson(Map<String, dynamic> json) {
    if (json['pa_size'] != null) {
      if (json['pa_size'] is Map<String, dynamic>) {
        paSize = PaSize.fromJson(json['pa_size']);
      } else {
        paSize = PaSize(label: json['pa_size'].toString(), name: json['pa_size'].toString());
      }
    }
    if (json['pa_color'] != null) {
      if (json['pa_color'] is Map<String, dynamic>) {
        paColor = PaSize.fromJson(json['pa_color']);
      } else {
        paColor = PaSize(label: json['pa_color'].toString(), name: json['pa_color'].toString());
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paSize != null) {
      data['pa_size'] = this.paSize!.toJson();
    }
    if (this.paColor != null) {
      data['pa_color'] = this.paColor!.toJson();
    }
    return data;
  }
}

class PaSize {
  String? label;
  String? name;
  String? hex;
  String? rawValue;

  PaSize({this.label, this.name, this.hex, this.rawValue});

  PaSize.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    name = json['name'];
    hex = json['slug'];
    rawValue = json['raw_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['name'] = this.name;
    data['slug'] = this.hex;
    data['raw_value'] = this.rawValue;
    return data;
  }
}
