import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../model/fav_model.dart';
import 'fav_state.dart';


class FavCubit extends Cubit<FavState> {
  final Box<FavItem> favBox;

  FavCubit(this.favBox) : super(FavoritesInitial()) {
    loadFavorites();
  }

  // Load fav from Hive
  void loadFavorites() {
    final items = favBox.values.toList();
    emit(FavoritesLoaded(items));
  }

  // Add to Fav
  Future<void> addFavorite(FavItem item) async {
    if (!favBox.containsKey(item.productId)) {
      await favBox.put(item.productId, item);
      loadFavorites();
    }
  }

  // Remove from Fav
  Future<void> removeFavorite(int productId) async {
    await favBox.delete(productId);
    loadFavorites();
  }

  // Toggle Fav
  Future<void> toggleFavorite(FavItem item) async {
    if (favBox.containsKey(item.productId)) {
      await removeFavorite(item.productId);
    } else {
      await addFavorite(item);
    }
  }

  // Check if Fav
  bool isFavorite(int productId) {
    return favBox.containsKey(productId);
  }

  // Clear Fav
  Future<void> clearFavorites() async {
    await favBox.clear();
    loadFavorites();
  }
}
