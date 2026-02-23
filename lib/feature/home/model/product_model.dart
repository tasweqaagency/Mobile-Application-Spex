import 'dart:ui';

enum ProductStatus {
  publish,
  draft,
  pending,
  private,
  future,
  trash,
  any;

  static ProductStatus fromString(String value) {
    return ProductStatus.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => ProductStatus.publish,
    );
  }
}

enum ProductType {
  simple,
  grouped,
  external,
  variable;

  static ProductType fromString(String value) {
    return ProductType.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => ProductType.simple,
    );
  }
}

enum CatalogVisibility {
  visible,
  catalog,
  search,
  hidden;

  static CatalogVisibility fromString(String value) {
    return CatalogVisibility.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => CatalogVisibility.visible,
    );
  }
}

enum StockStatus {
  instock,
  outofstock,
  onbackorder;

  static StockStatus fromString(String value) {
    return StockStatus.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => StockStatus.instock,
    );
  }
}

enum TaxStatus {
  taxable,
  shipping,
  none;

  static TaxStatus fromString(String value) {
    return TaxStatus.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => TaxStatus.taxable,
    );
  }
}

enum BackorderStatus {
  no,
  yes,
  notify;

  static BackorderStatus fromString(String value) {
    return BackorderStatus.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => BackorderStatus.no,
    );
  }
}

class ProductModel {
  final int id;
  final String name;
  final String slug;
  final String permalink;
  final DateTime? dateCreated;
  final DateTime? dateModified;
  final ProductType type;
  final ProductStatus status;
  final bool featured;
  final CatalogVisibility catalogVisibility;
  final String description;
  final String shortDescription;
  final String sku;
  final String price;
  final String regularPrice;
  final String salePrice;
  final bool onSale;
  final bool purchasable;
  final int totalSales;
  final bool virtual;
  final bool downloadable;
  final String externalUrl;
  final String buttonText;
  final String taxStatusRaw; // Keep raw for compatibility if needed
  final TaxStatus taxStatus;
  final bool manageStock;
  final int? stockQuantity;
  final BackorderStatus backorders;
  final int? lowStockAmount;
  final String weight;
  final ProductDimension dimensions;
  final bool shippingRequired;
  final bool reviewsAllowed;
  final String averageRating;
  final int ratingCount;
  final List<ProductCategory> categories;
  final List<ProductBrand> brands;
  final List<ProductImage> images;
  final List<ProductMetaData> metaData;
  final StockStatus stockStatus;
  final String priceHtml;
  final List<int> relatedIds;
  final Map<String, String> translations;
  final String lang;
  final List<ProductAttribute> attributes;
  final List<int> variations;
  final List<dynamic> defaultAttributes;
  final List<int> groupedProducts;
  final List<ProductTag> tags;
  final List<int> upsellIds;
  final List<int> crossSellIds;
  final String yoastHead;
  final Map<String, dynamic> yoastHeadJson;
  final bool hasOptions;
  final String postPassword;
  final String globalUniqueId;
  final PaAttribute? paColor;
  final PaAttribute? paSize;

  // UI fields for compatibility
  final bool isHot;
  final bool isNew;
  final bool isFavorite;
  final List<Color> _colors;

  ProductModel({
    required this.id,
    required this.name,
    this.slug = '',
    this.permalink = '',
    this.dateCreated,
    this.dateModified,
    this.type = ProductType.simple,
    this.status = ProductStatus.publish,
    this.featured = false,
    this.catalogVisibility = CatalogVisibility.visible,
    required this.description,
    this.shortDescription = '',
    this.sku = '',
    dynamic price = '',
    String regularPrice = '',
    this.salePrice = '',
    this.onSale = false,
    this.purchasable = false,
    this.totalSales = 0,
    this.virtual = false,
    this.downloadable = false,
    this.externalUrl = '',
    this.buttonText = '',
    this.taxStatus = TaxStatus.taxable,
    this.taxStatusRaw = 'taxable',
    this.manageStock = false,
    this.stockQuantity,
    this.backorders = BackorderStatus.no,
    this.lowStockAmount,
    this.weight = '',
    this.dimensions = const ProductDimension(length: '', width: '', height: ''),
    this.shippingRequired = true,
    this.reviewsAllowed = true,
    dynamic rating = '0.00',
    this.ratingCount = 0,
    List<ProductCategory> categories = const [],
    this.brands = const [],
    List<ProductImage> images = const [],
    this.metaData = const [],
    StockStatus stockStatus = StockStatus.instock,
    this.priceHtml = '',
    this.relatedIds = const [],
    this.translations = const {},
    this.lang = 'en',
    this.attributes = const [],
    this.variations = const [],
    this.defaultAttributes = const [],
    this.groupedProducts = const [],
    this.tags = const [],
    this.upsellIds = const [],
    this.crossSellIds = const [],
    this.yoastHead = '',
    this.yoastHeadJson = const {},
    this.hasOptions = false,
    this.postPassword = '',
    this.globalUniqueId = '',
    this.paColor,
    this.paSize,
    this.isHot = false,
    this.isNew = false,
    this.isFavorite = false,
    List<Color> colors = const [],
    // Legacy support
    String? category,
    List<String>? imagePath,
    bool? inStock,
    dynamic oldPrice,
  }) : price = price?.toString() ?? '',
       averageRating = rating?.toString() ?? '0.00',
       categories = categories.isNotEmpty
           ? categories
           : (category != null
                 ? [ProductCategory(id: 0, name: category, slug: '')]
                 : []),
       images = images.isNotEmpty
           ? images
           : (imagePath != null
                 ? imagePath
                       .map(
                         (path) =>
                             ProductImage(id: 0, src: path, name: '', alt: ''),
                       )
                       .toList()
                 : []),
       stockStatus = inStock != null
           ? (inStock ? StockStatus.instock : StockStatus.outofstock)
           : stockStatus,
       regularPrice = oldPrice?.toString() ?? regularPrice,
       _colors = colors;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      permalink: json['permalink'] ?? '',
      dateCreated: json['date_created'] != null
          ? DateTime.tryParse(json['date_created'])
          : null,
      dateModified: json['date_modified'] != null
          ? DateTime.tryParse(json['date_modified'])
          : null,
      type: ProductType.fromString(json['type'] ?? ''),
      status: ProductStatus.fromString(json['status'] ?? ''),
      featured: json['featured'] ?? false,
      catalogVisibility: CatalogVisibility.fromString(
        json['catalog_visibility'] ?? '',
      ),
      description: json['description'] ?? '',
      shortDescription: json['short_description'] ?? '',
      sku: json['sku'] ?? '',
      price: json['price'],
      regularPrice: json['regular_price']?.toString() ?? '',
      salePrice: json['sale_price']?.toString() ?? '',
      onSale: json['on_sale'] ?? false,
      purchasable: json['purchasable'] ?? false,
      totalSales: json['total_sales'] ?? 0,
      virtual: json['virtual'] ?? false,
      downloadable: json['downloadable'] ?? false,
      externalUrl: json['external_url'] ?? '',
      buttonText: json['button_text'] ?? '',
      taxStatus: TaxStatus.fromString(json['tax_status'] ?? ''),
      taxStatusRaw: json['tax_status'] ?? '',
      manageStock: json['manage_stock'] ?? false,
      stockQuantity: json['stock_quantity'],
      backorders: BackorderStatus.fromString(json['backorders'] ?? ''),
      lowStockAmount: json['low_stock_amount'],
      weight: json['weight'] ?? '',
      dimensions: ProductDimension.fromJson(json['dimensions'] ?? {}),
      shippingRequired: json['shipping_required'] ?? false,
      reviewsAllowed: json['reviews_allowed'] ?? false,
      rating: json['average_rating'],
      ratingCount: json['rating_count'] ?? 0,
      categories:
          (json['categories'] as List?)
              ?.map((e) => ProductCategory.fromJson(e))
              .toList() ??
          [],
      brands:
          (json['brands'] as List?)
              ?.map((e) => ProductBrand.fromJson(e))
              .toList() ??
          [],
      images:
          (json['images'] as List?)
              ?.map((e) => ProductImage.fromJson(e))
              .toList() ??
          [],
      metaData:
          (json['meta_data'] as List?)
              ?.map((e) => ProductMetaData.fromJson(e))
              .toList() ??
          [],
      stockStatus: StockStatus.fromString(json['stock_status'] ?? ''),
      priceHtml: json['price_html'] ?? '',
      relatedIds: (json['related_ids'] as List?)?.cast<int>() ?? [],
      translations:
          (json['translations'] as Map?)?.cast<String, String>() ?? {},
      lang: json['lang'] ?? '',
      attributes:
          (json['attributes'] as List?)
              ?.map((e) => ProductAttribute.fromJson(e))
              .toList() ??
          [],
      variations: (json['variations'] as List?)?.cast<int>() ?? [],
      defaultAttributes: json['default_attributes'] ?? [],
      groupedProducts: (json['grouped_products'] as List?)?.cast<int>() ?? [],
      tags:
          (json['tags'] as List?)
              ?.map((e) => ProductTag.fromJson(e))
              .toList() ??
          [],
      upsellIds: (json['upsell_ids'] as List?)?.cast<int>() ?? [],
      crossSellIds: (json['cross_sell_ids'] as List?)?.cast<int>() ?? [],
      yoastHead: json['yoast_head'] ?? '',
      yoastHeadJson: json['yoast_head_json'] ?? {},
      hasOptions: json['has_options'] ?? false,
      postPassword: json['post_password'] ?? '',
      globalUniqueId: json['global_unique_id'] ?? '',
      paColor: json['pa_color'] != null
          ? PaAttribute.fromJson(json['pa_color'])
          : null,
      paSize: json['pa_size'] != null
          ? PaAttribute.fromJson(json['pa_size'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'permalink': permalink,
      'date_created': dateCreated?.toIso8601String(),
      'date_modified': dateModified?.toIso8601String(),
      'type': type.name,
      'status': status.name,
      'featured': featured,
      'catalog_visibility': catalogVisibility.name,
      'description': description,
      'short_description': shortDescription,
      'sku': sku,
      'price': price,
      'regular_price': regularPrice,
      'sale_price': salePrice,
      'on_sale': onSale,
      'purchasable': purchasable,
      'total_sales': totalSales,
      'virtual': virtual,
      'downloadable': downloadable,
      'external_url': externalUrl,
      'button_text': buttonText,
      'tax_status': taxStatus.name,
      'manage_stock': manageStock,
      'stock_quantity': stockQuantity,
      'backorders': backorders.name,
      'low_stock_amount': lowStockAmount,
      'weight': weight,
      'dimensions': dimensions.toJson(),
      'shipping_required': shippingRequired,
      'reviews_allowed': reviewsAllowed,
      'average_rating': averageRating,
      'rating_count': ratingCount,
      'categories': categories.map((e) => e.toJson()).toList(),
      'brands': brands.map((e) => e.toJson()).toList(),
      'images': images.map((e) => e.toJson()).toList(),
      'meta_data': metaData.map((e) => e.toJson()).toList(),
      'stock_status': stockStatus.name,
      'price_html': priceHtml,
      'related_ids': relatedIds,
      'translations': translations,
      'lang': lang,
      'attributes': attributes.map((e) => e.toJson()).toList(),
      'variations': variations,
      'default_attributes': defaultAttributes,
      'grouped_products': groupedProducts,
      'tags': tags.map((e) => e.toJson()).toList(),
      'upsell_ids': upsellIds,
      'cross_sell_ids': crossSellIds,
      'yoast_head': yoastHead,
      'yoast_head_json': yoastHeadJson,
      'has_options': hasOptions,
      'post_password': postPassword,
      'global_unique_id': globalUniqueId,
      if (paColor != null) 'pa_color': paColor?.toJson(),
      if (paSize != null) 'pa_size': paSize?.toJson(),
    };
  }

  // Compatibility getters for existing UI
  String get category => categories.isNotEmpty ? categories.first.name : '';
  List<String> get imagePath => images.map((e) => e.src).toList();
  double get rating => double.tryParse(averageRating) ?? 0.0;
  double get priceDouble => double.tryParse(price) ?? 0.0;
  double? get oldPrice => double.tryParse(regularPrice);
  bool get inStock => stockStatus == StockStatus.instock;
  bool get isVisible => catalogVisibility == CatalogVisibility.visible;

  // Attribute extraction getters
  List<String> get availableColors {
    if (paColor != null) {
      return paColor!.values.map((e) => e.value).toList();
    }
    return _getOptionsByName(['color', 'اللون']);
  }

  List<String> get availableSizes {
    if (paSize != null) {
      return paSize!.values.map((e) => e.value).toList();
    }
    return _getOptionsByName(['size', 'المقاس', 'الحجم']);
  }

  List<String> _getOptionsByName(List<String> names) {
    try {
      final attr = attributes.firstWhere(
        (a) => names.any(
          (name) => a.name.toLowerCase().contains(name.toLowerCase()),
        ),
      );
      return attr.options;
    } catch (_) {
      return [];
    }
  }

  // Compatibility getter updated to use attributes if available
  List<Color> get colors {
    if (_colors.isNotEmpty) return _colors;

    if (paColor != null && paColor!.values.isNotEmpty) {
      return paColor!.values.map((e) {
        if (e.hex != null && e.hex!.isNotEmpty) {
          String hexStr = e.hex!.replaceAll('#', '');
          if (hexStr.length == 6) {
            hexStr = 'FF$hexStr';
          }
          return Color(int.parse(hexStr, radix: 16));
        }
        return _mapStringToColor(e.value);
      }).toList();
    }

    // Map attribute color names to Flutter Color objects
    return availableColors
        .map((colorName) => _mapStringToColor(colorName))
        .toList();
  }

  // Extracted lists from metadata
  List<int> get fbtProducts {
    try {
      final meta = metaData.firstWhere(
        (m) => m.key == 'woodmart_fbt_bundles_id',
      );
      if (meta.value is List) {
        return (meta.value as List)
            .where((e) => e != null && e.toString().isNotEmpty)
            .map((e) => int.tryParse(e.toString()) ?? 0)
            .where((id) => id > 0)
            .toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  List<int> get giftProducts {
    try {
      final meta = metaData.firstWhere((m) => m.key == '_gift_product_ids');
      if (meta.value is List) {
        return (meta.value as List)
            .map((e) => int.tryParse(e.toString()) ?? 0)
            .where((id) => id > 0)
            .toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Color _mapStringToColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
      case 'احمر':
      case 'أحمر':
        return const Color(0xFFFF0000);
      case 'blue':
      case 'ازرق':
      case 'أزرق':
        return const Color(0xFF0000FF);
      case 'green':
      case 'اخضر':
      case 'أخضر':
        return const Color(0xFF00FF00);
      case 'black':
      case 'اسود':
      case 'أسود':
        return const Color(0xFF000000);
      case 'white':
      case 'ابيض':
      case 'أبيض':
        return const Color(0xFFFFFFFF);
      case 'yellow':
      case 'اصفر':
      case 'أصفر':
        return const Color(0xFFFFFF00);
      case 'grey':
      case 'gray':
      case 'رمادي':
        return const Color(0xFF808080);
      case 'orange':
      case 'برتقالي':
        return const Color(0xFFFFA500);
      case 'pink':
      case 'وردي':
        return const Color(0xFFFFC0CB);
      case 'purple':
      case 'بنفسجي':
        return const Color(0xFF800080);
      default:
        return const Color(0x00000000); // Transparent or default
    }
  }

  ProductModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? permalink,
    DateTime? dateCreated,
    DateTime? dateModified,
    ProductType? type,
    ProductStatus? status,
    bool? featured,
    CatalogVisibility? catalogVisibility,
    String? description,
    String? shortDescription,
    String? sku,
    String? price,
    String? regularPrice,
    String? salePrice,
    bool? onSale,
    bool? purchasable,
    int? totalSales,
    bool? virtual,
    bool? downloadable,
    String? externalUrl,
    String? buttonText,
    TaxStatus? taxStatus,
    String? taxStatusRaw,
    bool? manageStock,
    int? stockQuantity,
    BackorderStatus? backorders,
    int? lowStockAmount,
    String? weight,
    ProductDimension? dimensions,
    bool? shippingRequired,
    bool? reviewsAllowed,
    String? averageRating,
    int? ratingCount,
    List<ProductCategory>? categories,
    List<ProductBrand>? brands,
    List<ProductImage>? images,
    List<ProductMetaData>? metaData,
    StockStatus? stockStatus,
    String? priceHtml,
    List<int>? relatedIds,
    Map<String, String>? translations,
    String? lang,
    List<ProductAttribute>? attributes,
    List<int>? variations,
    List<dynamic>? defaultAttributes,
    List<int>? groupedProducts,
    List<ProductTag>? tags,
    List<int>? upsellIds,
    List<int>? crossSellIds,
    String? yoastHead,
    Map<String, dynamic>? yoastHeadJson,
    bool? hasOptions,
    String? postPassword,
    String? globalUniqueId,
    PaAttribute? paColor,
    PaAttribute? paSize,
    bool? isHot,
    bool? isNew,
    bool? isFavorite,
    List<Color>? colors,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      permalink: permalink ?? this.permalink,
      dateCreated: dateCreated ?? this.dateCreated,
      dateModified: dateModified ?? this.dateModified,
      type: type ?? this.type,
      status: status ?? this.status,
      featured: featured ?? this.featured,
      catalogVisibility: catalogVisibility ?? this.catalogVisibility,
      description: description ?? this.description,
      shortDescription: shortDescription ?? this.shortDescription,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      regularPrice: regularPrice ?? this.regularPrice,
      salePrice: salePrice ?? this.salePrice,
      onSale: onSale ?? this.onSale,
      purchasable: purchasable ?? this.purchasable,
      totalSales: totalSales ?? this.totalSales,
      virtual: virtual ?? this.virtual,
      downloadable: downloadable ?? this.downloadable,
      externalUrl: externalUrl ?? this.externalUrl,
      buttonText: buttonText ?? this.buttonText,
      taxStatus: taxStatus ?? this.taxStatus,
      taxStatusRaw: taxStatusRaw ?? this.taxStatusRaw,
      manageStock: manageStock ?? this.manageStock,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      backorders: backorders ?? this.backorders,
      lowStockAmount: lowStockAmount ?? this.lowStockAmount,
      weight: weight ?? this.weight,
      dimensions: dimensions ?? this.dimensions,
      shippingRequired: shippingRequired ?? this.shippingRequired,
      reviewsAllowed: reviewsAllowed ?? this.reviewsAllowed,
      rating: averageRating ?? this.averageRating,
      ratingCount: ratingCount ?? this.ratingCount,
      categories: categories ?? this.categories,
      brands: brands ?? this.brands,
      images: images ?? this.images,
      metaData: metaData ?? this.metaData,
      stockStatus: stockStatus ?? this.stockStatus,
      priceHtml: priceHtml ?? this.priceHtml,
      relatedIds: relatedIds ?? this.relatedIds,
      translations: translations ?? this.translations,
      lang: lang ?? this.lang,
      attributes: attributes ?? this.attributes,
      variations: variations ?? this.variations,
      defaultAttributes: defaultAttributes ?? this.defaultAttributes,
      groupedProducts: groupedProducts ?? this.groupedProducts,
      tags: tags ?? this.tags,
      upsellIds: upsellIds ?? this.upsellIds,
      crossSellIds: crossSellIds ?? this.crossSellIds,
      yoastHead: yoastHead ?? this.yoastHead,
      yoastHeadJson: yoastHeadJson ?? this.yoastHeadJson,
      hasOptions: hasOptions ?? this.hasOptions,
      postPassword: postPassword ?? this.postPassword,
      globalUniqueId: globalUniqueId ?? this.globalUniqueId,
      paColor: paColor ?? this.paColor,
      paSize: paSize ?? this.paSize,
      isHot: isHot ?? this.isHot,
      isNew: isNew ?? this.isNew,
      isFavorite: isFavorite ?? this.isFavorite,
      colors: colors ?? this.colors,
    );
  }
}

class ProductAttribute {
  final int id;
  final String name;
  final String slug;
  final int position;
  final bool visible;
  final bool variation;
  final List<String> options;

  const ProductAttribute({
    required this.id,
    required this.name,
    required this.slug,
    required this.position,
    required this.visible,
    required this.variation,
    required this.options,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) {
    return ProductAttribute(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      position: json['position'] ?? 0,
      visible: json['visible'] ?? false,
      variation: json['variation'] ?? false,
      options: (json['options'] as List?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'position': position,
      'visible': visible,
      'variation': variation,
      'options': options,
    };
  }
}

class ProductTag {
  final int id;
  final String name;
  final String slug;

  const ProductTag({required this.id, required this.name, required this.slug});

  factory ProductTag.fromJson(Map<String, dynamic> json) {
    return ProductTag(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'slug': slug};
  }
}

class ProductDimension {
  final String length;
  final String width;
  final String height;

  const ProductDimension({
    required this.length,
    required this.width,
    required this.height,
  });

  factory ProductDimension.fromJson(Map<String, dynamic> json) {
    return ProductDimension(
      length: json['length'] ?? '',
      width: json['width'] ?? '',
      height: json['height'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'length': length, 'width': width, 'height': height};
  }
}

class ProductCategory {
  final int id;
  final String name;
  final String slug;

  const ProductCategory({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'slug': slug};
  }
}

class ProductBrand {
  final int id;
  final String name;
  final String slug;

  const ProductBrand({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory ProductBrand.fromJson(Map<String, dynamic> json) {
    return ProductBrand(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'slug': slug};
  }
}

class ProductImage {
  final int id;
  final String src;
  final String name;
  final String alt;

  const ProductImage({
    required this.id,
    required this.src,
    required this.name,
    required this.alt,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'] ?? 0,
      src: json['src'] ?? '',
      name: json['name'] ?? '',
      alt: json['alt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'src': src, 'name': name, 'alt': alt};
  }
}

class ProductMetaData {
  final int id;
  final String key;
  final dynamic value;

  ProductMetaData({required this.id, required this.key, required this.value});

  factory ProductMetaData.fromJson(Map<String, dynamic> json) {
    return ProductMetaData(
      id: json['id'] ?? 0,
      key: json['key'] ?? '',
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'key': key, 'value': value};
  }
}

class PaAttribute {
  final String name;
  final List<PaAttributeValue> values;

  const PaAttribute({required this.name, required this.values});

  factory PaAttribute.fromJson(Map<String, dynamic> json) {
    return PaAttribute(
      name: json['name'] ?? '',
      values:
          (json['values'] as List?)
              ?.map((e) => PaAttributeValue.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'values': values.map((e) => e.toJson()).toList()};
  }
}

class PaAttributeValue {
  final String value;
  final String? hex;

  const PaAttributeValue({required this.value, this.hex});

  factory PaAttributeValue.fromJson(Map<String, dynamic> json) {
    return PaAttributeValue(
      value: json['value']?.toString() ?? '',
      hex: json['hex'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{'value': value};
    if (hex != null) {
      data['hex'] = hex;
    }
    return data;
  }
}

class SimplifiedProductModel {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String shortDescription;
  final String price;
  final String regularPrice;
  final String salePrice;
  final String image;
  final List<String> galleryImages;
  final double rating;
  final int ratingCount;
  final String category;
  final String brand;
  final bool inStock;
  final bool isFavorite;
  final bool isSale;
  final List<Color> colors;
  final List<String> availableSizes;
  final String productUrl;
  final List<int> fbtProducts;
  final List<int> giftProducts;

  SimplifiedProductModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.shortDescription,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.image,
    required this.galleryImages,
    required this.rating,
    required this.ratingCount,
    required this.category,
    required this.brand,
    required this.inStock,
    required this.isFavorite,
    required this.isSale,
    required this.colors,
    required this.availableSizes,
    required this.productUrl,
    required this.fbtProducts,
    required this.giftProducts,
  });
}

extension ProductModelExtension on ProductModel {
  SimplifiedProductModel toSimplified() {
    return SimplifiedProductModel(
      id: id,
      name: name,
      slug: slug,
      description: description,
      shortDescription: shortDescription,
      price: price,
      regularPrice: regularPrice,
      salePrice: salePrice,
      image: images.isNotEmpty ? images.first.src : '',
      galleryImages: images.map((e) => e.src).toList(),
      rating: rating,
      ratingCount: ratingCount,
      category: category,
      brand: brands.isNotEmpty ? brands.first.name : '',
      inStock: inStock,
      isFavorite: isFavorite,
      isSale: salePrice.isNotEmpty,
      colors: colors,
      availableSizes: availableSizes,
      productUrl: permalink,
      fbtProducts: fbtProducts,
      giftProducts: giftProducts,
    );
  }
}
