import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hionepedia/models/animal_model.dart';
import 'package:hionepedia/services/http_service.dart';

class AnimalController extends GetxController {
  HttpService httpService = HttpService();
  AnimalModel? animalData;
  final isLoading = false.obs;

  Future<void> getAnimalData() async {
    try {
      isLoading.value = true;
      final result = await httpService.getAllData();
      if (result.message == 'success') {
        isLoading.value = false;
        animalData = result;
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAnimalData();
  }
}
