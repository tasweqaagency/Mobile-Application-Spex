import 'package:flutter/material.dart';
import 'package:spex/feature/home/model/promo_banner_model.dart';
import 'category_model.dart';
import 'product_model.dart';

class HomeMockData {
  static List<PromoBannerItem> banners = [
    PromoBannerItem(
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=1000&auto=format&fit=crop',
      title: 'New Google Pixel 7',
      subtitle: 'Shop great deals on MacBook, iPad, iPhone and more.',
    ),
    PromoBannerItem(
      imageUrl:
          'https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea?q=80&w=1000&auto=format&fit=crop',
      title: 'Premium Headphones',
      subtitle: 'Experience crystal clear sound with our latest collection.',
    ),
    PromoBannerItem(
      imageUrl:
          'https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=1000&auto=format&fit=crop',
      title: 'Gaming Laptops',
      subtitle: 'Unleash your gaming potential with powerful hardware.',
    ),
  ];

  static List<CategoryModel> categories = [
    CategoryModel(
      id: 1,
      name: 'Headsets',
      imagePath:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=1000&auto=format&fit=crop',
      productCount: 1,
    ),
    CategoryModel(
      id: 2,
      name: 'Motherboards',
      imagePath:
          'https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=1000&auto=format&fit=crop',
      productCount: 8,
    ),
    CategoryModel(
      id: 3,
      name: 'Processors',
      imagePath:
          'https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea?q=80&w=1000&auto=format&fit=crop',
      productCount: 12,
    ),
  ];

  static List<ProductModel> bestOffers = [
    ProductModel(
      id: 1,
      name:
          'Acer SA100 SATAIII SSD Drive Acer SA100 SATAIII SSD Drive Acer SA100 SATAIII SSD Drive',
      category: 'Hard Drives',
      description:
          'Acer SA100 SATAIII SSD Drive Acer SA100 SATAIII SSD Drive Acer SA100 SATAIII SSD Drive',
      imagePath: [
        'https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea?q=80&w=1000&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea?q=80&w=1000&auto=format&fit=crop',
      ],
      rating: 4.0,
      price: 50000.0,
      oldPrice: 60000.0,
      inStock: true,
      isHot: true,
      isNew: true,
      colors: [
        Colors.red,
        Colors.blue,
        Colors.green,
        Colors.red,
        Colors.blue,
        Colors.green,
        Colors.red,
        Colors.blue,
        Colors.green,
      ],
    ),
    ProductModel(
      id: 2,
      name: 'Magic Ultra Mini USB Card Readers',
      category: 'Accessories',
      description:
          'Magic Ultra Mini USB Card Readers Magic Ultra Mini USB Card Readers Magic Ultra Mini USB Card Readers',
      imagePath: [
        'https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea?q=80&w=1000&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea?q=80&w=1000&auto=format&fit=crop',
      ],
      rating: 3.5,
      price: 30.0,
      inStock: true,
      isHot: true,
      colors: [Colors.red, Colors.blue, Colors.green],
    ),
    ProductModel(
      id: 3,
      name: 'Acer SA100 SATAIII SSD Drive',
      category: 'Hard Drives',
      description:
          'Acer SA100 SATAIII SSD Drive Acer SA100 SATAIII SSD Drive Acer SA100 SATAIII SSD Drive',
      imagePath: [
        'https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea?q=80&w=1000&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea?q=80&w=1000&auto=format&fit=crop',
      ],
      rating: 4.0,
      price: 50.0,
      oldPrice: 60.0,
      inStock: true,
      isHot: true,
      colors: [Colors.red, Colors.blue, Colors.green],
    ),
    ProductModel(
      id: 4,
      name: 'Magic Ultra Mini USB Card Readers',
      category: 'Accessories',
      description:
          'Magic Ultra Mini USB Card Readers Magic Ultra Mini USB Card Readers Magic Ultra Mini USB Card Readers',
      imagePath: [
        'https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea?q=80&w=1000&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea?q=80&w=1000&auto=format&fit=crop',
      ],
      rating: 3.5,
      price: 30.0,
      inStock: true,
      isHot: true,
    ),
  ];
}
