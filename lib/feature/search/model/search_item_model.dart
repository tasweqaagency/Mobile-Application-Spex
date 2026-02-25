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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}