import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hionepedia/controllers/animal_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final animalCtrl = Get.put(AnimalController());
    return Scaffold(
      body: SafeArea(
          child: Obx(() => animalCtrl.isLoading.isTrue
              ? const CircularProgressIndicator()
              : animalCtrl.animalData == null
                  ? const Text('Data Kosong')
                  : ListView.builder(
                      itemCount: animalCtrl.animalData!.data.length,
                      itemBuilder: (context, index) {
                        return Text(animalCtrl.animalData!.data[index].name);
                      },
                    ))),
    );
  }
}
