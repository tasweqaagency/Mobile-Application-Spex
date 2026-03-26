import 'package:spex/feature/product_details/model/mini_product_model.dart';

class SearchItemModel {
  String? id;
  String? name;
  String? price;
  String? image;
  List<Variations>? variations;

  SearchItemModel({this.id, this.name, this.price, this.image, this.variations});

  SearchItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'] is String ? json['image'] : '';
    if (json['variations'] != null) {
      variations = <Variations>[];
      json['variations'].forEach((v) {
        variations!.add(Variations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    if (variations != null) {
      data['variations'] = variations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}