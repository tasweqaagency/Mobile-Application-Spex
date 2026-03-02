class SearchItemModel {
  String? id;
  String? name;
  String? price;
  String? image;

  SearchItemModel({this.id, this.name, this.price, this.image});

  SearchItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'] is String ? json['image'] : '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    return data;
  }
}