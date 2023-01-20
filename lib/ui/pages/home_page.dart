import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hionepedia/controllers/animal_controller.dart';
import 'package:hionepedia/services/http_service.dart';
import 'package:hionepedia/theme/styles.dart';
import 'package:hionepedia/ui/pages/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final animalCtrl = Get.put(AnimalController());
    return Scaffold(
      backgroundColor: whiteColor,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: whiteColor,
            statusBarIconBrightness: Brightness.dark),
        child: SafeArea(
          child: Obx(
            () => animalCtrl.isLoading.isTrue
                ? const Center(child: CircularProgressIndicator())
                : animalCtrl.animalData == null
                    ? const Text('Data Kosong')
                    : GridView.custom(
                        gridDelegate: SliverQuiltedGridDelegate(
                            crossAxisCount: 4,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            pattern: [
                              const QuiltedGridTile(4, 2),
                              const QuiltedGridTile(2, 2),
                              const QuiltedGridTile(2, 2),
                              const QuiltedGridTile(2, 2),
                              const QuiltedGridTile(2, 2),
                            ]),
                        childrenDelegate: SliverChildBuilderDelegate(
                          childCount: animalCtrl.animalData!.data.length,
                          (context, index) => GestureDetector(
                            onTap: () => Get.to(DetailPage(
                              animalData: animalCtrl.animalData!.data[index],
                            )),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      '${HttpService.apiUrl}/thumbnail/${animalCtrl.animalData!.data[index].thumbnail}'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
