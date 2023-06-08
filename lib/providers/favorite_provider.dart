import 'package:flutter/material.dart';
import 'package:hionepedia/models/favorite_model.dart';
import 'package:hionepedia/services/api_repository.dart';

class FavoriteProvider extends ChangeNotifier {
  FavoriteModel? favoriteData;
  bool isLoading = false;
  bool isSuccess = false;

  Future<void> getFavoriteData() async {
    isLoading = true;
    favoriteData = await ApiRepository.getFavoriteData();
    if (favoriteData != null) {
      isLoading = false;
      isSuccess = true;
      notifyListeners();
    } else {
      isLoading = false;
      isSuccess = false;
      notifyListeners();
    }
  }
}
