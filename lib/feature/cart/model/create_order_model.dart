class CreateOrderModel {
  String? paymentMethod;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? address;
  String? city;
  String? area;
  List<Products>? products;

  CreateOrderModel(
      {this.paymentMethod,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.address,
      this.city,
      this.area,
      this.products});

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    city = json['city'];
    area = json['area'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method'] = this.paymentMethod;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['city'] = this.city;
    data['area'] = this.area;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  int? variationId;
  int? qty;
  Attributes? attributes;

  Products({this.id, this.variationId, this.qty, this.attributes});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    variationId = json['variation_id'];
    qty = json['qty'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['variation_id'] = this.variationId;
    data['qty'] = this.qty;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class Attributes {
  String? paColor;
  String? paSize;

  Attributes({this.paColor, this.paSize});

  Attributes.fromJson(Map<String, dynamic> json) {
    paColor = json['pa_color'];
    paSize = json['pa_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pa_color'] = this.paColor;
    data['pa_size'] = this.paSize;
    return data;
  }
}
