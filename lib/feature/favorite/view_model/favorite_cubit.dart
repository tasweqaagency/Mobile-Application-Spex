import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/feature/favorite/data/favorite_local_data_source.dart';
import 'package:spex/feature/favorite/view_model/favorite_state.dart';
import 'package:spex/feature/home/model/product_model.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteLocalDataSource localDataSource;

  FavoriteCubit(this.localDataSource) : super(FavoriteInitial());

  Future<void> getFavorites() async {
    emit(FavoriteLoading());
    try {
      final favorites = await localDataSource.getFavorites();
      emit(FavoriteLoaded(favorites));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> toggleFavorite(SimplifiedProductModel product) async {
    try {
      final isFav = await localDataSource.isFavorite(product.id);
      if (isFav) {
        await localDataSource.removeFavorite(product.id);
      } else {
        await localDataSource.addFavorite(product);
      }
      // Refresh list
      final favorites = await localDataSource.getFavorites();
      emit(FavoriteLoaded(favorites));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<bool> isFavorite(int productId) async {
    return await localDataSource.isFavorite(productId);
  }
}
