import 'package:flutter/material.dart';
import 'package:hionepedia/models/animal_model.dart';
import 'package:hionepedia/services/api_repository.dart';

class AnimalProvider extends ChangeNotifier {
  AnimalModel? animalData;
  bool isLoading = false;
  bool isSuccess = false;

  Future<void> getAnimalData() async {
    isLoading = true;
    animalData = await ApiRepository.getAllData();
    if (animalData != null) {
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
