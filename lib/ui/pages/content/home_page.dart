import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hionepedia/providers/animal_provider.dart';
import 'package:hionepedia/services/api_repository.dart';
import 'package:hionepedia/ui/pages/content/detail_page.dart';
import 'package:hionepedia/ui/widgets/error.dart';
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
                        horizontal: 30, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Hai, yourname',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Image.asset(
                          'assets/avatar/default_avatar.png',
                          width: 100,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 180,
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.grey),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 20),
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
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.teal),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                    '${ApiRepository.apiUrl}/img/${animalProvider.animalData!.animal![index].thumbnail}'),
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
