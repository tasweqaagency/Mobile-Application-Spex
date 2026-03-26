import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:spex/feature/home/model/product_model.dart';
import 'package:spex/feature/product_details/model/mini_product_model.dart';

abstract class ProductDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductDetailsInitialState extends ProductDetailsState {}

class ProductDetailsLoadingState extends ProductDetailsState {}

class ProductDetailsLoadedState extends ProductDetailsState {
  final SimplifiedProductModel product;
  final List<SimplifiedProductModel> giftProducts;
  final List<SimplifiedProductModel> fbtProducts;
  final List<SimplifiedProductModel> relatedProducts;

  // Selection state
  final Color? selectedColor;
  final String? selectedSize;
  final Variations? matchedVariation;

  final bool isRefreshing;

  ProductDetailsLoadedState({
    required this.product,
    this.giftProducts = const [],
    this.fbtProducts = const [],
    this.relatedProducts = const [],
    this.selectedColor,
    this.selectedSize,
    this.matchedVariation,
    this.isRefreshing = false,
  });

  ProductDetailsLoadedState copyWith({
    SimplifiedProductModel? product,
    List<SimplifiedProductModel>? giftProducts,
    List<SimplifiedProductModel>? fbtProducts,
    List<SimplifiedProductModel>? relatedProducts,
    Color? selectedColor,
    String? selectedSize,
    Variations? matchedVariation,
    bool? isRefreshing,
  }) {
    return ProductDetailsLoadedState(
      product: product ?? this.product,
      giftProducts: giftProducts ?? this.giftProducts,
      fbtProducts: fbtProducts ?? this.fbtProducts,
      relatedProducts: relatedProducts ?? this.relatedProducts,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
      matchedVariation: matchedVariation ?? this.matchedVariation,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [
        product,
        giftProducts,
        fbtProducts,
        relatedProducts,
        selectedColor,
        selectedSize,
        matchedVariation,
        isRefreshing,
      ];
}

class ProductDetailsErrorState extends ProductDetailsState {
  final String errorMessage;

  ProductDetailsErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
