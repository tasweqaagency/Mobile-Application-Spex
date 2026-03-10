class PaginationResponseModel<T> {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<T>? items;

  PaginationResponseModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.items,
  });

  PaginationResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    page = json['page'] ?? 1;
    perPage = json['per_page'] ?? 10;
    total = json['count'] ?? 0;
    totalPages = (perPage! > 0) ? (total! / perPage!).ceil() : 0;
    if (json['items'] != null ||
        json['products'] != null ||
        json['categories'] != null) {
      final List rawList =
          (json['items'] ?? json['products'] ?? json['categories']) as List;
      items = rawList
          .map<T>((item) => fromJsonT(item as Map<String, dynamic>))
          .toList();
    }
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (page != null) {
      data['page'] = page;
    }
    if (perPage != null) {
      data['per_page'] = perPage;
    }
    if (total != null) {
      data['count'] = total;
    }
    if (totalPages != null) {
      data['total_pages'] = totalPages;
    }
    if (items != null) {
      data['items'] = items!.map((v) => toJsonT(v)).toList();
    }
    return data;
  }
}

// class PaginationResponseModel<T> {
//   Pagination? pagination;
//   List<T>? items;

//   PaginationResponseModel({this.pagination, this.items});

//   PaginationResponseModel.fromJson(
//     Map<String, dynamic> json,
//     T Function(Map<String, dynamic>) fromJsonT,
//   ) {
//     pagination = json['pagination'] != null
//         ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
//         : null;
//     if (json['items'] != null) {
//       items = (json['items'] as List)
//           .map((item) => fromJsonT(item as Map<String, dynamic>))
//           .toList();
//     }
//   }

//   Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (pagination != null) {
//       data['pagination'] = pagination!.toJson();
//     }
//     if (items != null) {
//       data['items'] = items!.map((v) => toJsonT(v)).toList();
//     }
//     return data;
//   }
// }

// class Pagination {
//   int? page;
//   int? perPage;
//   int? total;
//   int? totalPages;

//   Pagination({this.page, this.perPage, this.total, this.totalPages});

//   Pagination.fromJson(Map<String, dynamic> json) {
//     page = json['page'];
//     perPage = json['per_page'];
//     total = json['total'];
//     totalPages = json['total_pages'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['page'] = page;
//     data['per_page'] = perPage;
//     data['total'] = total;
//     data['total_pages'] = totalPages;
//     return data;
//   }
// }

// class CategoryProductItem {
//   int? id;
//   String? name;
//   String? type;
//   String? price;
//   String? image;

//   CategoryProductItem({this.id, this.name, this.type, this.price, this.image});

//   CategoryProductItem.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     type = json['type'];
//     price = json['price'];
//     image = json['link'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['name'] = name;
//     data['type'] = type;
//     data['price'] = price;
//     data['link'] = image;
//     return data;
//   }
// }
