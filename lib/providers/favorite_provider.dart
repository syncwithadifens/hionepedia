import 'package:flutter/material.dart';
import 'package:hionepedia/models/favorite_model.dart';
import 'package:hionepedia/services/api_repository.dart';

class FavoriteProvider extends ChangeNotifier {
  FavoriteModel? favoriteData;
  bool isLoading = false;
  bool isSuccess = false;
  Map favoriteItem = {};

  Future<void> getFavoriteData() async {
    isLoading = true;
    favoriteData = await ApiRepository.getFavoriteData();
    if (favoriteData != null) {
      isLoading = false;
      isSuccess = true;
      for (int i = 0; i < favoriteData!.favorited!.length; i++) {
        favoriteItem[favoriteData!.favorited![i].animalId] =
            favoriteData!.favorited![i].favoriteId!;
      }
      notifyListeners();
    } else {
      isLoading = false;
      isSuccess = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(String animalId) async {
    final isExist = favoriteItem.containsKey(animalId);
    if (isExist) {
      String favoriteId = favoriteItem[animalId];
      final response = await ApiRepository.removeFromFavorite(favoriteId);
      if (response == true) {
        favoriteItem.remove(animalId);
        notifyListeners();
      } else {
        debugPrint('Gagal hapus favorite');
      }
    } else {
      AddFav response = await ApiRepository.addToFavorite(animalId);
      if (response.message == 'Added to favorite') {
        favoriteItem[animalId] = response.favoriteId;
        notifyListeners();
      } else {
        debugPrint('Gagal tambah favorite');
      }
    }
  }
}
