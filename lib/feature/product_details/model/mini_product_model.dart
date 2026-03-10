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
  String? permalink;
  String? image;

  MiniProductModel({
    this.id,
    this.sku,
    this.name,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.onSale,
    this.stockStatus,
    this.permalink,
    this.image,
  });

  MiniProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku']?.toString();
    name = json['name']?.toString();
    price = json['price']?.toString();
    regularPrice = json['regular_price']?.toString();
    salePrice = json['sale_price']?.toString();
    onSale = json['on_sale'] is bool
        ? json['on_sale']
        : (json['on_sale'] == 'true' ||
              json['on_sale'] == 1 ||
              json['on_sale'] == "1");
    stockStatus = json['stock_status'] != null
        ? StockStatus.fromString(json['stock_status'].toString()).name
        : null;
    permalink = json['permalink']?.toString();
    image = json['image'] is String ? json['image'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['name'] = this.name;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['on_sale'] = this.onSale;
    data['stock_status'] = this.stockStatus;
    data['permalink'] = this.permalink;
    data['image'] = this.image;
    return data;
  }
}
