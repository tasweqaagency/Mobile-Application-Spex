import 'package:hive_flutter/hive_flutter.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/feature/home/model/product_model.dart';

abstract class FavoriteLocalDataSource {
  Future<List<SimplifiedProductModel>> getFavorites();
  Future<void> addFavorite(SimplifiedProductModel product);
  Future<void> removeFavorite(int productId);
  Future<bool> isFavorite(int productId);
}

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  @override
  Future<List<SimplifiedProductModel>> getFavorites() async {
    final box = await Hive.openBox(ServicesConstants.FAVORITES_BOX);
    return box.values
        .map(
          (e) => SimplifiedProductModel.fromJson(Map<String, dynamic>.from(e)),
        )
        .toList();
  }

  @override
  Future<void> addFavorite(SimplifiedProductModel product) async {
    final box = await Hive.openBox(ServicesConstants.FAVORITES_BOX);
    await box.put(product.id, product.toJson());
  }

  @override
  Future<void> removeFavorite(int productId) async {
    final box = await Hive.openBox(ServicesConstants.FAVORITES_BOX);
    await box.delete(productId);
  }

  @override
  Future<bool> isFavorite(int productId) async {
    final box = await Hive.openBox(ServicesConstants.FAVORITES_BOX);
    return box.containsKey(productId);
  }
}
