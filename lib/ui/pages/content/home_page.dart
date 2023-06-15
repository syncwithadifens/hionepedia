import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hionepedia/extensions/custom_extension.dart';
import 'package:hionepedia/providers/animal_provider.dart';
import 'package:hionepedia/services/api_repository.dart';
import 'package:hionepedia/theme/styles.dart';
import 'package:hionepedia/ui/pages/content/detail_page.dart';
import 'package:hionepedia/ui/widgets/error.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<AnimalProvider>(context, listen: false).getAnimalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myBox = Hive.box('userBox');
    final userActive = myBox.get('userActive');

    final animalProvider = Provider.of<AnimalProvider>(context);
    return animalProvider.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : animalProvider.isSuccess
            ? ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hai, ${userActive[1].toString().toTitleCase()}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Image.asset(
                          'assets/avatar/default_avatar.png',
                          height: 80,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 180,
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                gradient: LinearGradient(
                                    colors: [primaryColor, lightGrey])),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 20,
                          right: 30,
                          child: Text(
                            'Yuk mulai mengenal hewan langka',
                            style: titleStyle.copyWith(
                                color: lightGrey, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Image.asset(
                              'assets/illustration/fury.png',
                              height: 150,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 0, bottom: 20),
                    child: MasonryGridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: animalProvider.animalData!.animal!.length,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  animalData:
                                      animalProvider.animalData!.animal![index],
                                ),
                              )),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:
                                      randomColor[index % randomColor.length]),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  '${ApiRepository.apiUrl}/img/${animalProvider.animalData!.animal![index].thumbnail}',
                                  fit: BoxFit.cover,
                                ),
                              )),
                        );
                      },
                    ),
                  ),
                ],
              )
            : const IsError();
  }
}
